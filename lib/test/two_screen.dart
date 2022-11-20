import 'package:flutter/material.dart';
import 'package:untitled6/mesage_windowScreen.dart';
import 'package:untitled6/product_list_code.dart';
import 'package:untitled6/profile_setrting.dart';
import 'package:untitled6/test/bottom_bar.dart';
import 'package:untitled6/test/hotel_page.dart';
import 'package:untitled6/test/travel_diary.dart';
class TwoScreen extends StatefulWidget {
  TwoScreen({Key? key, required this.data,required this.realhotel,required this.info,required this.userdata}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic realhotel;
  final dynamic info;
  final dynamic userdata;

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<TwoScreen> with WidgetsBindingObserver{
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
    List<Widget> listWidgets = [HotelPage(hotel: widget.realhotel,checkInfoPeoples: widget.info,userdata: widget.userdata,),TravelDiary(userdata: widget.userdata,data: widget.realhotel,checkInfo: widget.info,),DataScreens(data: widget.realhotel,userdata: widget.userdata,checkInfo: widget.info,),ProductListCode(hotel: widget.data,realhotel: widget.realhotel,info: widget.info,userdata: widget.userdata,),SettingProfile(userdata: widget.userdata,checkInfo: widget.info,data: widget.realhotel,)];

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
