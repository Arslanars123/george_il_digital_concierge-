import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:untitled6/favourite_screen.dart';

import 'config/colors.dart';
class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<AddProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 80,
        bottomOpacity: 0.0,
        leading: const Icon(
          Icons.tune_outlined,
          color: Colors.grey,
          size: 30,
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
       Center(child: Padding(
         padding:  EdgeInsets.only(right: width/13),
         child: Text('Edit',style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 16),),
       ))
        ],
      ),
      body:
          Padding(
            padding:  EdgeInsets.only(left: width/30,right: width/30),
            child: Stack(
              children: [

                Column(
                  children: [
                    SizedBox(height: height/10,),
                    InkWell(
                      onTap: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FavouriteScreen(data: '',)),
                        );

                      },
                      child: Container(
                        width: width/3,
                        height: height/7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/picture.jpeg'),
                          )
                        ),

                      ),
                    ),
                    SizedBox(height: height/20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Field(width: width,text: 'Email',),
                        Field(width: width,text: 'Phone',),
                        Field(width: width,text: 'Gender',),
                        Field(width: width,text: 'Date Of Birth',),
                        Field(width: width,text: 'Address',),
                        SizedBox(height: height/14,),
                        Container(
                          height: height/14,
                          width: width/1.6,

                          child: ElevatedButton(
                            child: Text(
                                'Continue',
                                style: TextStyle(fontSize: 14)
                            ),
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(bottomCircleColor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),

                                    )
                                )
                            ),
                            onPressed: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FavouriteScreen(data: '',)),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: height/4.6,
                  left: width/1.8,
                  child:  CircleAvatar(
                    radius: width/25,
                    backgroundColor: forgotColor,
                    child: Icon(Icons.camera_alt,color: Colors.white,size: 15,),
                  ),
                )
              ],
            ),
          ),



    );
  }

}

class Field extends StatelessWidget {

 Field({
    Key? key,
    required this.width,
    required this.text,

  }) : super(key: key);

  final double width;
    String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: width,
          child: TextFormField(
            cursorColor: Colors.black,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    left: 15, bottom: 11, top: 11, right: 15),
                hintText: text,
                hintStyle:
                TextStyle(color: signColor.withOpacity(0.3),fontSize: 14)),
          ),
        ),
        Container(
          width: width,
          child: Divider(
            height: 2,
            color: signColor.withOpacity(0.3),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/50,
        )
      ],
    );
  }
}
