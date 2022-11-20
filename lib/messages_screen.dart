import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/global.dart';
import 'package:http/http.dart' as http;
class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.data}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {

  var decode;
  var dataCheck;
var timer;
  TextEditingController message = TextEditingController();
  Future<http.Response> fetchAlbum() async {

    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Container(
          height: 20,
          width: 20,
          child: Center(
            child: CircularProgressIndicator(
              color: forgotColor,
            ),
          ),
        );


      },
    );

    var url ='http://giovannis37.sg-host.com/api/get-history';

    Map data = {
      'user_id':userID,
      'hotel_id' :widget.data['id']


    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post( Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );


    decode = jsonDecode(response.body);
    dataCheck = decode['data'];
    print(dataCheck);

    return response;


  }
  Future <http.Response> history () async {



    var url ='http://giovannis37.sg-host.com/api/get-history';

    Map data = {
      'user_id':userID,
      'hotel_id' :widget.data['id']


    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post( Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    decode = jsonDecode(response.body);

  dataCheck= decode['data'];
    return response;


  }

  Future<http.Response> fetchStr () async {


    print(userID);
    var url ='http://giovannis37.sg-host.com/api/send-message';

    Map data = {
      'customer_id':userID,
      'hotel_id' : widget.data['id'],
      'message' : message.text
  /*    'customer_id' :userID.toString(),
      'hotel_id' : widget.data['id'],
      'message' : message,
      'no' : ,
      'customer' : ,*/

    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post( Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );



    print(jsonDecode(response.body));
    print("${response.statusCode}");
    print("${response.body}");
    return response;


  }
  int selectedIndex = 0;

  void onTapButton(index) {
    setState(() {
      selectedIndex = index;
    });
  }
  late Future<dynamic> futureAlbum;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await this.history();
      timer = Timer.periodic(Duration(seconds: 3), (Timer t) => history());
      setState(() {

      });
    });
    setIndex();

    super.initState();

  }

  void setIndex() {
    setState(() {
      selectedIndex = 1;
    });
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leadingWidth: 80,
            bottomOpacity: 0.0,
            leading: Image.asset('assets/side_bar_menu.png',scale: 1.7,),

            centerTitle: true,
            title: const Text(
              'Messages',
              style: TextStyle(
                  fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.blueGrey,
                  size: 22,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
          ),
        body: Stack(
          children: [
            Column(
              children: [



                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Container(
                              color: Colors.white,
                              child:
                              ListView.builder(
                                itemCount: dataCheck.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 10,bottom: 10),

                                itemBuilder: (context, index){
                                  return Column(
                                    children: [
                                      SizedBox(height: height/50,),
                                      Container(
                                        height:height/15,
                                        child: Align(
                                          alignment: (dataCheck[index]['sender'] == "customer"?Alignment.topRight:Alignment.topLeft),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                              color: (dataCheck[index]['sender']  == "customer"?forgotColor.withOpacity(0.5):Colors.grey.withOpacity(0.5)),
                                            ),
                                            padding: EdgeInsets.all(16),
                                            child: Text(dataCheck[index]['message'] != null ? dataCheck[index]['message'] : '', style: TextStyle(fontSize: 15),),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height/30,)
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: height/35,
                                backgroundColor: forgotColor.withOpacity(0.5),
                                child: Icon(Icons.add,color: Colors.white,),
                              ),
                              SizedBox(width: width/40,),
                              Expanded(
                                  child: TextField(
                                    controller: message,
                                      decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                          onTap: (){
                                       fetchStr();
                                       setState(() {

                                       });
                                          },
                                            child: Icon(Icons.send,color: forgotColor.withOpacity(0.5),)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Here...',
                                        hintStyle: TextStyle(color: signColor.withOpacity(0.5),fontSize: 15),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),

                                        ),
                                      )
                                  )
                              )],
                          ),
                        ),

                      ],
                    ),

                  ),
                )
              ],
            ),
  ]
        )

      ),
    );
  }
}
/*child: Container(
color: backgroundContainer,
child: Container(
color: Colors.red,
height: height/1.4,
width: width/1.1,

),
),*/
/*
Align(
alignment: Alignment.bottomCenter,
child: Container(
width: width/1.1,
child: Row(
children: [
CircleAvatar(
radius: height/25,
),
SizedBox(width: width/40,),
Expanded(
child: TextField(
decoration: InputDecoration(
suffixIcon: Icon(Icons.send,color: buttonPrimary,),
filled: true,
fillColor: Colors.white,
hintText: typeMessageText,
hintStyle: TextStyle(color: numberColor,fontSize: 12),
border: OutlineInputBorder(
borderSide: BorderSide(
width: 0,
style: BorderStyle.none,
),
borderRadius: BorderRadius.circular(10.0),

),
)
)
)],
),
),
)*/



