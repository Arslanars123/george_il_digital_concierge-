import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/hotels_screen.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/signin_screen.dart';
import 'package:http/http.dart' as http;
import 'config/colors.dart';

class WithoutCodeSetting extends StatefulWidget {
  const WithoutCodeSetting({Key? key, required this.hotel}) : super(key: key);
  final dynamic hotel;

  @override
  State<WithoutCodeSetting> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<WithoutCodeSetting> {
  var adminNote;

  Future<http.Response> note() async {
    print('arslan');
    var url = 'http://giovannis37.sg-host.com/api/get-notice';
    var response;
    bool result;
    result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
        );
        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          adminNote = data['data']['notice'];
          print(adminNote);
          adminNote != null
              ? Fluttertoast.showToast(
                  msg: "Login Successful",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.transparent,
                  textColor: Colors.transparent,
                  fontSize: 16.0)
              : Fluttertoast.showToast(
                  msg: "Note not available",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: 'something wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        await Fluttertoast.showToast(
            msg: "something wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "No internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }
    return response;
  }

  Future<http.Response> languageChange() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: 20,
          width: 20,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    var prefrence = await SharedPreferences.getInstance();
    var url = 'http://giovannis37.sg-host.com/api/set-language';
    Map data = {
      'user_id': prefrence.getInt('id'),
      'language': english == true ? 'english' : 'italian',
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LocationScreen(),), (Route<dynamic> route) => false);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 15,
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
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(
                                english == true ? 'Back' : 'indietro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: displayWidth / 21,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      english == true ? 'Settings' : 'impostazioni',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth / 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          height: displayHeight * 0.06,
                          width: displayWidth * 0.08,
                          child: const Icon(
                            Icons.email,
                            size: 18,
                            color: Colors.white,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: displayWidth * 0.04,
                        ),
                        Text(
                          useremail != null ? useremail : '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            insetPadding: EdgeInsets.zero,
                            content: Container(
                              width: displayWidth / 1.1,
                              decoration: BoxDecoration(),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
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
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                      Text(
                                                        english == true
                                                            ? 'Back'
                                                            : 'indietro',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                displayWidth /
                                                                    23),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                child: Text(
                                                  english == true
                                                      ? 'Choose'
                                                      : 'Scegliere',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    SizedBox(
                                      height: displayHeight / 50,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          english = true;
                                        });
                                        await languageChange();
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: displayHeight / 80,
                                          ),
                                          Text(
                                            'English',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: displayHeight / 80,
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: displayHeight / 80,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          english = false;
                                        });
                                        await languageChange();
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: displayHeight / 80,
                                          ),
                                          Text(
                                            'Italian',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: displayHeight / 80,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: displayHeight / 80,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        animationType: DialogTransitionType.slideFromBottomFade,
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            english == true
                                ? Container(
                                    height: displayHeight * 0.06,
                                    width: displayWidth * 0.08,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/english_flag.jpeg'))),
                                  )
                                : Container(
                                    height: displayHeight * 0.06,
                                    width: displayWidth * 0.08,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/italy-flag.png'))),
                                  ),
                            SizedBox(
                              width: displayWidth * 0.04,
                            ),
                            Text(
                              english == true ? 'English' : 'Italian',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.remove('id');
                      await prefs.remove('image');
                      await prefs.remove('name');
                      await prefs.remove('email');
                      setState(() {
                        english = false;
                      });
                      await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: displayHeight * 0.06,
                              width: displayWidth * 0.08,
                              child: const Icon(
                                Icons.logout,
                                size: 18,
                                color: Colors.white,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: displayWidth * 0.04,
                            ),
                            Text(
                              english == true ? 'LogOut' : 'Disconnettersi',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      note();
                      adminNote != null
                          ? await showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  insetPadding: EdgeInsets.zero,
                                  content: Container(
                                    height: displayHeight / 1.2,
                                    width: displayWidth / 1.1,
                                    decoration: BoxDecoration(),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .arrow_back_ios,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                            Text(
                                                              english == true
                                                                  ? 'Back'
                                                                  : 'indietro',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      displayWidth /
                                                                          21),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      child: Text(
                                                        english == true
                                                            ? 'Luigis Note'
                                                            : 'Luigis Note',
                                                        style: TextStyle(
                                                            fontSize:
                                                                displayWidth /
                                                                    19,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            height: displayHeight / 50,
                                          ),
                                          Container(
                                              child: SingleChildScrollView(
                                                  child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  adminNote.toString(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: signColor
                                                          .withOpacity(0.5),
                                                      fontSize:
                                                          displayWidth / 22),
                                                )),
                                          )))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              animationType:
                                  DialogTransitionType.slideFromBottomFade,
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(seconds: 1),
                            )
                          : Fluttertoast.showToast(
                              msg: "Note not available",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.transparent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: displayHeight * 0.06,
                              width: displayWidth * 0.08,
                              child: const Icon(
                                Icons.message,
                                size: 18,
                                color: Colors.white,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: displayWidth * 0.04,
                            ),
                            Text(
                              english == true ? 'App Note' : 'luigi Note',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      print(widget.hotel['terms_conditions']);
                      widget.hotel['termsandconditions'] != null
                          ? await showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  insetPadding: EdgeInsets.zero,
                                  content: Container(
                                    height: displayHeight / 1.2,
                                    width: displayWidth / 1.1,
                                    decoration: BoxDecoration(),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .arrow_back_ios,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                            Text(
                                                              english == true
                                                                  ? 'Back'
                                                                  : 'indietro',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      displayWidth /
                                                                          25),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      child: Text(
                                                        english == true
                                                            ? 'Terms and Conditions'
                                                            : 'Termini e Condizioni',
                                                        style: TextStyle(
                                                            fontSize:
                                                                displayWidth /
                                                                    21,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            height: displayHeight / 50,
                                          ),
                                          Container(
                                              child: SingleChildScrollView(
                                                  child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  widget.hotel[
                                                          'termsandconditions']
                                                      .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: signColor
                                                          .withOpacity(0.5),
                                                      fontSize:
                                                          displayWidth / 22),
                                                )),
                                          )))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              animationType:
                                  DialogTransitionType.slideFromBottomFade,
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(seconds: 1),
                            )
                          : Fluttertoast.showToast(
                              msg: "not available",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: displayHeight * 0.06,
                              width: displayWidth * 0.08,
                              child: const Icon(
                                Icons.book_sharp,
                                size: 18,
                                color: Colors.white,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: displayWidth * 0.04,
                            ),
                            Text(
                              english == true
                                  ? 'Terms and Conditions'
                                  : 'Termini e Condizioni',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
