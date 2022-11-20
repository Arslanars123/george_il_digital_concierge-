import 'package:flutter/material.dart';
import 'package:untitled6/mesage_windowScreen.dart';
import 'package:untitled6/profile_setrting.dart';
import 'package:untitled6/service_detail_with_code.dart';
import 'package:untitled6/test/hotel_page.dart';
import 'package:untitled6/test/travel_diary.dart';
import 'bottom_bar.dart';
class FiveScreen extends StatefulWidget {
  FiveScreen({Key? key, required this.data,required this.realHotel,required this.info,required this.userdata}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic info;
  final dynamic realHotel;
  final dynamic userdata;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<FiveScreen> with WidgetsBindingObserver{
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
      selectedIndex = 3;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = [HotelPage(hotel: widget.realHotel,checkInfoPeoples: widget.info,userdata: widget.userdata,),TravelDiary(data: widget.realHotel,userdata: widget.userdata,checkInfo: widget.info,),DataScreens(data: widget.realHotel,userdata: widget.userdata,checkInfo: widget.info,),ServiceDetailsCode(data: widget.data,realHotel: widget.realHotel,info:widget.info,userdata: widget.userdata,),SettingProfile(data: widget.realHotel,userdata: widget.userdata,checkInfo: widget.info,)];
    return Scaffold(
        bottomNavigationBar: getConvexAppBar(selectedIndex, onTapButton),
        body: listWidgets[selectedIndex]
     );
  }
}
