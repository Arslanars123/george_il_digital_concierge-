import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/test/three_screen.dart';
import 'package:http/http.dart' as http;
import 'global.dart';

class ProductListCode extends StatefulWidget {
  ProductListCode(
      {Key? key,
      required this.hotel,
      required this.realhotel,
      required this.info,
      required this.userdata})
      : super(key: key);
  final dynamic realhotel;
  dynamic hotel;
  final dynamic info;
  final dynamic userdata;

  @override
  State<ProductListCode> createState() => _ProductListState();
}

class _ProductListState extends State<ProductListCode> {
  @override
  var connectivity = 'yes';
  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var prefs = await SharedPreferences.getInstance();
      var url = 'http://giovannis37.sg-host.com/api/get-category-of-products';
      Map data = {
        'user_id': prefs.getInt('id'),
        'category_id': widget.hotel['id']
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      var decode = jsonDecode(response.body);
      setState(() {
        connectivity = 'yes';
        widget.hotel = decode['data'];
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
    print(widget.hotel);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: internet,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: height,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: Color(0xFFEAEAEA),
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
                        height: MediaQuery.of(context).size.height / 15,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, left: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(
                                        english == true ? 'Back' : 'indietro',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              19,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Products',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: GridView.count(
                              crossAxisCount: 2,
                              padding: EdgeInsets.only(bottom: 20, top: 10),
                              children: List.generate(
                                  widget.hotel['products'].length, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 60,
                                    left:
                                        MediaQuery.of(context).size.width / 60,
                                    right:
                                        MediaQuery.of(context).size.width / 60,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => ThreeScreen(data: widget.hotel['products'][index], realhotel: widget.realhotel, info: widget.info, userdata: widget.userdata)),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context).size.height / 300,
                                                left: MediaQuery.of(context).size.width /80,
                                                right: MediaQuery.of(context).size.width /80,
                                                bottom: MediaQuery.of(context).size.height / 120
                                            ),
                                            child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  child: Container(
                                                  height: MediaQuery.of(context).size.height /8,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage('http://giovannis37.sg-host.com/' + widget.hotel['products'][index]['image']))),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(padding: EdgeInsets.only(
                                              right: MediaQuery.of(context).size.height / 80,
                                              left: MediaQuery.of(context).size.height / 80,
                                              ),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(context).size.height / 300,
                                                      ),
                                                      child: Text(
                                                        widget.hotel['products'][index]['name'],
                                                        style: TextStyle(color: forgotColor, fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold), maxLines: 1, textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text('Price ' + widget.hotel['products'][index]['price'].toString() + ' \u{20AC}',
                                                      style: TextStyle(color: forgotColor, fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold), maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }))),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
