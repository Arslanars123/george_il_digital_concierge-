import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/config/strings.dart';
class HotelReviewsScreen extends StatefulWidget {
  const HotelReviewsScreen({Key? key}) : super(key: key);

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<HotelReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 80,
        bottomOpacity: 0.0,

        centerTitle: true,
        title: const Text(
          'Reviews',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),

      ),*/
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Container(
                                height: height / 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                              ),
                            ),
                            Container(
                              height: height / 5,
                              width: width / 1.15,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          bookingAvailableText,
                                          style: TextStyle(
                                              color: bookAvailableColor,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          sisneylandText,
                                          style: TextStyle(
                                              color: signColor,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    Text(parisText,
                                        style: TextStyle(
                                            color: signColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height / 9,
                              width: width / 1.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Row(
                                children: [
                                  Container(
                                    height: height / 9,
                                    width: width / 3,
                                    decoration: BoxDecoration(
                                        color: ratingContainerColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                        )),
                                    child: Center(
                                        child: Text(
                                          '9.3',
                                          style: TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: forgotColor,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 5),
                                                  child: Container(
                                                    height: height / 60,
                                                    width: width / 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                            Colors.white)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 5),
                                                  child: Container(
                                                    height: height / 60,
                                                    width: width / 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                            Colors.white)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 5),
                                                  child: Container(
                                                    height: height / 60,
                                                    width: width / 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                            Colors.white)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 5),
                                                  child: Container(
                                                    height: height / 60,
                                                    width: width / 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                            Colors.white)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 5),
                                                  child: Container(
                                                    height: height / 60,
                                                    width: width / 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                            Colors.white)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10),
                                                  child: Text(
                                                    '(512 reviews)',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ))
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
                        Positioned(
                          left: width / 1.5,
                          child: CircleAvatar(
                            radius: width / 15,
                            backgroundColor: bookAvailableColor,
                            child: Center(
                                child: Image.asset(
                                  'assets/thunder.png',
                                  scale: width / 200,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 50,
              ),
              Container(
                height: height/2.5,
                child: Container(
                  height: height / 4,
                  child: ListView.builder(
                    itemCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.brown,
                                            radius: width / 13,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    'Serina smith',
                                                    style: TextStyle(
                                                      color: signColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: height / 60,
                                                      width: width / 40,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Colors
                                                                  .orange)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 5,
                                                          right: 5),
                                                      child: Container(
                                                        height: height / 60,
                                                        width: width / 40,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .orange)),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                      child: Container(
                                                        height: height / 60,
                                                        width: width / 40,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .orange)),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                      child: Container(
                                                        height: height / 60,
                                                        width: width / 40,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .orange)),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: height / 60,
                                                      width: width / 40,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: signColor
                                                                  .withOpacity(
                                                                  0.5))),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            child: Text(
                                              '27',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: signColor
                                                      .withOpacity(0.5)),
                                            ),
                                          ),
                                          Text(
                                            'December',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: signColor.withOpacity(0.5),
                                            ),
                                          ),
                                          Text(
                                            '2019',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                signColor.withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      versalText,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: signColor.withOpacity(0.5)),
                                      maxLines: 3,
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: signColor.withOpacity(0.5),
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: height/12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height/13,
                      width: width/2.5,
                      decoration: BoxDecoration(
                          color: bottomCircleColor,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(child: Text('View All',style: TextStyle(color: Colors.white,fontSize: 16),)),
                    ),
                    SizedBox(width: width/20,),
                    Container(
                      height: height/13,
                      width: width/2.5,
                      decoration: BoxDecoration(
                          color: bottomCircleColor,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(child: GestureDetector(
                          onTap: (){
                            _modalBottomSheetMenu(context);
                          },
                          child: Text('Add Review',style: TextStyle(color: Colors.white,fontSize: 16),))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _modalBottomSheetMenu( BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(

                            height: MediaQuery.of(context).size.height/20,
                            width: MediaQuery.of(context).size.width/20,
                            decoration: BoxDecoration(

                                image: DecorationImage(

                                  image: AssetImage('assets/letter-x.png'),
                                )
                            ),
                          ),
                          Text('Add Review',style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                          Text('Done',style: TextStyle(color: bottomCircleColor,fontSize: 15,fontWeight: FontWeight.bold),)

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Text('Rate this Application',style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                      child: Text('Tell Others what you think',style: TextStyle(color: signColor.withOpacity(0.3),fontSize: 15,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width:MediaQuery.of(context).size.width/ 27,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: signColor
                                        .withOpacity(
                                        0.5))),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/12,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width:MediaQuery.of(context).size.width/ 27,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: signColor
                                        .withOpacity(
                                        0.5))),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/12,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width:MediaQuery.of(context).size.width/ 27,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: signColor
                                        .withOpacity(
                                        0.5))),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/12,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width:MediaQuery.of(context).size.width/ 27,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: signColor
                                        .withOpacity(
                                        0.5))),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/12,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width:MediaQuery.of(context).size.width/ 27,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: signColor
                                        .withOpacity(
                                        0.5))),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Text('Descibe your Experience',style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                bottom: 11, top: 11, right: 15),
                            hintText: 'Write Here',
                            hintStyle:
                            TextStyle(color: signColor.withOpacity(0.5),fontSize: 12)),
                      ),
                    ),
                  ],
                )),
          );
        }
    );
  }
}
