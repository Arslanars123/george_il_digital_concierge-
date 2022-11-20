import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/service_detail_without_code.dart';

import '../config/colors.dart';
import '../global.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ServicesListWithout extends StatefulWidget {
   ServicesListWithout({Key? key,required this.data}) : super(key: key);
 dynamic data;
  final serv = 'http://giovannis37.sg-host.com/';
  @override
  State<ServicesListWithout> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesListWithout> {
  var connectivity = 'yes';
  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var prefs = await SharedPreferences.getInstance();
      var url = 'http://giovannis37.sg-host.com/api/get-category-of-services';
      Map data = {'user_id': prefs.getInt('id'),

        'category_id' : widget.data['id']
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      var decode = jsonDecode(response.body);

      setState(() {
        connectivity = 'yes';
        widget.data = decode['data'];
      });
      print(widget.data);
    } else {
      setState(() {
        connectivity = '';
      });
    }

  }
  @override
  void initState() {
    internet();
    print(widget.data);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: internet,
      child: ListView(
        children: [
          Container(
            height: displayHeight,
            width: displayWidth,
            child: SafeArea(
              child: Scaffold(
                body: Column(
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
                        height: displayHeight/15,
                        child:Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,top: 5),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios,color: Colors.white,size: 15,),
                                      Text(english == true ?'Back':'indietro',style: TextStyle(color:Colors.white,fontSize: displayWidth/21),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  child: english == true ?
                                  Text('Services',style: TextStyle(fontSize: MediaQuery.of(context).size.width/18,fontWeight: FontWeight.bold,color: Colors.white),): Text('Servizi',style: TextStyle(fontSize: MediaQuery.of(context).size.width/18,color: Colors.white,fontWeight: FontWeight.bold)
                              ),
                            ),
                            )],
                        )
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/30,),
                    Expanded(
                      child: widget.data['services'] == null ? Container(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator()) :
                      ListView.builder(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/30,right:MediaQuery.of(context).size.width/30 ),
                          itemCount: widget.data['services'].length,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ServiceDetails(data: widget.data['services'][index],)),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(

                                          width: displayWidth/7,
                                          height: displayHeight/13,
                                          child:
                                          widget.data['services'][index]['image'] != null ?
                                          CachedNetworkImage(
                                            imageUrl:  widget.serv+widget.data['services'][index]['image'],
                                            placeholder: (context, url) => Image.asset('assets/noimage.png'),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ) : Image.asset('assets/noimage.png')
                                      ),
                                            SizedBox(width: displayWidth*0.02,),
                                      Container(

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            english == true ?
                                            Text(widget.data['services'][index]['name'] != null ? widget.data['services'][index]['name'] : '',style: TextStyle(fontSize: displayWidth/18),):  Text(widget.data['services'][index]['name'] != null ? widget.data['services'][index]['name'] : '',style: TextStyle(fontSize: 17),maxLines: 1,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    height: displayHeight * 0.04,
                                    width: displayWidth*0.05,
                                    child: const Icon(Icons.favorite, size: 10, color: Colors.white,),
                                    decoration: const BoxDecoration( color: Colors.pinkAccent, shape: BoxShape.circle, ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
