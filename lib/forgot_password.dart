import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/config/strings.dart';
import 'package:untitled6/sign_up.dart';
import 'package:untitled6/signin_screen.dart';
import 'package:untitled6/verify_screen.dart';
import 'package:http/http.dart' as http;

import 'global.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<ForgotPasswordScreen> {
  var decode;
  var b;
var message;
var response;

  Future<http.Response> fetchStr(String e) async {
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
    var url = 'http://giovannis37.sg-host.com/api/forgot-password';

    Map data = {
      'email': e,
    };

    //encode Map to JSON
    var body = json.encode(data);
    bool result;
    try{
      result = await InternetConnectionChecker().hasConnection;
      if(result == true){
        try{
          response = await http.post(Uri.parse(url),
              headers: {"Content-Type": "application/json"}, body: body);

          decode = jsonDecode(response.body);
          if(decode['status']== 200){
            if(decode['message']== 'Email is incorrect'){
              setState(() {
                message = 'Email not exist';
              });
            }else{
              message = null;

            }
           Navigator.pop(context);
           await Fluttertoast.showToast(msg: 'check Your Email',textColor: Colors.green);
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SignInScreen()),
            );
          }else{
            await Fluttertoast.showToast(
                msg: "something wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }

          print(jsonDecode(response.body));
          print("${response.statusCode}");
          print("${response.body}");
        }catch(e){
          await Fluttertoast.showToast(
              msg: "something wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

      } else
      {
        await Fluttertoast.showToast(
            msg: "no internet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }catch(e){
      await Fluttertoast.showToast(
          msg: "something wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    return response;
  }
  TextEditingController email = TextEditingController();
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height / 13,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                         english== true ?havingTroubleText:'Avere problemi? Ottenere aiuto?',
                          style: TextStyle(fontSize: width/24, color: Colors.white),
                        )),
                    SizedBox(
                      height: height / 20,
                    ),
                  ],
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
                            child: Text(
                         english == true ? forgotPassword:'Ha dimenticato la password',
                          style: TextStyle(
                              fontSize: width/17,
                              fontWeight: FontWeight.bold,
                              color: signColor),
                        )),
                        Container(
                          width: width / 1.35,
                          child: TextFormField(
                            validator: MultiValidator([
                              EmailValidator(errorText: 'email is not valid'),
                              RequiredValidator(errorText: 'field is empty')
                            ]),
                            controller: email,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              errorText: message,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(  color: signColor.withOpacity(0.3),width: 1,),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:    signColor.withOpacity(0.3),width:1
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: 'Email',
                                hintStyle:
                                TextStyle(color: signColor.withOpacity(0.3),fontSize: width/25)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                              alignment: Alignment.center,
                              width: width / 1.5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                     english == true? dontHaveText+'':'non hai un account? ',
                                      style: TextStyle(
                                          fontSize: width/27, color: signColor),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  SignUpScreen()),
                                        );
                                      },
                                      child: Text(
                                       english == true? registerText:'Registrati qui?',
                                        style: TextStyle(
                                            fontSize: width/27, color: forgotColor),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        GestureDetector(
                          onTap: ()async {
                            fetchStr(email.text);


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
                                      english == true ? forgotPassword:'Dimenticato',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                              )
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
