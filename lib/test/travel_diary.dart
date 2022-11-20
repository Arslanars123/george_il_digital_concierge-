import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/internet_connection.dart';
import 'package:untitled6/config/colors.dart';
import '../config/colors.dart';

class TravelDiary extends StatefulWidget {
  TravelDiary(
      {Key? key,
        required this.userdata,
        required this.data,
        required this.checkInfo})
      : super(key: key);
  final dynamic userdata;
  final dynamic checkInfo;

  final dynamic data;

  @override
  State<TravelDiary> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TravelDiary> {
  var a;
  var check = false;
  List<Tab> tabsL = [];
  List<ListView> listsL = [];
  var commonColor = const Color.fromRGBO(94, 112, 224, 1);

  Future<http.Response> fetchStr() async {
    var url = 'http://giovannis37.sg-host.com/api/reserved-services';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('id'));
    Map data = {
      'user_id': prefs.getInt('id'),
    };
    print(prefs.getInt('id'));
    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var decode = jsonDecode(response.body);
    a = decode['data'];

    //create an empty list of Tab
    if (a.length >= 1) {
      for (var i = 0; i < a.length; i++) {
        tabsL.add(Tab(text: a[i]['reserve_date']));
        //add your tabs to the list
      }

      for (var i = 0; i < a.length; i++) {
        List<Padding> single = [];
        for (var j = 0; j < a[i]['reserves'].length; j++) {
          single.add(Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          a[i]['reserve_date'],
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        a[i]['reserves'][j]['service']['image'] != null
                            ? Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height:
                            MediaQuery.of(context).size.height * 0.1,
                            child: CachedNetworkImage(
                              imageUrl: 'http://giovannis37.sg-host.com/' +
                                  a[i]['reserves'][j]['service']['image'],
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ))
                            : Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height:
                            MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                print(a[i]['reserves'][j]);
                              },
                              child: Text(
                                english == true
                                    ? a[i]['reserves'][j]['service']['name_en']
                                    : a[i]['reserves'][j]['service']['name_it'],
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            InkWell(
                              onTap: () {
                                print(a[i]);
                              },
                              child: Text(
                                  a[i]['reserves'][j]['event_date'].toString(),
                                  style: TextStyle(
                                      color: signColor.withOpacity(0.5),
                                      fontSize: 17)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () async {
                        final Email email = Email(
                          body: 'Email body',
                          subject: 'Pagoda App',
                          recipients: [hotelemail],
                          isHTML: false,
                        );
                        await FlutterEmailSender.send(email);
                      },
                      child: Text(
                        'Need Help?',
                        style: TextStyle(color: commonColor, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        }
        print(single);
        listsL.add(ListView(children: single));
      }
      print(listsL);
    }
    setState(() {
      check = true;
    });
    return response;
  }

  List<ListView> tabs2Func() {
    return listsL;
  }

  List<Tab> tabsFunc() {
    return tabsL;
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
    super.initState();
    internet();

    Future.delayed(Duration(seconds: 1), () async {
      await fetchStr();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return connectivity == 'yes'
        ? SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height / 15),
          child: AppBar(
            elevation: 0,
            actions: [
              Expanded(
                child: Container(
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
                          alignment: Alignment.center,
                          child: Container(
                            child: Text(
                              english == true
                                  ? "Travel Diary"
                                  : 'Diario di viaggio',
                              style: TextStyle(
                                  fontSize: width / 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
        body: check == false
            ? Center(
          child: Container(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        )
            : DefaultTabController(
          length: a.length,
          child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    child: TabBar(
                      labelStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      indicatorColor: forgotColor,
                      isScrollable: true,
                      labelColor: forgotColor,
                      unselectedLabelColor: Colors.grey,
                      indicator: UnderlineTabIndicator(
                        borderSide:
                        BorderSide(color: forgotColor, width: 2),
                        insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
                      ),
                      tabs: tabsFunc(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: tabs2Func(),
                    ),
                  ),
                ],
              )),
        ),
      ),
    )
        : InternetConnection();
  }
}
