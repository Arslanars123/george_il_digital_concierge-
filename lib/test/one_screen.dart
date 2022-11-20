import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/mesage_windowScreen.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/internet_connection.dart';
import 'package:untitled6/profile_setrting.dart';
import 'package:untitled6/shop_screen.dart';
import 'package:untitled6/test/bottom_bar.dart';
import 'package:untitled6/test/hotel_page.dart';
import 'package:untitled6/test/travel_diary.dart';
import '../global.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, this.data, this.checkInfo, this.userdata})
      : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  dynamic data;
  dynamic userdata;
  dynamic checkInfo;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<MainScreen> with WidgetsBindingObserver {
  int selectedIndex = 0;
  var decode;
  var hoteldata;

  Future<http.Response> fetchStr() async {
    var url = 'http://giovannis37.sg-host.com/api/check-code';
    var prefrence = await SharedPreferences.getInstance();

    Map data = {
      'reservation_code': prefrence.getString('reservation'),
      'user_id': prefrence.getInt('id'),
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    decode = jsonDecode(response.body);


    var pref = await SharedPreferences.getInstance();

    if (decode['status'] == 200) {

      hoteldata = decode['data'];
      var check = decode['data2'];
      pref.setString('hotelemail', decode['data']['email']);
      setState(() {
        hotelemail = pref.getString('hotelemail');
        useremail = pref.get('email');
        username = pref.getString('name');
        userimage = pref.getString('image');
      });
      setState(() {
        widget.data = hoteldata;
        widget.checkInfo = check;
        widget.userdata = pref.getInt('id');
      });
    }

    return response;
  }

  void onTapButton(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  var connectivity = 'yes';

  internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      setState(() {
        connectivity = 'yes';
      });
      Future.delayed(Duration.zero, () {
        fetchStr();
      });
    } else {
      setState(() {
        connectivity = '';
      });
    }
    print('arslan');
    print(widget.data);
    print(widget.checkInfo);
    print(widget.userdata);
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    setIndex();
    super.initState();
    internet();

    if (widget.data == null) {}
  }

  void setIndex() {
    setState(() {
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = [
      HotelPage(
          hotel: widget.data,
          checkInfoPeoples: widget.checkInfo,
          userdata: widget.userdata),

      TravelDiary(
          userdata: widget.userdata,
          data: widget.data,
          checkInfo: widget.checkInfo),
      DataScreens(
          data: widget.data,
          userdata: widget.userdata,
          checkInfo: widget.checkInfo),
      ShopScreen(
          data: widget.data, info: widget.checkInfo, userdata: widget.userdata),
      SettingProfile(
          data: widget.data,
          checkInfo: widget.checkInfo,
          userdata: widget.userdata)
    ];
    return connectivity == 'yes' ?Scaffold(
        bottomNavigationBar: getConvexAppBar(selectedIndex, onTapButton),
        body: widget.data != null
            ? listWidgets[selectedIndex]
            : connectivity != 'yes'
                ? InternetConnection()
                : Center(child: CircularProgressIndicator())):InternetConnection();
  }
}
