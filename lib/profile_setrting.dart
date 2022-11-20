import 'package:flutter/material.dart';
import 'package:untitled6/profile_screen.dart';
import 'package:untitled6/user_profile.dart';

import 'config/colors.dart';
import 'global.dart';

class SettingProfile extends StatefulWidget {
  const SettingProfile({Key? key,required this.checkInfo,required this.data,required this.userdata}) : super(key: key);
final dynamic data;
final dynamic userdata;
final dynamic checkInfo;
  @override
  State<SettingProfile> createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  @override
  void initState() {
    print(widget.data);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    var commonColor = const Color.fromRGBO(94, 112, 224, 1);
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                  /* leading: Image.asset('assets/side_bar_menu.png',scale: 1.7,),*/

                  height: displayHeight / 15,
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
                        child: InkWell(
                          onTap: (){
                            print(widget.userdata);
                          },
                          child: Container(
                            child: Text(
                              english == true ?'Profile':'Profilo',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width/15, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                height: displayHeight / 15,
                child: TabBar(
                  labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  indicatorColor: commonColor,
                  isScrollable: true,
                  labelColor: forgotColor,
                  unselectedLabelColor: Colors.grey,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: forgotColor,width: 2),
                    insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  ),
                  tabs: [
                    Row(
                      children: [
                        Icon(Icons.person_outline),
                        SizedBox(width: 5),
                        Text(english == true ?'User Profile':'Profilo utente'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 5),
                        Text(english == true ?'Settings':'impostazioni'),
                      ],
                    ),

                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    UserProfile(userdata:widget.userdata,checkInfo:widget.checkInfo),
                    ProfileScreen(userdata:widget.userdata,checkInfo:widget.checkInfo,hotelInfo: widget.data,),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
