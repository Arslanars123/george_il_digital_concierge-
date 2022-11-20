import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled6/hotels_screen.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/config/strings.dart';
import 'package:untitled6/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/forgot_password.dart';
import 'package:untitled6/sign_up.dart';
import 'package:untitled6/verify_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<SignInScreen> {
  var data;
  var name;
  var message;

  Future<http.Response> facebookgoggle(String email, String name) async {
    showDialog(
      context: context,
      barrierDismissible: loading,
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

    var url = 'http://giovannis37.sg-host.com/api/facebook-google';

    Map data = {
      'name': name,
      'email': email,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response;
    bool result;
    result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('check karien');
      try {
        response = await http.post(Uri.parse(url),
            headers: {"Content-Type": "application/json"}, body: body);

        data = jsonDecode(response.body);
        print(data);
        name = data['data']['name'];
        if (data['data']['language'] == 'english') {
          setState(() {
            english = true;
          });
        } else {
          setState(() {
            english = false;
          });
        }
        if (data['status'] == 200) {
          var prefrence = await SharedPreferences.getInstance();
          await prefrence.setInt('id', data['data']['id']);
          if (data['data']['image'] != null) {
            await prefrence.setString('name', data['data']['image']);
            setState(() {
              userimage = prefrence.getString('image');
            });
          }
          await prefrence.setString('name', data['data']['name']);
          await prefrence.setString('email', data['data']['email']);
          setState(() {
            useremail = prefrence.getString('email');
            username = prefrence.getString('name');
          });
          userID = prefrence.getInt('id');
          print(prefrence.getInt('id'));
          Fluttertoast.showToast(
              msg: "Login Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
          await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyScreen(
                        userdata: data['data'],
                      )),
              (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(
              msg: "user not exist",
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
    }

    print(jsonDecode(response.body));

    return response;
  }

  bool loading = true;

  Future<http.Response> fetchStr(String email, String password) async {
    showDialog(
      context: context,
      barrierDismissible: loading,
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
    var url = 'http://giovannis37.sg-host.com/api/login';

    Map data = {
      'password': password,
      'email': email,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response;
    bool result;
    result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        response = await http.post(Uri.parse(url),
            headers: {"Content-Type": "application/json"}, body: body);

        data = jsonDecode(response.body);
        print(data['data']);
        name = data['data']['name'];
        if (data['data']['language'] == 'english') {
          setState(() {
            english = true;
          });
        } else {
          setState(() {
            english = false;
          });
        }
        if (data['status'] == 200) {
          var prefrence = await SharedPreferences.getInstance();

          print(data['data']);

          await prefrence.setInt('id', data['data']['id']);

          if (data['data']['phone'] != null) {
            await prefrence.setString('phone', data['data']['phone']);
            setState(() {
              userphone = prefrence.getString('phone')!;
            });
          }
          if (data['data']['image'] != null) {
            await prefrence.setString('image', data['data']['image']);
            setState(() {
              userimage = prefrence.getString('image');
            });
          }

          await prefrence.setString('name', data['data']['name']);
          await prefrence.setString('email', data['data']['email']);

          setState(() {
            useremail = prefrence.getString('email');
            username = prefrence.getString('name');
          });
          Fluttertoast.showToast(
              msg: "Login Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyScreen(
                        userdata: data['data'],
                      )),
              (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(
              msg: "user not exist",
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
    }

    return response;
  }

  bool checkvalue = false;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          child: Form(
            key: _formKey,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              signInWithFacebook();
                            },
                            child: Container(
                              height: height / 13,
                              width: width / 6,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/facebook-logo.png',
                                  scale: 1.7,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width / 17,
                          ),
                          InkWell(
                            onTap: () {
                              signInWithGoogle();
                            },
                            child: Container(
                              height: height / 13,
                              width: width / 6,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Image.asset(
                                  'assets/search.png',
                                  scale: 1.7,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Container(
                          height: height / 22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                english == true
                                    ? 'Dont have an account ? '
                                    : 'Non hai un account ?',
                                style: TextStyle(
                                    fontSize: width / 25, color: Colors.white),
                              ),
                              Text(
                                english == true ? 'SignUp' : 'Registrati',
                                style: TextStyle(
                                    fontSize: width / 25, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 30,
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 4.3,
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
                          height: height / 4,
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
                      height: height / 2.4,
                      width: width / 1.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                            english == true ? signinText : 'Accedi',
                            style: TextStyle(
                                fontSize: width / 15,
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
                              controller: emailController,
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
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
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: signColor.withOpacity(0.3),
                                      fontSize: width / 25)),
                            ),
                          ),
                          Container(
                            width: width / 1.35,
                            child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'password is required'),
                              ]),
                              controller: passwordController,
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
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
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: signColor.withOpacity(0.3),
                                      fontSize: width / 25)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()),
                                );
                              },
                              child: Container(
                                  alignment: Alignment.topRight,
                                  width: width / 1.5,
                                  child: Text(
                                    english == true
                                        ? 'Forgot Password?'
                                        : 'Password dimenticata ?',
                                    style: TextStyle(
                                        fontSize: width / 25,
                                        color: forgotColor),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await fetchStr(
                                  emailController.text,
                                  passwordController.text,
                                );

                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Something Wrong",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
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
                                        english == true ? 'SignIn' : 'Accedi',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width / 17),
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
      ),
    );
  }

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();
//
//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
//
//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
  Future<UserCredential> signInWithFacebook() async {
    Map<String, dynamic>? _userData;

    final LoginResult logInResult =
        await FacebookAuth.instance.login(permissions: [
      'email',
      'public_profile',
    ]);

    if (logInResult == LoginStatus.success) {
      final facebookUserData = await FacebookAuth.instance.getUserData();
      _userData = facebookUserData;
    } else {}
    final OAuthCredential oAuthCredential =
        FacebookAuthProvider.credential(logInResult.accessToken!.token);
    final facebookUserData = await FacebookAuth.instance.getUserData();
    _userData = facebookUserData;
    if (_userData['name'] != null && _userData['email'] != null) {
      print('arslan');
      facebookgoggle(_userData['email'], _userData['name']);
    } else {
      Fluttertoast.showToast(msg: 'something wrong');
    }

    print(_userData['name']);

    return FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    facebookgoggle(
        userCredential.additionalUserInfo!.profile!['email'].toString(),
        userCredential.additionalUserInfo!.profile!['name'].toString());

    print(userCredential.additionalUserInfo!.profile!['email']);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
