import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/global.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/test/one_screen.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {Key? key,
      required this.userdata,
      required this.checkInfo,
      required this.hotelInfo})
      : super(key: key);
  final dynamic hotelInfo;
  final dynamic userdata;
  final dynamic checkInfo;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool check = false;
  var adminNote;
  Future<http.Response> note() async {
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
          if (adminNote != null) {
            setState(() {
              check = true;
            });
          } else if (adminNote == null) {
            Fluttertoast.showToast(
                msg: "Note not available",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                await FlutterShare.share(
                    title: 'Example share',
                    text: 'Example share text',
                    linkUrl: 'https://flutter.dev/',
                    chooserTitle: 'Example Chooser Title');
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
                          Icons.people_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: displayWidth * 0.04,
                      ),
                      Text(
                        english == true ? 'Invite Friends' : 'Invita gli amici',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
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
            const Divider(),
            InkWell(
              onTap: () async {
                final Email email = Email(
                  body: 'Email body',
                  subject: 'Pagoda App',
                  recipients: [hotelemail],
                  isHTML: false,
                );

                await FlutterEmailSender.send(email);
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
                          Icons.headset_mic,
                          size: 18,
                          color: Colors.white,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: displayWidth * 0.04,
                      ),
                      Text(
                        english == true ? 'Help Center' : 'Centro assistenza',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
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
            const Divider(),
            InkWell(
              onTap: () async {
                print(widget.hotelInfo);
                widget.hotelInfo['termandconditions'] != null
                    ? showAnimatedDialog(
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
                                                                    22),
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
                                                          displayWidth / 20,
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
                                    Container(
                                        child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          widget.hotelInfo['termsandconditions']
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: signColor.withOpacity(0.5),
                                              fontSize: displayWidth / 22),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        animationType: DialogTransitionType.slideFromBottomFade,
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(seconds: 1),
                      )
                    : Fluttertoast.showToast(
                        msg: "No Terms and Chaonditions",
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
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
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
                            fontWeight: FontWeight.w500, fontSize: 16),
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
            const Divider(),
            InkWell(
              onTap: () async {
                note();
                if (check = true) {
                  await showAnimatedDialog(
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
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
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
                                                            displayWidth / 21),
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
                                                  fontSize: displayWidth / 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
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
                                           padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Align(
                                              alignment: Alignment.topLeft, child: Text(adminNote.toString(), textAlign: TextAlign.left, style: TextStyle(color: signColor.withOpacity(0.5), fontSize: displayWidth / 22),
                                      )),
                                )))
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
                }
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
                          Icons.note,
                          size: 18,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: displayWidth * 0.04,
                      ),
                      Text(
                        english == true ? ' Luigis Note' : 'Luigis note',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
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
            const Divider(),
            /*    Row(
              children: [
                Container(
                  height: displayHeight * 0.06,
                  width: displayWidth*0.08,
                  child: const Icon(Icons.settings, size: 18, color: Colors.white,),
                  decoration: const BoxDecoration( color: Colors.green, shape: BoxShape.circle, ),
                ),
                SizedBox(width: displayWidth*0.04,),
                InkWell(
                    onTap: (){
*/ /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProfileScreen()),
                      );*/ /*

                    },
                    child: const Text('Setting', style: TextStyle(fontWeight: FontWeight.w500),)),
                SizedBox(width: displayWidth*0.59,),
                const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: Colors.grey,)
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
