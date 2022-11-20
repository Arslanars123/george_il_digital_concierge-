import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/hotels_screen.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/config/strings.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/test/one_screen.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/upload_document.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({required this.userdata});

  final dynamic userdata;

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<VerifyScreen> {
  var a;
  var b;
  var result;

  TextEditingController code = TextEditingController();

  Future<http.Response> fetchStr(String reservationCode) async {
    showDialog(
      context: context,
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
    var url = 'http://giovannis37.sg-host.com/api/check-code';
    var prefrence = await SharedPreferences.getInstance();
    Map data = {
      'reservation_code': reservationCode,
      'user_id': prefrence.getInt('id'),
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    a = jsonDecode(response.body);
    var pref = await SharedPreferences.getInstance();
    Navigator.pop(context);
    if (a['status'] == 200) {
      b = a['data'];
      var check = a['data2'];

      pref.setString('reservation', code.text);

      pref.setString('hotelemail', a['data']['email']);
      setState(() {
        reserveCode = pref.getString('reservation');
        hotelemail = pref.getString('hotelemail');
        useremail = pref.get('email');
        username = pref.getString('name');
        userimage = pref.getString('image');
      });


      print('arslankjbxdwkqjgdgeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      print('arslan'+check.toString());
      print('ididididiididiidididiidididididididdiiddiididid');
      print('arslan'+ widget.userdata.toString());
      print('ididididiididiidididiidididididididdiiddiididid');
      print('arslankjbxdwkqjgdgeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      a['message'] != 'No user belong to this code'
          ? await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                    data: a['data'],
                    checkInfo: check,
                    userdata: widget.userdata),
              ),
              (Route<dynamic> route) => false)
          : Fluttertoast.showToast(
              msg: "Something wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
      ;
    }
    if (a['status'] == 200 &&
        a['message'] == 'Reservation code does not belong to this user') {
      setState(() {
        result = 'User does not belong to this code';
      });
    } else if (a['status'] == 401 &&
        a['message'] == 'Some field is missing. All fields are required') {
      setState(() {
        result = 'fields missing';
      });
      Fluttertoast.showToast(
          msg: "Something wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      result = null;
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
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
          child: Container(
            height: height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 22,
                      ),
                      Logo()
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 3.7,
                      ),
                      Container(
                        height: height / 12,
                        width: width / 1.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white.withOpacity(0.15)),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 3.5,
                      ),
                      Container(
                        height: height / 35,
                        width: width / 1.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white.withOpacity(0.15)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: height / 2.8,
                    width: width / 1.15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                              english == true
                                ? 'Enter Your Booking Code'
                                : 'Inserisci il tuo codice di prenotazione',
                            style: TextStyle(
                                fontSize: width / 20,
                                fontWeight: FontWeight.bold,
                                color: signColor),
                          ),
                        )),
                        SizedBox(
                          height: height / 50,
                        ),
                        Container(
                            width: width / 1.5,
                            child: Container(
                              width: width / 1.35,
                              child: TextFormField(
                                validator: MultiValidator([
                                  EmailValidator(
                                      errorText: 'email is not valid'),
                                  RequiredValidator(errorText: 'field is empty')
                                ]),
                                controller: code,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    errorText: result,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: signColor.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: signColor.withOpacity(0.3),
                                          width: 1),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: english == true
                                        ? 'Booking Code'
                                        : 'Codice di prenotazione',
                                    hintStyle: TextStyle(
                                        color: signColor.withOpacity(0.3),
                                        fontSize: width / 25)),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () async {
                              var preference =
                                  await SharedPreferences.getInstance();
                              if (preference.getString('image') != null) {
                                setState(() {
                                  userimage = preference.get('image');
                                });
                              }
                              setState(() {
                                useremail = preference.getString('email');
                              });
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationScreen()),
                              );

                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: width / 1.5,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        english == true
                                            ? 'Continue Without Booking Code?'
                                            : 'Continua senza codice di prenotazione ?',
                                        style: TextStyle(
                                            fontSize: width / 28,
                                            color: bottomCircleColor))
                                    /*Row(
                                    children: [
                                      Text(
                                        codeReceiveText,
                                        style:
                                        TextStyle(fontSize: 12, color: signColor),

                                      ),
                                      Text(
                                        resendText,
                                        style:
                                        TextStyle(fontSize: 12, color: forgotColor),
                                      ),
                                    ],
                                  ),*/
                                    )),
                          ),
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        InkWell(
                          onTap: () async {
                            fetchStr(code.text);

                            /* Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Screen1()),
                            );*/
                          },
                          child: Container(
                              height: height / 16,
                              width: width / 1.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: forgotColor,
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      english == true ? 'Continue' : 'Continua',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 19),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.15),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ) /*Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Text('SignIn',style: TextStyle(color: Colors.white,fontSize: 12),),
                             CircleAvatar(
                               child: Icon(
                                 Icons.arrow_forward,
                                 color: Colors.white,
                               ),
                             ),
                                ],
                              ),*/
                              ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width / 6,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/mustache_arslan.png'))),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 40,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.3,
            width: MediaQuery.of(context).size.width / 2.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/white_logo_arslan_.png'))),
          )
        ],
      ),
    );
  }
}
