import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:untitled6/config/colors.dart';
import 'overview.dart';

import 'package:untitled6/favourite_screen.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/messages_screen.dart';
import 'package:untitled6/product_screen.dart';
import 'package:untitled6/hote_review_code.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:untitled6/without_code_setting.dart';

class DisableDestination extends StatefulWidget {
  DisableDestination({Key? key, required this.hotel}) : super(key: key);

   dynamic hotel;

  @override
  _State createState() => _State();
}

class _State extends State<DisableDestination> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  int state = 1;
  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var prefs = await SharedPreferences.getInstance();
      var url = 'http://giovannis37.sg-host.com/api/get-hotel-detail2';
      Map data = {'user_id': prefs.getInt('id'),
        'hotel_id' : widget.hotel['id']
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      var decode = jsonDecode(response.body);
      print(decode);
      setState(() {
        connectivity = 'yes';
        widget.hotel = decode['data'];
      });
    } else {
      setState(() {
        connectivity = '';
      });
    }
    print(connectivity);
  }
  @override
  void initState() {
internet();
    print(widget.hotel);
    super.initState();
  }
  var connectivity = 'yes';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: internet,
      child: ListView(
        children: [
          Container(
            height: height,
            width: width,
            child: SafeArea(
              child: Scaffold(
                body: Container(
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      children: [
                        Container(
                            /* leading: Image.asset('assets/side_bar_menu.png',scale: 1.7,),*/

                            height: height / 15,
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
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
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
                                                fontSize: width / 21),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      'Hotel',
                                      style: TextStyle(
                                          fontSize: width / 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WithoutCodeSetting(hotel: widget.hotel,)),
                                            );
                                            },
                                          child: Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                          )),
                                    ))
                              ],
                            )),
                        SizedBox(height: height/80,),
                        widget.hotel['show'] == 'name' ?
                        Container(
                          child: Text( widget.hotel['name'],style: TextStyle(fontSize: width/15,fontWeight: FontWeight.bold,color: signColor),),
                        ):widget.hotel['show']== 'logo' ?Container(
                          child: Image.network('http://giovannis37.sg-host.com/'+ widget.hotel['logo'],height: MediaQuery.of(context).size.height/13,width: MediaQuery.of(context).size.width/5,),
                        ): Container(
                          child: Text( widget.hotel['name'],style: TextStyle(fontSize: width/15,fontWeight: FontWeight.bold,color: signColor),),
                        ),
                        SizedBox(height: height/80,),
                        widget.hotel['image'] != null ?
                        Container(
                          width: width,
                          height: height / 3,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "http://giovannis37.sg-host.com/" +
                                widget.hotel['image'],
                            placeholder: (context, url) =>
                                Image.asset('assets/noimage.png'),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ): Container(
                          width: width,
                          height: height / 3,
                          child:Image.asset('assets/noimage.png')
                        ),
                        TabBar(
                          padding: EdgeInsets.all(0),
                          labelStyle: TextStyle(fontSize: 19),
                          isScrollable: true,
                          labelColor: Color.fromRGBO(83, 82, 236, 1),
                          unselectedLabelColor: Colors.grey,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(color: forgotColor),
                            insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          ),
                          tabs: [
                            Tab(
                              text: english == true ? 'Overview' : 'Panoramica',
                            ),
                            Tab(
                              text: english == true ? 'Shop' : 'Shop',
                            ),
                            Tab(
                              text: english == true ? 'Experiences' : 'Esperienze',
                            ),
                            Tab(
                              text: english == true ? 'Reviews' : 'Recensioni',
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            child: TabBarView(
                              children: [
                                Overview(
                                  data: widget.hotel,
                                ),
                                ProductScreen(
                                  data: widget.hotel,
                                ),
                                FavouriteScreen(
                                  data: widget.hotel,
                                ),
                                ReviewsScreenCode(
                                  data: widget.hotel,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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

class BezierClipper extends CustomClipper<Path> {
  final int state;

  BezierClipper(this.state);

  // Path _getInitialClip(Size size) {
  //   Path path = Path();
  //   final double _xScaling = size.width / 414;
  //   final double _yScaling = size.height / 363.15;
  //   path.lineTo(-0.003999999999997783 * _xScaling,341.78499999999997 * _yScaling);
  //   path.cubicTo(-0.003999999999997783 * _xScaling,341.78499999999997 * _yScaling,23.461000000000002 * _xScaling,363.15099999999995 * _yScaling,71.553 * _xScaling,363.15099999999995 * _yScaling,);
  //   path.cubicTo(119.645 * _xScaling,363.15099999999995 * _yScaling,142.21699999999998 * _xScaling,300.186 * _yScaling,203.29500000000002 * _xScaling,307.21 * _yScaling,);
  //   path.cubicTo(264.373 * _xScaling,314.234 * _yScaling,282.666 * _xScaling,333.47299999999996 * _yScaling,338.408 * _xScaling,333.47299999999996 * _yScaling,);
  //   path.cubicTo(394.15000000000003 * _xScaling,333.47299999999996 * _yScaling,413.99600000000004 * _xScaling,254.199 * _yScaling,413.99600000000004 * _xScaling,254.199 * _yScaling,);
  //   path.cubicTo(413.99600000000004 * _xScaling,254.199 * _yScaling,413.99600000000004 * _xScaling,0 * _yScaling,413.99600000000004 * _xScaling,0 * _yScaling,);
  //   path.cubicTo(413.99600000000004 * _xScaling,0 * _yScaling,-0.003999999999976467 * _xScaling,0 * _yScaling,-0.003999999999976467 * _xScaling,0 * _yScaling,);
  //   path.cubicTo(-0.003999999999976467 * _xScaling,0 * _yScaling,-0.003999999999997783 * _xScaling,341.78499999999997 * _yScaling,-0.003999999999997783 * _xScaling,341.78499999999997 * _yScaling,);
  //   return path;
  // }

  @override
  Path getActualClip(Size size) {
    Path path = Path();
    // final double _xScaling = size.width / 415;
    // final double _yScaling = size.height / 896;
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 700;
    path.lineTo(0 * _xScaling, 0 * _yScaling);
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      360 * _xScaling,
      0 * _yScaling,
      360 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      360 * _xScaling,
      0 * _yScaling,
      360 * _xScaling,
      453 * _yScaling,
      360 * _xScaling,
      453 * _yScaling,
    );
    path.cubicTo(
      360 * _xScaling,
      453 * _yScaling,
      327.75 * _xScaling,
      420.5 * _yScaling,
      305 * _xScaling,
      453 * _yScaling,
    );
    path.cubicTo(
      298 * _xScaling,
      463 * _yScaling,
      285.908 * _xScaling,
      481 * _yScaling,
      261.5 * _xScaling,
      481 * _yScaling,
    );
    path.cubicTo(
      237.092 * _xScaling,
      481 * _yScaling,
      224.177 * _xScaling,
      453 * _yScaling,
      209 * _xScaling,
      453 * _yScaling,
    );
    path.cubicTo(
      173.853 * _xScaling,
      453 * _yScaling,
      177.5 * _xScaling,
      497.5 * _yScaling,
      132.5 * _xScaling,
      497.5 * _yScaling,
    );
    path.cubicTo(
      87.5 * _xScaling,
      497.5 * _yScaling,
      80.1472 * _xScaling,
      419 * _yScaling,
      45 * _xScaling,
      419 * _yScaling,
    );
    path.cubicTo(
      9.85281 * _xScaling,
      419 * _yScaling,
      0 * _xScaling,
      453 * _yScaling,
      0 * _xScaling,
      453 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      453 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
    );
    return path;
  }

  Path _getFinalClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 301.69;
    path.lineTo(-0.003999999999997783 * _xScaling, 217.841 * _yScaling);
    path.cubicTo(
      -0.003999999999997783 * _xScaling,
      217.841 * _yScaling,
      19.14 * _xScaling,
      265.91999999999996 * _yScaling,
      67.233 * _xScaling,
      265.91999999999996 * _yScaling,
    );
    path.cubicTo(
      115.326 * _xScaling,
      265.91999999999996 * _yScaling,
      112.752 * _xScaling,
      234.611 * _yScaling,
      173.83299999999997 * _xScaling,
      241.635 * _yScaling,
    );
    path.cubicTo(
      234.914 * _xScaling,
      248.659 * _yScaling,
      272.866 * _xScaling,
      301.691 * _yScaling,
      328.608 * _xScaling,
      301.691 * _yScaling,
    );
    path.cubicTo(
      384.34999999999997 * _xScaling,
      301.691 * _yScaling,
      413.99600000000004 * _xScaling,
      201.977 * _yScaling,
      413.99600000000004 * _xScaling,
      201.977 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      201.977 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999997783 * _xScaling,
      217.841 * _yScaling,
      -0.003999999999997783 * _xScaling,
      217.841 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) => getActualClip(size);
}
