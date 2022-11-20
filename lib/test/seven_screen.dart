import 'package:flutter/material.dart';
import 'package:untitled6/mesage_windowScreen.dart';
import 'package:untitled6/profile_setrting.dart';
import 'package:untitled6/shop_screen.dart';
import 'package:untitled6/test/bottom_bar.dart';
import 'package:untitled6/test/reviews_all.dart';
import 'package:untitled6/test/travel_diary.dart';
class SevenScreen extends StatefulWidget {
  SevenScreen({Key? key, required this.data,required this.realHotel,required this.userdata,required this.checkInfo}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic realHotel;
  final dynamic checkInfo;
  final dynamic userdata;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<SevenScreen> with WidgetsBindingObserver{
  int selectedIndex = 0;

  void onTapButton(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    setIndex();
    super.initState();

  }

  void setIndex() {
    setState(() {
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = [ReviewsAll(hotel: widget.data,),TravelDiary(data: widget.data,userdata: widget.userdata,checkInfo: widget.checkInfo,),DataScreens(data: widget.realHotel,userdata: widget.userdata,checkInfo: widget.checkInfo,),ShopScreen(data: widget.realHotel,info: widget.checkInfo,userdata: widget.userdata,),SettingProfile(data: widget.data,userdata: widget.userdata,checkInfo: widget.checkInfo,)];

    return Scaffold(
        bottomNavigationBar: getConvexAppBar(selectedIndex, onTapButton),
        body: listWidgets[selectedIndex]);
  }
}
