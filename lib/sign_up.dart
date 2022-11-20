import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/config/strings.dart';
import 'package:untitled6/global.dart';
import 'dart:async';
import 'package:untitled6/forgot_password.dart';
import 'package:untitled6/signin_screen.dart';
import 'package:untitled6/verify_screen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<SignUpScreen> {
  var a;
  var b;
  var message;
   bool loading = true;
   Future<http.Response> fetchStr (String name, String phone,String password,String email) async {
     showDialog(
       context: context,
       barrierDismissible: loading,
       builder: (BuildContext context) {
         return  Container(
           height: 20,
             width: 20,
             child: Center(child: CircularProgressIndicator(
               backgroundColor: forgotColor,
             )));


       },
     );
     var url ='http://giovannis37.sg-host.com/api/register';

     Map data = {
       'name': name,
       'phone' :phone,
       'password' :password,
       'email' : email,

     };
     //encode Map to JSON
     var body = json.encode(data);
     var response;
     bool result;
      result = await InternetConnectionChecker().hasConnection;
       if(result == true) {
         try{
           response = await http.post( Uri.parse(url),
               headers: {"Content-Type": "application/json"},
               body: body
           );
           a = jsonDecode(response.body);
           print(a);
           if(a['status'] == 200 ){
             var preference = await SharedPreferences.getInstance();
             await preference.setInt('id', a['data']['id']);
             if(a['data']['image'] != null  ){
               await  preference.setString('name', a['data']['image']);
               setState(() {
                 userimage =preference.getString('image');
               });
             }
             await  preference.setString('name', a['data']['name']);
             await preference.setString('email', a['data']['email']);
             setState(() {
               useremail = preference.getString('email');
               username = preference.getString('name');


             });



           }
           if(a['message'] == 'Email already exists'){
             setState(() {
               message = 'Email already exists';
             });
           }else{
             message = null;
           }
         } catch(e){
         }

       } else {

        await Fluttertoast.showToast(
             msg: "No internet",
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

   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return forgotColor;
      }
      return forgotColor;
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
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
                        SizedBox(height: height/40,),
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
                            onTap: ()async{
                              signInWithFacebook();
                            },
                            child: Container(
                              height: height/13,
                              width: width/6,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset('assets/facebook-logo.png',scale: 1.7,),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width/17,
                          ),
                          InkWell(
                            onTap: (){
                              signInWithGoogle();

                            },
                            child: Container(
                              height: height/13,
                              width: width/6,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.white),
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                child: Image.asset('assets/search.png',scale: 1.7,),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height/30,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInScreen()),
                          );
                        },
                        child: Container(
                          height: height/22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(english ==true ?'Already have an account  ? ' :'Non hai un account ?',style: TextStyle(fontSize: width/25,color: Colors.white),),
                              Text(english == true ?'Signin':'Registrati',style: TextStyle(fontSize: width/25,color: Colors.white),)

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height/30,
                      )

                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 5.7,
                        ),

                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 5.3,
                        ),

                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: height/40,),
                            Logo()
                          ],
                        ),
                        SizedBox(height: height/30,),
                        Container(
                       width: width,
                          height: height/35,
                          child: Stack(
                            children: [

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: height / 55,
                                  width: width / 1.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Colors.white.withOpacity(0.15)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: height / 35,
                                  width: width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Colors.white.withOpacity(0.15)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width / 1.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [

                                        SizedBox(height: height/40,),
                                        Container(
                                            child: Text(
                                            english == true?  signUpText:'Registrati',
                                              style: TextStyle(
                                                  fontSize: width/16,
                                                  fontWeight: FontWeight.bold,
                                                  color: signColor),
                                            )),
                                        Container(

                                          width: width / 1.35,
                                          child: TextFormField(
                                            validator: RequiredValidator(errorText: 'enter email'),
                                            controller: nameController,
                                            cursorColor: Colors.black,
                                            decoration: new InputDecoration(

                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(  color: signColor.withOpacity(0.3),width: 1,),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color:    signColor.withOpacity(0.3),width:1
                                                ),
                                              ),
                                                contentPadding: EdgeInsets.only(
                                                    left: 15, bottom: 8, top: 5, right: 15),
                                                hintText: english == true?'Name':"Nome",
                                                hintStyle:
                                                TextStyle(color: signColor.withOpacity(0.3),fontSize: width/26),),
                                          ),
                                        ),


                                        Container(
                                          width: width / 1.35,
                                          child: TextFormField(
                                            controller: emailController,
                                            cursorColor: Colors.black,
                                            validator: MultiValidator(
                                              [
                                                RequiredValidator(errorText: 'please enter email',),
                                                EmailValidator(errorText: 'email not valid')
                                              ]
                                            ),
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
                                                  left: 15, bottom: 8, top: 8, right: 15),
                                              hintText: 'Email',
                                              hintStyle:
                                              TextStyle(color: signColor.withOpacity(0.3),fontSize: width/26),),
                                          ),
                                        ),
                                    /*    Container(
                                          width: width / 1.5,
                                          child: Divider(
                                            height: 2,
                                            color: signColor.withOpacity(0.3),
                                          ),
                                        ),*/
                                        Container(

                                          width: width / 1.35,
                                          child: TextFormField(
                                            validator:  MultiValidator([
                                              RequiredValidator(errorText: 'password is required'),
                                              MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
                                              PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
                                            ]) ,
                                            controller: passwordController,
                                            cursorColor: Colors.black,
                                            decoration: new InputDecoration(

                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(  color: signColor.withOpacity(0.3),width: 1,),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color:    signColor.withOpacity(0.3),width:1
                                                ),
                                              ),
                                                contentPadding: EdgeInsets.only(
                                                    left: 15, bottom: 8, top: 8, right: 15),
                                                hintText: 'Password',
                                                hintStyle:
                                                TextStyle(color: signColor.withOpacity(0.3),fontSize: width/26),),
                                          ),
                                        ),

                                        Container(

                                          width: width / 1.35,
                                          child: TextFormField(
                                            validator: RequiredValidator(errorText: 'Password is required'),
                                            controller: phoneController,
                                            cursorColor: Colors.black,
                                            decoration: new InputDecoration(

                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(  color: signColor.withOpacity(0.3),width: 1,),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color:    signColor.withOpacity(0.3),width:1
                                                ),
                                              ),
                                                contentPadding: EdgeInsets.only(
                                                    left: 15, bottom: 8, top: 8, right: 15),
                                                hintText: 'Phone Number',
                                                hintStyle:
                                                TextStyle(color: signColor.withOpacity(0.3),fontSize: width/26),),
                                          ),
                                        ),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      Container(

                                        width: width / 1.5,
                                        child: Row(

                                          children: [
                                            Text(english == true? 'i agree with the terms and conditions?': 'Accetto termini e condizioni?',style: TextStyle(fontSize: width/25,color: signColor),),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),

                                  GestureDetector(
                                    onTap: () async {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate() && isChecked == true) {

                                        await fetchStr(nameController.text, phoneController.text, passwordController.text, emailController.text);
                                        if(a['status']== 200){
                                          Fluttertoast.showToast(
                                              msg: "User Registered",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                          await  Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => VerifyScreen(userdata: a['data'],)),
                                                  (Route<dynamic> route) => false
                                          );

                                        }
                                       else {
                                         Navigator.pop(context);
                                         Fluttertoast.showToast(msg: 'no');
                                        }

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
                                               english == true ? 'SignUp' :'Registrati',
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: width/19),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child:    CircleAvatar(
                                                backgroundColor: Colors.white.withOpacity(0.15),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),),
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
                                  ),
                                  SizedBox(height: height/60,)
                                      ],
                                    ),
                            ),



                            ),
                          ),

                      ],
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
  Future<http.Response> facebookgoggle (String email,String name) async {

/*  showDialog(
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
  );*/

    var url ='http://giovannis37.sg-host.com/api/facebook-google';

    Map data = {

      'name' : name,
      'email' : email,

    };
    //encode Map to JSON
    var body = json.encode(data);
    var response;
    bool result;
    result = await InternetConnectionChecker().hasConnection;
    if(result == true){
      print('check karien');
      try{
        response = await http.post( Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: body
        );

        a = jsonDecode(response.body);


        if(a['data']['language'] == 'english'){
          setState(() {
            english = true;
          });
        }else{
          setState(() {
            english = false;
          });
        }
        if(a['status']==200){
          var preference = await SharedPreferences.getInstance();
          await preference.setInt('id', a['data']['id']);
          if(a['data']['image'] != null  ){
            await  preference.setString('name', a['data']['image']);
            setState(() {
              userimage =preference.getString('image');
            });
          }
          await  preference.setString('name', a['data']['name']);
          await preference.setString('email', a['data']['email']);
          setState(() {
            useremail = preference.getString('email');
            username = preference.getString('name');


          });
          print(a['data']);
          Fluttertoast.showToast(
              msg: "Login Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pop(context);
          await  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerifyScreen(userdata: a['data'],)),
          );

        }
        else{
          Fluttertoast.showToast(
              msg: "user not exist",
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
    }else{
      Fluttertoast.showToast(
          msg: "No internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }




    print(jsonDecode(response.body));

    return response;


  }
  Future<UserCredential> signInWithFacebook() async {
    Map<String, dynamic>? _userData;

    final LoginResult logInResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile',]);
    if (logInResult == LoginStatus.success) {

      final facebookUserData = await FacebookAuth.instance.getUserData();
      _userData = facebookUserData;


    } else {


    }
    final OAuthCredential oAuthCredential =
    FacebookAuthProvider.credential(logInResult.accessToken!.token);
    final facebookUserData = await FacebookAuth.instance.getUserData();
    _userData = facebookUserData;
    if(_userData['name'] !=null && _userData['email'] != null){
      print('arslan');
      facebookgoggle(_userData['email'], _userData['name']);
    }
    else{
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
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    facebookgoggle(userCredential.additionalUserInfo!.profile!['email'].toString(), userCredential.additionalUserInfo!.profile!['name'].toString());

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
/*
showDialog(
context: context,
barrierDismissible: loading,
builder: (BuildContext context) {
return Dialog(
child: new Row(
mainAxisSize: MainAxisSize.min,
children: [
new CircularProgressIndicator(),
new Text("Loading"),
],
),
);
},
);*/
