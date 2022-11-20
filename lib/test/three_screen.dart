import 'package:flutter/material.dart';
import 'package:untitled6/mesage_windowScreen.dart';
import 'package:untitled6/product_details_code.dart';
import 'package:untitled6/profile_setrting.dart';
import 'package:untitled6/test/bottom_bar.dart';
import 'package:untitled6/test/hotel_page.dart';
import 'package:untitled6/test/travel_diary.dart';
class ThreeScreen extends StatefulWidget {
  ThreeScreen({Key? key, required this.data,required this.realhotel,required this.info,required this.userdata}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic info;
  final dynamic realhotel;
  final dynamic userdata;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<ThreeScreen> with WidgetsBindingObserver{
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
    List<Widget> listWidgets = [HotelPage(hotel: widget.realhotel,checkInfoPeoples: widget.info,userdata: widget.userdata,),TravelDiary(data: widget.realhotel,userdata: widget.userdata,checkInfo: widget.info,),DataScreens(data: widget.realhotel,userdata: widget.userdata,checkInfo: widget.info,),ProductDetailCode(data: widget.data,),SettingProfile(userdata: widget.userdata,data: widget.realhotel,checkInfo: widget.info,)];


    return Scaffold(
        bottomNavigationBar: getConvexAppBar(selectedIndex, onTapButton),
        body: listWidgets[selectedIndex]
      /* Material(
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const Login(),
                  ));
                },
                child: const Text('Go to 2nd Page')),
          ),
        )*/);
  }
}
