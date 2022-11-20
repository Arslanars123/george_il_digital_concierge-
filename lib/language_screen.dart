import 'package:flutter/material.dart';
import 'package:untitled6/config/colors.dart';
class LanguageScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}
class _State extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Language',
            style: TextStyle(
                color: signColor, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          leading: Image.asset(
            'assets/side_bar_menu.png',
            scale: 2,
          ),
          actions: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: signColor,
                size: 25,
              ),
            ),
          ],
        ),
        body:Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: englishColor,
                radius: width/5,
                child: Text('English',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
              ),
              SizedBox(width: width/20,),
              CircleAvatar(
                backgroundColor: bottomCircleColor,
                radius: width/5,
                child: Text('Italian',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

              ),
            ],
          ),
        )
      ),
    );
  }
}


