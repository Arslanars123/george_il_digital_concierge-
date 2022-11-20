import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/global.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/verify_screen.dart';
import 'signin_screen.dart';
import 'test/one_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.userdata, required this.checkInfo})
      : super(key: key);
  final dynamic userdata;
  final dynamic checkInfo;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var decode;
  var message;
  var response;
  var e;

  Future<http.Response> changePassword(
      String currentPassword, String newPassword) async {
    print('arslan');
    var prefrence = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: 20,
          width: 20,
          child: Center(
            child: CircularProgressIndicator(
              color: forgotColor,
            ),
          ),
        );
      },
    );
    var url = 'http://giovannis37.sg-host.com/api/change-password';
    Map data = {
      'user_id': prefrence.getInt('id'),
      'oldPassword': currentPassword,
      'newPassword': newPassword,
    };

    //encode Map to JSON
    var body = json.encode(data);
    bool result;
    try {
      result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        try {
          var response = await http.post(Uri.parse(url),
              headers: {"Content-Type": "application/json"}, body: body);

          decode = jsonDecode(response.body);
          if (decode['status'] == 200) {
            if (decode['message'] == 'Email is incorrect') {
              setState(() {
                message = 'Email not exist';
              });
            } else {
              message = null;
            }
            Navigator.pop(context);
            await Fluttertoast.showToast(
                msg: 'password set', textColor: Colors.green);
            Navigator.pop(context);
          } else {
            await Fluttertoast.showToast(
                msg: "something wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          print(jsonDecode(response.body));
          print("${response.statusCode}");
          print("${response.body}");
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
        await Fluttertoast.showToast(
            msg: "no internet",
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
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    var datanew = jsonDecode(response.body);
    Navigator.pop(context);

    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MainScreen(
                data: datanew['data'],
                checkInfo: datanew['data2'],
                userdata: widget.userdata,
              )),
    );

    return response;
  }

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: displayHeight / 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        insetPadding: EdgeInsets.zero,
                        content: Wrap(
                          children: [
                            Container(
                              width: displayWidth / 1.1,
                              decoration: BoxDecoration(),
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
                                            child: InkWell(
                                              onTap: () {
                                                print(widget.checkInfo);
                                              },
                                              child: Container(
                                                child: Text(
                                                  english == true
                                                      ? 'User Details'
                                                      : 'Dettagli utente',
                                                  style: TextStyle(
                                                      fontSize:
                                                          displayWidth / 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    height: displayHeight / 70,
                                  ),
                                  userimage != null
                                      ? Container(
                                          width: displayWidth * 5,
                                          height: displayHeight / 9,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: signColor
                                                      .withOpacity(0.3)),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      'http://giovannis37.sg-host.com/' +
                                                          userimage))))
                                      : Container(
                                          width: displayWidth * 5,
                                          height: displayHeight / 9,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey
                                                  .withOpacity(0.6))),
                                  SizedBox(
                                    height: displayHeight / 60,
                                  ),
                                  Text(
                                    username != null ? username : '',
                                    style: TextStyle(
                                        color: signColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: displayHeight / 70,
                                  ),
                                  useremail != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    48,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: displayHeight *
                                                            0.06,
                                                        width:
                                                            displayWidth * 0.08,
                                                        child: Icon(
                                                          Icons.email,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.indigo,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            displayWidth * 0.04,
                                                      ),
                                                      Text(useremail,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                  userphone != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    48,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: displayHeight *
                                                            0.06,
                                                        width:
                                                            displayWidth * 0.08,
                                                        child: Icon(
                                                          Icons.phone,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.indigo,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            displayWidth * 0.04,
                                                      ),
                                                      Text(
                                                        userphone,
                                                        style: TextStyle(
                                                            fontSize:
                                                                displayWidth /
                                                                    18),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            newPasswordController.clear();
                                            currentpassword.clear();
                                            confirmpassword.clear();
                                            await showAnimatedDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  insetPadding: EdgeInsets.zero,
                                                  content: Container(
                                                    width: displayWidth / 1.1,
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Wrap(
                                                        children: [
                                                          Container(
                                                              height:
                                                                  displayHeight /
                                                                      15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                  colors: [
                                                                    Color(
                                                                        0xff4857dd),
                                                                    Color(
                                                                        0xff744fdb),
                                                                    Color(
                                                                        0xffa448db),
                                                                  ],
                                                                ),
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.arrow_back_ios,
                                                                              color: Colors.white,
                                                                              size: 15,
                                                                            ),
                                                                            Text(
                                                                              english == true ? 'Back' : 'indietro',
                                                                              style: TextStyle(color: Colors.white, fontSize: displayWidth / 25),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Text(
                                                                        english ==
                                                                                true
                                                                            ? 'Change Password'
                                                                            : 'Cambia la password',
                                                                        style: TextStyle(
                                                                            fontSize: displayWidth /
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      displayWidth /
                                                                          1.35,
                                                                  child:
                                                                      TextFormField(
                                                                    validator:
                                                                        MultiValidator([
                                                                      RequiredValidator(
                                                                          errorText:
                                                                              'password is required'),
                                                                    ]),
                                                                    controller:
                                                                        currentpassword,
                                                                    cursorColor:
                                                                        Colors
                                                                            .black,
                                                                    decoration: new InputDecoration(
                                                                        enabledBorder: UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                signColor.withOpacity(0.3),
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        focusedBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: signColor.withOpacity(0.3),
                                                                              width: 1),
                                                                        ),
                                                                        contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                                                        hintText: english == true ? 'Current Password' : "Cambia la password",
                                                                        hintStyle: TextStyle(color: signColor.withOpacity(0.3), fontSize: 15)),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    displayWidth /
                                                                        1.35,
                                                                child:
                                                                    TextFormField(
                                                                  validator:
                                                                      MultiValidator([
                                                                    RequiredValidator(
                                                                        errorText:
                                                                            'password is required'),
                                                                  ]),
                                                                  controller:
                                                                      newPasswordController,
                                                                  cursorColor:
                                                                      Colors
                                                                          .black,
                                                                  decoration:
                                                                      new InputDecoration(
                                                                          enabledBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: signColor.withOpacity(0.3),
                                                                              width: 1,
                                                                            ),
                                                                          ),
                                                                          focusedBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: signColor.withOpacity(0.3), width: 1),
                                                                          ),
                                                                          contentPadding: EdgeInsets.only(
                                                                              left:
                                                                                  15,
                                                                              bottom:
                                                                                  11,
                                                                              top:
                                                                                  11,
                                                                              right:
                                                                                  15),
                                                                          hintText: english == true
                                                                              ? 'New Password'
                                                                              : 'nuova password',
                                                                          hintStyle: TextStyle(
                                                                              color: signColor.withOpacity(0.3),
                                                                              fontSize: 15)),
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    displayWidth /
                                                                        1.35,
                                                                child:
                                                                    TextFormField(
                                                                  validator:
                                                                      MultiValidator([
                                                                    RequiredValidator(
                                                                        errorText:
                                                                            'password is required'),
                                                                  ]),
                                                                  controller:
                                                                      confirmpassword,
                                                                  cursorColor:
                                                                      Colors
                                                                          .black,
                                                                  decoration:
                                                                      new InputDecoration(
                                                                          enabledBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: signColor.withOpacity(0.3),
                                                                              width: 1,
                                                                            ),
                                                                          ),
                                                                          focusedBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: signColor.withOpacity(0.3), width: 1),
                                                                          ),
                                                                          contentPadding: EdgeInsets.only(
                                                                              left:
                                                                                  15,
                                                                              bottom:
                                                                                  11,
                                                                              top:
                                                                                  11,
                                                                              right:
                                                                                  15),
                                                                          hintText: english == true
                                                                              ? 'Confirm Password'
                                                                              : 'nuova password',
                                                                          hintStyle: TextStyle(
                                                                              color: signColor.withOpacity(0.3),
                                                                              fontSize: 15)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    displayHeight /
                                                                        30,
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  if (_formKey
                                                                          .currentState!
                                                                          .validate() &&
                                                                      confirmpassword
                                                                              .text ==
                                                                          newPasswordController
                                                                              .text) {
                                                                    changePassword(
                                                                        currentpassword
                                                                            .text,
                                                                        newPasswordController
                                                                            .text);
                                                                  } else {
                                                                    Fluttertoast.showToast(
                                                                        msg:
                                                                            "something wrong",
                                                                        toastLength:
                                                                            Toast
                                                                                .LENGTH_SHORT,
                                                                        gravity:
                                                                            ToastGravity
                                                                                .CENTER,
                                                                        timeInSecForIosWeb:
                                                                            1,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red,
                                                                        textColor:
                                                                            Colors
                                                                                .white,
                                                                        fontSize:
                                                                            16.0);
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            displayHeight /
                                                                                16,
                                                                        width: displayWidth /
                                                                            1.5,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                          color:
                                                                              forgotColor,
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Center(
                                                                              child: Text(
                                                                                english == true ? 'Change Password' : 'Cambia la password',
                                                                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: CircleAvatar(
                                                                                backgroundColor: Colors.white.withOpacity(0.15),
                                                                                child: Icon(
                                                                                  Icons.arrow_forward,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              animationType:
                                                  DialogTransitionType
                                                      .slideFromBottomFade,
                                              curve: Curves.fastOutSlowIn,
                                              duration: Duration(seconds: 1),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height:
                                                        displayHeight * 0.06,
                                                    width: displayWidth * 0.08,
                                                    child: Icon(
                                                      Icons.key,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.indigo,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: displayWidth * 0.04,
                                                  ),
                                                  Text(
                                                    english == true
                                                        ? 'Change Password'
                                                        : 'Cambia la password',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 16,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);

                                            await showAnimatedDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  insetPadding: EdgeInsets.zero,
                                                  content: Container(
                                                    width: displayWidth / 1.1,
                                                    decoration: BoxDecoration(),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              height:
                                                                  displayHeight /
                                                                      15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                  colors: [
                                                                    Color(
                                                                        0xff4857dd),
                                                                    Color(
                                                                        0xff744fdb),
                                                                    Color(
                                                                        0xffa448db),
                                                                  ],
                                                                ),
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.arrow_back_ios,
                                                                              color: Colors.white,
                                                                              size: 15,
                                                                            ),
                                                                            Text(
                                                                              english == true ? 'Back' : 'indietro',
                                                                              style: TextStyle(color: Colors.white, fontSize: 14),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Text(
                                                                        english ==
                                                                                true
                                                                            ? 'Terms and Conditions'
                                                                            : 'Termini e Condizioni',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          SizedBox(
                                                            height:
                                                                displayHeight /
                                                                    50,
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
                                                                  height:
                                                                      displayHeight /
                                                                          80,
                                                                ),
                                                                Text(
                                                                  'English',
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      displayHeight /
                                                                          80,
                                                                ),
                                                                Divider(
                                                                  height: 1,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                displayHeight /
                                                                    80,
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
                                                                  height:
                                                                      displayHeight /
                                                                          80,
                                                                ),
                                                                Text(
                                                                  'Italian',
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      displayHeight /
                                                                          80,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                displayHeight /
                                                                    80,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              animationType:
                                                  DialogTransitionType
                                                      .slideFromBottomFade,
                                              curve: Curves.fastOutSlowIn,
                                              duration: Duration(seconds: 1),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  english == true
                                                      ? Container(
                                                          height:
                                                              displayHeight *
                                                                  0.06,
                                                          width: displayWidth *
                                                              0.08,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.indigo,
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image: AssetImage(
                                                                      'assets/english_flag.jpeg'))),
                                                        )
                                                      : Container(
                                                          height:
                                                              displayHeight *
                                                                  0.06,
                                                          width: displayWidth *
                                                              0.08,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.indigo,
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image: AssetImage(
                                                                      'assets/italy-flag.png'))),
                                                        ),
                                                  SizedBox(
                                                    width: displayWidth * 0.04,
                                                  ),
                                                  Text(
                                                    english == true
                                                        ? 'English'
                                                        : 'Italian',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 16,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        InkWell(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.remove('id');
                                            prefs.remove('reservation');
                                            prefs.remove('image');
                                            prefs.remove('name');
                                            prefs.remove('email');
                                            setState(() {
                                              english = false;
                                            });
                                            await Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext ctx) =>
                                                            SignInScreen()));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height:
                                                        displayHeight * 0.06,
                                                    width: displayWidth * 0.08,
                                                    child: const Icon(
                                                      Icons.logout,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.grey,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: displayWidth * 0.04,
                                                  ),
                                                  Text(
                                                    english == true
                                                        ? 'LogOut'
                                                        : 'Disconnettersi',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 16,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: displayHeight / 70,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                        Container(
                          height: displayHeight * 0.06,
                          width: displayWidth * 0.08,
                          child: const Icon(
                            Icons.person,
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
                          english == true ? 'User Details' : 'Dettagli utente',
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showAnimatedDialog(
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
                                                const EdgeInsets.only(left: 10),
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
                                                          displayWidth / 25),
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
                                                ? 'Checkin Details'
                                                : "Dettagli del check-in",
                                            style: TextStyle(
                                                fontSize: displayWidth / 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                child: Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: displayHeight / 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Builder(builder: (context) {
                                                return Container(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      /* showDialog<void>(
                                                            context: context,
                                                            barrierDismissible: true, // user must tap button!
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(

                                                                actions: <Widget>[
                                                               Expanded(
                                                                 child: Container(
                                                                   height: 100,
                                                                   color: Colors.red,
                                                                 ),
                                                               )
                                                                ],
                                                              );
                                                            },
                                                          );*/

                                                      showAnimatedDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            child:
                                                                ClassicGeneralDialogWidget(
                                                              actions: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: forgotColor, borderRadius: BorderRadius.circular(50)),
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 18,
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'No',
                                                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      SizedBox(
                                                                        width: displayWidth /
                                                                            20,
                                                                      ),
                                                                      InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            var pref =
                                                                                await SharedPreferences.getInstance();
                                                                            pref.remove('reservation');
                                                                            await Navigator.pushAndRemoveUntil(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => VerifyScreen(userdata: widget.userdata),
                                                                                ),
                                                                                (Route<dynamic> route) => false);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: forgotColor, borderRadius: BorderRadius.circular(50)),
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 18,
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'Yes',
                                                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      SizedBox(
                                                                        width: displayWidth /
                                                                            20,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                              titleText:
                                                                  'Are You Sure?',
                                                            ),
                                                          );
                                                        },
                                                        animationType:
                                                            DialogTransitionType
                                                                .rotate3D,
                                                        duration: Duration(
                                                            seconds: 1),
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  displayHeight *
                                                                      0.06,
                                                              width:
                                                                  displayWidth *
                                                                      0.08,
                                                              child: Icon(
                                                                Icons.phone,
                                                                color: Colors
                                                                    .white,
                                                                size: 18,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .indigo,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  displayWidth *
                                                                      0.04,
                                                            ),
                                                            Text(
                                                              'remove/change reservation code',
                                                              style: TextStyle(
                                                                  fontSize: 17),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  print(widget.checkInfo);
                                                },
                                                child: Text('Name',
                                                    style: TextStyle(
                                                        color: signColor,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                  widget.checkInfo['name'] !=
                                                          null
                                                      ? widget.checkInfo['name']
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5),
                                                  )),
                                              Divider(),
                                              Text('Email',
                                                  style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                widget.checkInfo['email'] !=
                                                        null
                                                    ? widget.checkInfo['email']
                                                    : '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5)),
                                              ),
                                              Divider(),
                                              Text('Phone',
                                                  style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                  widget.checkInfo['phone'] !=
                                                          null
                                                      ? widget
                                                          .checkInfo['phone']
                                                          .toString()
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5),
                                                  )),
                                              Divider(),
                                              Text('Age',
                                                  style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                widget.checkInfo['age'] != null
                                                    ? widget.checkInfo['age']
                                                        .toString()
                                                    : '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5)),
                                              ),
                                              Divider(),
                                              Text('Adults',
                                                  style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                  widget.checkInfo['adults'] !=
                                                          null
                                                      ? widget
                                                          .checkInfo['adults']
                                                          .toString()
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5),
                                                  )),
                                              Divider(),
                                              Text('Childrens',
                                                  style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                  widget.checkInfo[
                                                              'children'] !=
                                                          null
                                                      ? widget
                                                          .checkInfo['children']
                                                          .toString()
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5),
                                                  )),
                                              Divider(),
                                              Text('DateTo',
                                                  style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                widget.checkInfo['dateTo'] !=
                                                        null
                                                    ? widget.checkInfo['dateTo']
                                                    : '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5)),
                                              ),
                                              Divider(),
                                              Text('DateFrom',
                                                  style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: displayHeight / 70,
                                              ),
                                              Text(
                                                widget.checkInfo['dateFrom'] !=
                                                        null
                                                    ? widget
                                                        .checkInfo['dateFrom']
                                                    : '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: signColor
                                                        .withOpacity(0.5)),
                                              ),
                                              Divider(),
                                              Container(
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: widget
                                                      .checkInfo['customerInfo']
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          widget.checkInfo['customerInfo']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'label'] !=
                                                                  null
                                                              ? widget.checkInfo[
                                                                      'customerInfo']
                                                                  [
                                                                  index]['label']
                                                              : '',
                                                          style: TextStyle(
                                                              color: signColor,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              displayHeight /
                                                                  70,
                                                        ),
                                                        widget.checkInfo['customerInfo']
                                                                        [index]
                                                                    ['type'] !=
                                                                'file'
                                                            ? Text(
                                                                widget
                                                                    .checkInfo['customerInfo']
                                                                        [index][
                                                                        'value']
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 17,
                                                                  color: signColor
                                                                      .withOpacity(
                                                                          0.5),
                                                                ))
                                                            : Container(
                                                                height: MediaQuery.of(context)
                                                                        .size
                                                                        .height /
                                                                    10,
                                                                width: MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child: Image.network(
                                                                    'http://giovannis37.sg-host.com/' + widget.checkInfo['customerInfo'][index]['value'])),
                                                        Divider(),
                                                        /* Container(
                height: MediaQuery.of(context).size.height/10,
                width: MediaQuery.of(context).size.width/4,
                child: Image.network('http://giovannis37.sg-host.com/'+widget.data['customerInfo'][index]['value'])) :Text('arslan'),*/
                                                      ],
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 80,
        bottomOpacity: 0.0,

        centerTitle: true,
        title:  Text(
          widget.data['name'],
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),

      ),*/
                        /*Container(
                          height: displayHeight/1.2,
                         child: SingleChildScrollView(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: InkWell(
                                   onTap: (){
                                     print(widget.checkInfo);
                                   },
                                   child: Text('Name',
                                       style: TextStyle(
                                           color: signColor,
                                           fontSize: 15,
                                           fontWeight: FontWeight.bold)),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text(widget.checkInfo['name'] != null ? widget.checkInfo['name'] : '',
                                     style: TextStyle(
                                       color: signColor.withOpacity(0.5),)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text('Email',
                                     style: TextStyle(
                                         color: signColor,
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text(
                                   widget.checkInfo['email'] != null ? widget.checkInfo['email'] : '',
                                   style: TextStyle(color: signColor.withOpacity(0.5)),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text('Phone',
                                     style: TextStyle(
                                         color: signColor,
                                         fontSize: 15,
                                         fontWeight: FontWeight
                                         .bold)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text(
                                     widget.checkInfo['phone'] != null
                                         ? widget.checkInfo['phone'].toString()
                                         : '',style: TextStyle(
                                   color: signColor.withOpacity(0.5),)
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text('Age',
                                     style: TextStyle(
                                         color: signColor,
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text(
                                   widget.checkInfo['age'] != null ? widget.checkInfo['age'].toString() : '', style: TextStyle(color: signColor.withOpacity(0.5)),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text('Adults',
                                     style: TextStyle(
                                         color: signColor,
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text(
                                     widget.checkInfo['adults'] != null
                                         ? widget.checkInfo['adults'].toString()
                                         : '',
                                     style: TextStyle(
                                       color: signColor.withOpacity(0.5),) ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text('Childrens',
                                     style: TextStyle(
                                         color: signColor,
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold)),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                 child: Text(widget.checkInfo['children'] != null
                                     ? widget.checkInfo['children'].toString()
                                     : '',style: TextStyle(
                                   color: signColor.withOpacity(0.5),)),
                               ),
                               Container(
                                 child: ListView.builder(
                                   shrinkWrap: true,
                                   physics: NeverScrollableScrollPhysics(),
                                   itemCount: widget.checkInfo['customerInfo'].length,
                                   itemBuilder: (context, index) {
                                     return
                                       */ /*   Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     english == true ?
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(widget.data['customerInfo'][index]['label'] !=null ? widget.data['customerInfo'][index]['label']: '',style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                          ):Text(widget.data['customerInfocustomerInfo'][index]['label'] !=null ? widget.data['customerInfo'][index]['label']: '',style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                          if(widget.data['customerInfo'][index]['type'] == 'file')
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10,top: 10),
                              child: Container(
                                  height: MediaQuery.of(context).size.height/10,
                                  width: MediaQuery.of(context).size.width/4,
                                  child: Image.network('http://giovannis37.sg-host.com/'+widget.data['customerInfo'][index]['value'])),
                            ),
                          if(widget.data['customerInfo'][index]['type'] != 'file')
                            english == true ?
                            Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Text(widget.data['customerInfo'][index]['value'].toString()!=null ?widget.data['customerInfo'][index]['value'].toString():''),
                            ):    Text(widget.data['customerInfo'][index]['value'].toString()!=null ?widget.data['info'][index]['value'].toString():'')



                      ],

                    ),
                  );*/ /*
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Padding(
                                             padding: const EdgeInsets.only(top: 9,bottom: 10,left: 10),
                                             child: Text(widget.checkInfo['customerInfo'][index]['label'] != null
                                                 ? widget.checkInfo['customerInfo'][index]['label']
                                                 : '',style: TextStyle(  color: signColor,
                                                 fontSize: 15,
                                                 fontWeight: FontWeight.bold),),
                                           ),
                                           widget.checkInfo['customerInfo'][index]['type'] != 'file'
                                               ? Padding(
                                             padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                                             child: Text(widget.checkInfo['customerInfo'][index]['value']
                                                 .toString(), style: TextStyle(
                                               color: signColor.withOpacity(0.5),)),
                                           )
                                               : Padding(
                                             padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                                             child: Container(
                                                 height: MediaQuery.of(context).size.height / 10,
                                                 width: MediaQuery.of(context).size.width / 4,
                                                 child: Image.network(
                                                     'http://giovannis37.sg-host.com/' +
                                                         widget.checkInfo['customerInfo'][index]
                                                         ['value'])),
                                           ),

                                           */ /* Container(
                height: MediaQuery.of(context).size.height/10,
                width: MediaQuery.of(context).size.width/4,
                child: Image.network('http://giovannis37.sg-host.com/'+widget.data['customerInfo'][index]['value'])) :Text('arslan'),*/ /*
                                         ],
                                       );
                                   },
                                 ),
                               ),
                             ],
                           ),
                         ),
                       )*/
                        /*Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/50,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(widget.hotel['info'],style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      Text(dayText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Padding(
                        padding: const EdgeInsets.only(left: 2,right: 2),
                        child: Text(monthText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      ),
                      Text(yeartext,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),

                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/40,),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text('Duration',style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      Text(numberOfDaysText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Text(daystext,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Text(slashText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Text(numberNightsText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),

                      Text(nightsText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/40,),

          Align(
          alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Container(child: Text(discoverText,maxLines: 2,style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Text(fansText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
          ),
        ],
      ),*/
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
                          english == true
                              ? 'Checkin Details'
                              : 'Dettagli del check-in',
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
            ],
          ),
        ),
        SizedBox(
          height: displayHeight / 10,
        ),
      ],
    );
  }
}
