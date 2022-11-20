import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/config/strings.dart';
import 'package:untitled6/hotel_boardScreen.dart';
import 'package:untitled6/global.dart';

import 'package:untitled6/internet_connection.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationScreen> {
  var connectivity = 'yes';
  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var url = 'http://giovannis37.sg-host.com/api/get-hotels';
      var preference = await SharedPreferences.getInstance();

      Map data = {
        'user_id': preference.getInt('id'),
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);

      decode = jsonDecode(response.body);
      a = decode['data'];

      setState(() {

        a = decode['data'];
      });

    } else {
      setState(() {

      });
    }

  }


  List name = [];
  List pictures = [];
  List a = [];
  var serv = 'http://giovannis37.sg-host.com/';
  var decode;

  Future fetchStr() async {
    print('arslan');
    bool connection = await InternetConnectionChecker().hasConnection;
    if(connection == true) {
      var url = 'http://giovannis37.sg-host.com/api/get-hotels';
      var preference = await SharedPreferences.getInstance();

      Map data = {
        'user_id': preference.getInt('id'),
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);

      decode = jsonDecode(response.body);
      a = decode['data'];
      print(a);
    }
   else{
     setState(() {
       connectivity ='';
     });
    }
  }

  int value = 0;
  int ind = 0;
  int val = 0;

  int checkIndex(int ind) {
    ind = ind + 1;

    if (ind <= 5) {
      val = ind;
    } else {
      val = ind % 5;
    }
    return val;
  }

  var timer;
  var checking;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {

      await this.fetchStr();
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) => fetchStr());

      setState(() {});
    });

    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (connectivity == 'yes') {
      return RefreshIndicator(
        onRefresh: internet,
        child: ListView(
          children: [
            Container(
              height: height,
              width: width,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 15,
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
                                alignment: Alignment.center,
                                child: Text(
                                  english == true ? 'Hotels' : 'Alberghi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width / 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: a.length,
                            itemBuilder: (context, index) {
                              value = checkIndex(index);

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DisableDestination(
                                                hotel: a[index],
                                              )),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      decode['data'][index]['image']  != null ?
                                      Center(
                                        child: Container(
                                          height: height / 5,
                                          width: width / 1.1,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "http://giovannis37.sg-host.com/" +
                                                      decode['data'][index]['image'],
                                              placeholder: (context, url) =>
                                                  Image.asset('assets/noimage.png'),
                                              errorWidget: (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ) : Container(),
                                      Center(
                                        child: Container(
                                          height: height / 5,
                                          width: width / 1.1,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              gradient: (value == 1)
                                                  ? LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Color(0xFFCD705D),
                                                        Color(0xFFDE846F)
                                                            .withOpacity(0.7),
                                                        Color(0XFFE96941),
                                                      ],
                                                    )
                                                  : (value == 2)
                                                      ? LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          colors: [
                                                            Color(0xFF6BA1D2),
                                                            Color(0xFF499AD9)
                                                                .withOpacity(0.5),
                                                            Color(0xFF4099E0),
                                                          ],
                                                        )
                                                      : (index == 3)
                                                          ? LinearGradient(
                                                              begin:
                                                                  Alignment.topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color(0xFF2EB994),
                                                                Color(0xFF4ABE9A)
                                                                    .withOpacity(0.5),
                                                                Colors.purple
                                                                    .withOpacity(0.3),
                                                              ],
                                                            )
                                                          : (value == 4)
                                                              ? LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  colors: [
                                                                    Colors.blue
                                                                        .withOpacity(
                                                                            0.3),
                                                                    Colors.blueGrey
                                                                        .withOpacity(
                                                                            0.3),
                                                                    Colors.orange
                                                                        .withOpacity(
                                                                            0.3),
                                                                  ],
                                                                )
                                                              : (value == 5)
                                                                  ? LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter,
                                                                      colors: [
                                                                        gradientThreeColor
                                                                            .withOpacity(
                                                                                0.5),
                                                                        Colors.brown
                                                                            .withOpacity(
                                                                                0.5),
                                                                        Colors.brown
                                                                            .withOpacity(
                                                                                0.6),
                                                                      ],
                                                                    )
                                                                  : LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter,
                                                                      colors: [
                                                                        gradientOneColor
                                                                            .withOpacity(
                                                                                0.5),
                                                                        gradientTwoColor
                                                                            .withOpacity(
                                                                                0.5),
                                                                        gradientThreeColor
                                                                            .withOpacity(
                                                                                0.6),
                                                                      ],
                                                                    )),
                                          child: Stack(
                                            children: [
                                              Align(
                                                child: Center(
                                                  child: Container(
                                                    width: width / 1.2,
                                                    child: Text(
                                                      a[index]['name'],
                                                      style: TextStyle(
                                                          fontSize: width / 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
    } else {
      return InternetConnection();
    }
  }
}
