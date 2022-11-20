import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled6/signin_screen.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = FadeInController();
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
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
          ),
          Center(
              child: FadeIn(
                  duration: Duration(seconds: 2),


              child: Logo())
          )
        ],
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
