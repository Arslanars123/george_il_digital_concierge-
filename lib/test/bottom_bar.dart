import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/internet_connection.dart';

ConvexAppBar getConvexAppBar(int selectedIndex , itemTapped) {
  return ConvexAppBar(
    items:  [
      TabItem(icon: Container(
          child: Center(child: SvgPicture.asset("assets/home.svg",))),activeIcon: Container(
        height: 5,
          width: 5,
          child: Center(child: SvgPicture.asset("assets/home.svg",color: Colors.white,))),),
      TabItem(icon: SvgPicture.asset("assets/calender.svg",color: signColor,),activeIcon: Container(

          child: Center(child: SvgPicture.asset("assets/calender.svg",color: Colors.white,height: 40,width: 40,))),),

      TabItem(icon:Container(
          child: Center(child: (SvgPicture.asset('assets/reception.svg',height: 80,width: 80,)))),activeIcon: Container(

          child: Center(child: SvgPicture.asset("assets/reception.svg",color: Colors.white,height: 40,width: 40,))),),
      TabItem(icon: SvgPicture.asset("assets/purse_3x.svg",color: signColor,),activeIcon: Container(
          height: 5,
          width: 5,
          child: Center(child: SvgPicture.asset("assets/purse_icon.svg",color: Colors.white,))),),
      TabItem(icon: SvgPicture.asset("assets/profile.svg",color: signColor,),activeIcon: Container(
          height: 5,
          width: 5,
          child: Center(child: SvgPicture.asset("assets/profile.svg",color: Colors.white,))),),

    ],

    onTap: itemTapped,
    initialActiveIndex: selectedIndex,
    color: Colors.black,

    backgroundColor: Colors.white,
    activeColor: bottomCircleColor,
  );
}

