import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/test/hotel_services.dart';
import 'package:untitled6/test/products_hotel_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/colors.dart';
import 'package:http/http.dart' as http;
class ShopScreen extends StatefulWidget {
  ShopScreen({Key? key, required this.data,required this.info,required this.userdata}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
   dynamic data;
  final dynamic info;
  final dynamic userdata;
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}
class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  var commonColor = const Color.fromRGBO(94, 112, 224, 1);
  var connectivity = 'yes';
  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var prefs = await SharedPreferences.getInstance();
      var url = 'http://giovannis37.sg-host.com/api/get-hotel-detail';
      Map data = {'user_id': prefs.getInt('id'),};
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      var decode = jsonDecode(response.body);
      print(decode);
      setState(() {
        connectivity = 'yes';
        widget.data = decode['data'];
      });
    } else {
      setState(() {
        connectivity = '';
      });
    }
    print('arslan ye  categories hn');

    print(connectivity);
  }
  test()async{
    var pref = await SharedPreferences.getInstance();
    print(pref.getInt('id'));
  }
  void initState() {
internet();
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
                body:  DefaultTabController(
                  length: 2,
                  child:
                   Column(
                      children: [
                        Container(
                            height: displayHeight/15,
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
                            child:Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(

                                    child: Text(english == true ? 'Shop' :'Negozio',style: TextStyle(fontSize: MediaQuery.of(context).size.width/17,fontWeight: FontWeight.bold,color: Colors.white),),
                                  ),

                                )
                              ],
                            )
                        ),
                        Container(
                          height: displayHeight/15,
                          child: TabBar(
                            labelStyle: TextStyle(fontSize: 19),
                            indicatorColor: forgotColor,
                            isScrollable: true,
                            labelColor: forgotColor,
                            unselectedLabelColor: Colors.grey,
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: forgotColor,width: 1),
                              insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                            ),
                            tabs: [
                              Text(english == true ?'Products':'prodotti'),
                              Text(english == true ?'Services':'Servizi'),

                            ],
                          ),
                        ),
                         Expanded(
                           child: TabBarView(
                            children: [
                            HotelProducts(data: widget.data,info: widget.info,userdata:widget.userdata),
                            HotelServices(data: widget.data,info: widget.info,userdata:widget.userdata)

                            ],
                        ),
                         ),
                      ],

                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
