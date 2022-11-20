import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:untitled6/config/colors.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/global.dart';
import 'package:untitled6/signin_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProductDetailCode extends StatefulWidget {
  ProductDetailCode({Key? key, required this.data}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  dynamic data;

  @override
  State<ProductDetailCode> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetailCode> {
  var connectivity = 'yes';

  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var prefs = await SharedPreferences.getInstance();
      var url = 'http://giovannis37.sg-host.com/api/get-product-detail';
      Map data = {
        'user_id': prefs.getInt('id'),
        'product_id': widget.data['id']
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

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  Future<http.Response> fetchStr() async {
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
    print(userID);
    var url = 'http://giovannis37.sg-host.com/api/book-product';
    var preference = await SharedPreferences.getInstance();
    Map data = {
      'user_id': preference.getInt('id'),
      'product_id': widget.data['id'],
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var a = jsonDecode(response.body);
    a['message'] == 'Product booked successfully'
        ? Fluttertoast.showToast(
            msg: "Product booked successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: forgotColor,
            textColor: Colors.white,
            fontSize: 16.0)
        : Fluttertoast.showToast(
            msg: "something wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
    Navigator.pop(context);
    return response;
  }

  var name;
  var type;
  int state = 1;

  _launchURL(String url) async {
    var docUrl = 'http://giovannis37.sg-host.com/' + url;
    if (await canLaunch(docUrl)) {
      await launch(docUrl);
    } else {
      throw 'Could not launch $url';
    }
  }

  rendering(String data) {
    name = data.split('/');
    type = data.split('.');
    print(type[1]);

    return type[1] == 'jpg' ||
            type[1] == 'png' ||
            type[1] == 'jpeg' ||
            type[1] == 'svg' ||
            type[1] == 'gif'
        ? Container(
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(widget.serv + data))),
          )
        : InkWell(
            onTap: () {
              type[1] == 'pdf'
                  ? showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.zero,
                          content: Container(
                              height: MediaQuery.of(context).size.height / 1.2,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Column(
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
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
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_back_ios,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      english == true
                                                          ? 'Back'
                                                          : 'indietro',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              22),
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
                                                name[1],
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                    child: Container(
                                        child: SfPdfViewer.network(
                                      'http://giovannis37.sg-host.com/' + data,
                                      key: _pdfViewerKey,
                                    )),
                                  ),
                                ],
                              )),
                        );
                      },
                      animationType: DialogTransitionType.slideFromBottomFade,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                    )
                  : _launchURL(data);
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                  height: MediaQuery.of(context).size.height / 17,
                  width: MediaQuery.of(context).size.height / 6,
                  child: Center(
                      child: Text(
                    name[1].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
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
                      borderRadius: BorderRadius.circular(20))),
            ));
  }

  @override
  void initState() {
    internet();
    super.initState();
  }

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
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
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
                                            fontSize: width / 19),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  english == true ? 'Products' : 'Prodotti',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 15,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )),
                    SizedBox(
                      height: height / 50,
                    ),
                    widget.data['name'] != null
                        ? Text(
                            widget.data['name'],
                            style: TextStyle(
                                fontSize: width / 16,
                                fontWeight: FontWeight.bold),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 4.3,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: 'http://giovannis37.sg-host.com/' +
                            widget.data['image'],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    widget.data['dynamic'].length != 0
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4.5,
                              child: widget.data['dynamic'] != null
                                  ? ListView.builder(
                                      itemCount: widget.data['dynamic'].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5, top: 5),
                                              child: Text(
                                                widget.data['dynamic'][index]
                                                            ['label'] !=
                                                        null
                                                    ? widget.data['dynamic']
                                                        [index]['label']
                                                    : '',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            19,
                                                    color: signColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            if (widget.data['dynamic'][index]
                                                    ['type'] ==
                                                'file')
                                              rendering(widget.data['dynamic']
                                                  [index]['value']),
                                            /* Image.network('http://giovannis37.sg-host.com/'+widget.data['info'][index]['value'],),*/
                                            if (widget.data['dynamic'][index]
                                                    ['type'] !=
                                                'file')
                                              Text(
                                                widget.data['dynamic'][index]
                                                                ['value']
                                                            .toString() !=
                                                        null
                                                    ? widget.data['dynamic']
                                                            [index]['value']
                                                        .toString()
                                                    : '',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            22,
                                                    color: signColor
                                                        .withOpacity(0.3)),
                                              )
                                          ],
                                        );
                                      })
                                  : SizedBox(
                                      height: 0,
                                    ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    widget.data['images'] != null
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: InkWell(
                                  onTap: () {
                                    print(widget.data);
                                  },
                                  child: Text(
                                    english == true
                                        ? 'Image Gallery'
                                        : 'galleria di immagini',
                                    style: TextStyle(
                                        color: forgotColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  )),
                            ))
                        : SizedBox(
                            height: 0,
                          ),
                    widget.data['images'] != null
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 10,
                                top: MediaQuery.of(context).size.height / 70),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color(0xFFB7C2F6).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: widget.data['images'] == null
                                  ? Image.asset('assets/noimage.png')
                                  : Center(
                                      child: ListView.builder(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              widget.data['images'].length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      13,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              'http://giovannis37.sg-host.com/' +
                                                                  widget.data[
                                                                          'images']
                                                                      [
                                                                      index]))),
                                                )
                                              ],
                                            );
                                          }),
                                    ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Row(children: [
                              Flexible(
                                  child: Text(
                                'Price ' + widget.data['price'].toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: signColor,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              )),
                              Text(
                                ' \u{20AC} ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: signColor,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  english == true ? 'Per Person' : 'A testa',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: signColor.withOpacity(0.5),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ])),
                            Container(
                              height: MediaQuery.of(context).size.height / 16,
                              child: ElevatedButton(
                                  child: Text(
                                      english == true
                                          ? "Buy now"
                                          : 'Acquista'.toUpperCase(),
                                      style: TextStyle(fontSize: 18)),
                                  style: ButtonStyle(foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(forgotColor),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),
                                         )
                                      )
                                  ),
                                  onPressed: () {
                                    showAnimatedDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return ClassicGeneralDialogWidget(
                                          actions: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          height: height / 18,
                                                          width: width / 5,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  forgotColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Center(
                                                              child: Text(
                                                            'No',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          )))),
                                                  SizedBox(
                                                    width: width / 20,
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        fetchStr();
                                                      },
                                                      child: Container(
                                                          height: height / 18,
                                                          width: width / 5,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  forgotColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Center(
                                                              child: Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          )))),
                                                  SizedBox(
                                                    width: width / 20,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                          titleText: 'Are You Sure?',
                                        );
                                      },
                                      animationType: DialogTransitionType.rotate3D, duration: Duration(seconds: 1),
                                    );

                                    ;
                                  }),
                            )
                          ],
                        ),
                      ),
                    )
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
  Path getClip(Size size) => _getFinalClip(size);
}
