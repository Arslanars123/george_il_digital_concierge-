import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/test/one_screen.dart';
class InternetConnection extends StatefulWidget {
  const InternetConnection({Key? key}) : super(key: key);

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {

  var connectivity = 'yes';

  internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MainScreen()));

    } else {
      Fluttertoast.showToast(
          msg: "Internet not available",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        height: double.infinity,
        width: double.infinity,
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
        child: Center(
          child: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(),
                    SizedBox(height: MediaQuery.of(context).size.height/8,),
                    Text('No Internet',style: TextStyle(
                      fontSize: 30,color: Color(0xFF9FB1C2),

                    ),),
                    Text('Connection',style: TextStyle(
                        fontSize: 50,color: Colors.white,fontWeight: FontWeight.bold

                    ),),

                    Text('please check your internet connection and try again',style: TextStyle(
                      fontSize: 16,color: Color(0xFF9FB1C2),

                    ),),
                    Padding(
                      padding:  EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: (){
                          internet();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height/17,
                          width: MediaQuery.of(context).size.width/3.5,
                          child: Center(child: Text('TRY AGAIN',style: TextStyle(color: forgotColor),)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container(
          height: double.infinity,
          width: double.infinity,
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
          child: Center(
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(),
                      SizedBox(height: MediaQuery.of(context).size.height/8,),
                      Text('No Internet',style: TextStyle(
                        fontSize: 30,color: Color(0xFF9FB1C2),

                      ),),
                      Text('Connection',style: TextStyle(
                        fontSize: 50,color: Colors.white,fontWeight: FontWeight.bold

                      ),),

                      Text('please check your internet connection and try again',style: TextStyle(
                        fontSize: 16,color: Color(0xFF9FB1C2),

                      ),),
                      Padding(
                        padding:  EdgeInsets.only(top: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height/17,
                          width: MediaQuery.of(context).size.width/3.5,
                          child: Center(child: Text('TRY AGAIN',style: TextStyle(color: forgotColor),)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

    );
  }
}
class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery.of(context).size.height/10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/10,
            width: MediaQuery.of(context).size.width/6,
            decoration: BoxDecoration(

                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/mustache_arslan.png')

                )
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width/40,),
          Container(
            height: MediaQuery.of(context).size.height/2.3,
            width: MediaQuery.of(context).size.width/2.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/white_logo_arslan_.png')
                )
            ),
          )
        ],
      ),
    );
  }
}
