import 'package:flutter/material.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/add_profile_screen.dart';
class InviteFriendsScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}
class _State extends State<InviteFriendsScreen> {
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
              'Invite Friends',
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
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),
          body:Stack(
            children: [
              InkWell(
                onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProfileScreen()),
                    );

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height/20,
                    ),
                    Center(child: Row(
                      children: [
                        SizedBox(
                          width: width/10,
                        ),
                        Image.asset('assets/friends_image.png',scale: 2,),
                      ],
                    )),
                    SizedBox(
                      height: height/22,
                    ),
                    Container(
                      height: height/14,
                      width: width/1.6,

                      child: ElevatedButton(
                          child: Text(
                              'Continue',
                              style: TextStyle(fontSize: 14)
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(bottomCircleColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),

                                  )
                              )
                          ),
                          onPressed: () =>
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddProfileScreen()),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(

                children: [
                  SizedBox(
                    height: height/10,
                  ),
                Align(
                  alignment: Alignment.topCenter,
                    child: Text('Share With Friends',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: forgotColor),)),
                  SizedBox(
                    height: height/40,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: height/5,
                        width: width/2.8,
                        child: Text('Sed tortor ante, this is vestibulum non crisus id, porta imperdiet purus.',style: TextStyle(fontSize: 12,color: signColor.withOpacity(0.5)),)),
                  ),


                ],
              ),
            ],
          )
      ),
    );
  }
}


