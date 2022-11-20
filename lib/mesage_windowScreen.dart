import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/internet_connection.dart';
import 'package:untitled6/product_screen.dart';
import 'package:untitled6/profile_screen.dart';
import 'package:untitled6/test/bottom_bar.dart';
import 'list_chat.dart';
import 'package:http/http.dart' as http;

class DataScreens extends StatefulWidget {
  DataScreens(
      {Key? key,
      required this.data,
      required this.userdata,
      required this.checkInfo})
      : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic userdata;
  final dynamic checkInfo;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<DataScreens> {
  var name = 'arslan';
  var decode;
  var a;
  var timer;
  List shoaibakhtar = [];
  TextEditingController message = TextEditingController();
  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  Future<http.Response> history() async {
    var pref = await SharedPreferences.getInstance();
    pref.getInt('id');
    print(pref.getInt('id'));
    var url = 'http://giovannis37.sg-host.com/api/get-history';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {'user_id': prefs.getInt('id'), 'hotel_id': widget.data['id']};
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    decode = jsonDecode(response.body);

    a = decode['data'];

    setState(() {
      shoaibakhtar = a;
    });

    _scrollDown();
    print(decode['data']);
    return response;
  }

  void fetchStr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = 'http://giovannis37.sg-host.com/api/send-message';
    Map data = {
      'customer_id': prefs.getInt('id'),
      'hotel_id': widget.data['id'],
      'message': message.text
    };
    print(prefs.getInt('id'));
    //encode Map to JSON

    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var a = jsonDecode(response.body);
  }

  var connectivity = 'yes';
  internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      setState(() {
        connectivity = 'yes';
      });
    } else {
      setState(() {
        connectivity = '';
      });
    }
  }

  @override
  void initState() {
    internet();
    super.initState();
    Future.delayed(Duration.zero, () async {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) => history());
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return connectivity == 'yes'
        ? SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  color: Colors.grey.withOpacity(0.2),
                  child: Stack(children: [
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff4857dd),
                                  Color(0xff744fdb),
                                  Color(0xffa448db),
                                ],
                              ),
                            ),
                            height: height / 15,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      print(widget.userdata);
                                    },
                                    child: Container(
                                      child: Text(
                                        english == true
                                            ? 'Messages'
                                            : 'Messaggi',
                                        style: TextStyle(
                                            fontSize: width / 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Container(
                                      color: Colors.transparent,
                                      child: a == null
                                          ? Container(
                                              height: 20,
                                              width: 33,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: forgotColor,
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              controller: _controller,
                                              itemCount: a.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      left: 14,
                                                      right: 14,
                                                      top: 10,
                                                      bottom: 10),
                                                  child:
                                                      a[index]['sender'] ==
                                                              "customer"
                                                          ? Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: (a[index]['message'] ==
                                                                                "customer"
                                                                            ? Colors.grey.shade200
                                                                            : forgotColor.withOpacity(0.8)),
                                                                      ),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16),
                                                                      child:
                                                                          Text(
                                                                        a[index]['message'] !=
                                                                                null
                                                                            ? a[index]['message']
                                                                            : '',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width /
                                                                            100,
                                                                  ),
                                                                  userimage !=
                                                                          null
                                                                      ? Container(
                                                                          height:
                                                                              height / 10,
                                                                          width:
                                                                              width / 14,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(widget.serv + userimage))),
                                                                        )
                                                                      : Container(
                                                                          height: height /
                                                                              10,
                                                                          width: width /
                                                                              14,
                                                                          child:
                                                                              Icon(
                                                                            Icons.person,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          )),
                                                                ],
                                                              ),
                                                            )
                                                          : Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  widget.data['logo'] !=
                                                                          null
                                                                      ? Container(
                                                                          height:
                                                                              height / 10,
                                                                          width:
                                                                              width / 14,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: NetworkImage(widget.serv + widget.data['logo']))),
                                                                        )
                                                                      : Container(
                                                                          height: height /
                                                                              10,
                                                                          width: width /
                                                                              14,
                                                                          child:
                                                                              Icon(
                                                                            Icons.person,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          )),
                                                                  SizedBox(
                                                                    width:
                                                                        width /
                                                                            100,
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: (a[index]['message'] ==
                                                                                "customer"
                                                                            ? Colors.grey.shade200
                                                                            : Colors.grey.withOpacity(0.6)),
                                                                      ),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16),
                                                                      child:
                                                                          Text(
                                                                        a[index]['message'] !=
                                                                                null
                                                                            ? a[index]['message']
                                                                            : '',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                );

                                                /*                      Container(
                                                  child:  Align(
                                                alignment: (a[index]['sender'] == "customer"?Alignment.topRight:Alignment.topLeft),
                                                child: Row(
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  children: [


                                                    Container(
                                                      decoration: BoxDecoration(

                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                                        color: (a[index]['sender']  == "customer"?forgotColor.withOpacity(0.7):Colors.grey.withOpacity(0.5)),
                                                      ),
                                                      padding: EdgeInsets.all(16),
                                                      child: Text(a[index]['message'] != null ? a[index]['message'] : '', style: TextStyle(fontSize: 17,color: Colors.white),),
                                                    ),
                                                    SizedBox(width: width/100,),
                                                    CircleAvatar(
                                                      radius: width/20,
                                                      backgroundImage: NetworkImage(widget.serv+userimage),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                                  ),*/
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: height / 22,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width / 30,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: height / 17,
                                              child: /*TextField(
                                              controller: message,
                                              decoration: InputDecoration(

                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText: 'Enter Here...',
                                                hintStyle: TextStyle(
                                                    color: signColor.withOpacity(0.5),
                                                    fontSize: 16),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                ),
                                              ))*/
                                                  Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border:
                                                        Border.all(width: 1)),
                                                height: height / 5,
                                                child: TextFormField(
                                                  controller: message,
                                                  cursorColor: Colors.black,
                                                  decoration: new InputDecoration(
                                                      contentPadding: EdgeInsets
                                                          .only(
                                                              top: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  75,
                                                              left: 10),
                                                      isDense: true,
                                                      border: InputBorder.none,
                                                      hintText: 'Write Here',
                                                      hintStyle:
                                                          TextStyle(
                                                              color: signColor
                                                                  .withOpacity(
                                                                      0.3),
                                                              fontSize: 15)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          /*   InkWell(
                                     onTap: (){
                                       fetchStr();
                                     },
                                     child: Container(

                                       height: height/30,
                                       width: width/8,
                                       child: Icon(
                                          Icons.send,
                                          color:  forgotColor.withOpacity(0.5),
                                        ),
                                     ),
                                   ),*/
                                          SizedBox(
                                            width: width / 100,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              fetchStr();
                                            },
                                            child: CircleAvatar(
                                                radius: width / 15,
                                                backgroundColor: forgotColor,
                                                foregroundColor: Colors.white,
                                                child: Icon(Icons.send)),
                                          ),
                                          SizedBox(
                                            width: width / 30,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height / 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
                )),
          )
        : InternetConnection();
  }
}
