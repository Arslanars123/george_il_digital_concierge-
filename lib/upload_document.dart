import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:untitled6/test/one_screen.dart';

class UploadDocument extends StatefulWidget {
  UploadDocument(
      {Key? key,
      required this.data,
      required this.checkin,
      required this.userdata})
      : super(key: key);
  final dynamic data;
  final dynamic userdata;
  final dynamic checkin;

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<UploadDocument> {
  PickedFile? imageFile = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    void _openGallery(BuildContext context) async {
      final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );
      setState(() {
        imageFile = pickedFile!;
      });
    }

    upload() async {
      var postUri =
          Uri.parse("http://giovannis37.sg-host.com/api/upload-id-image");

      http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
      request.fields['user_id'] = userID.toString();
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('image', imageFile!.path);
      print(request);
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
    Future<http.Response> fetchStr() async {
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
      print(userID);
      var url = 'http://giovannis37.sg-host.com/api/upload-id-image';

      Map data = {
        'user_id': userID.toString(),
        'image': imageFile,
      };
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);

      print(jsonDecode(response.body));
      print("${response.statusCode}");
      print("${response.body}");
      return response;
    }

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
                        height: height / 4.5,
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
                    height: height / 2.5,
                    width: width / 1.15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                            english == true ? 'Upload ID' : 'Carica ID ',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: signColor),
                          )),
                          InkWell(
                            onTap: () {
                              _openGallery(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: forgotColor,
                                  borderRadius: BorderRadius.circular(30)),
                              height: height / 16,
                              width: width / 3,
                              child: Center(
                                child: Text(
                                  english == true
                                      ? 'Choose Image'
                                      : 'Scegli Immagine',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          imageFile == null
                              ? Image.asset(
                                  'assets/noimage.png',
                                  scale: 7,
                                )
                              : Container(
                                  height: height / 10,
                                  width: width / 10,
                                  child: Image.file(File(
                                    imageFile!.path,
                                  )),
                                ),
                          GestureDetector(
                            onTap: () async {
                              imageFile == null
                                  ? Fluttertoast.showToast(
                                      msg: "select image",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                  : upload();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen(
                                        data: widget.data,
                                        checkInfo: widget.checkin,
                                        userdata: widget.userdata)),
                              );
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
                                        english == true
                                            ? 'Upload Image'
                                            : 'Carica immagine',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

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
                    image: AssetImage('assets/updated_logoone.png'))),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 40,
          ),
          Center(
              child: Image.asset(
            'assets/updated_logotwowhite.png',
            scale: 10,
          ))
        ],
      ),
    );
  }
}
