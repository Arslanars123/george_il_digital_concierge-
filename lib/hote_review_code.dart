import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled6/config/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/test/view_reviews_without.dart';

class ReviewsScreenCode extends StatefulWidget {
  ReviewsScreenCode({Key? key, required this.data}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreenCode> {
  TextEditingController comment = TextEditingController();
  double _userRating = 3.0;

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
    var url = 'http://giovannis37.sg-host.com/api/rate-hotel';

    Map data = {
      'stars': _userRating.toString(),
      'comment': comment.text,
      'hotel_id': widget.data['id'],
      'user_id': userID,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    print(jsonDecode(response.body));
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height / 1.15,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.data['average_rating'].toString(),
                      style: TextStyle(
                          color: forgotColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: width / 3.5,
                      child: RatingBarIndicator(
                        rating: 1.1,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          size: 1,
                          color: forgotColor,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      'Number of reviews',
                      style: TextStyle(
                        color: signColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Flexible(
                      child: Text(
                    widget.data['number_of_reviews'].toString(),
                    style: TextStyle(
                      color: forgotColor,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                  )),
                ],
              ),
              SizedBox(
                height: height / 50,
              ),
              Container(
                height: height / 2.7,
                child: ListView.builder(
                  itemCount: widget.data['reviews_array'].length > 3 ? 4 : 1,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: widget.data['reviews_array'].length > 0
                          ? Container(
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
                                          SizedBox(
                                            width: width / 50,
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                if (widget.data['reviews_array']
                                                        [index]['user_image'] !=
                                                    null)
                                                  Container(
                                                    child: CachedNetworkImage(
                                                      imageUrl: widget.serv +
                                                          widget.data[
                                                                  'reviews_array']
                                                              [
                                                              index]['user_image'],
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                    ),
                                                    height: height / 10,
                                                    width: width / 8,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle),
                                                  ),
                                                if (widget.data['reviews_array']
                                                        [index]['user_image'] ==
                                                    null)
                                                  Container(
                                                    height: height / 10,
                                                    width: width / 8,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.6),
                                                        shape: BoxShape.circle),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 50,
                                          ),
                                          Container(
                                            width: width / 1.3168,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Text(
                                                    widget.data['reviews_array']
                                                            [index]['user_name']
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: signColor,
                                                      fontSize: width / 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    print(widget
                                                        .data['reviews_array']);
                                                  },
                                                  child: Container(
                                                    width: width / 3.5,
                                                    child: RatingBarIndicator(
                                                      rating: widget
                                                          .data['reviews_array']
                                                              [index]['stars']
                                                          .toDouble(),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        size: 1,
                                                        color: forgotColor,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 20.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: width / 1.4,
                                                  child: Text(
                                                    widget.data['reviews_array']
                                                                    [index]
                                                                ['comment'] !=
                                                            null
                                                        ? widget.data[
                                                                'reviews_array']
                                                            [index]['comment']
                                                        : '',
                                                    style: TextStyle(
                                                        fontSize: width / 23,
                                                        color: signColor
                                                            .withOpacity(0.5)),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 50,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider()
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                    );
                  },
                ),
              ),
              SizedBox(height: height/22,),
              Container(
                height: height / 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewsAllWithout(
                                  hotel: widget.data['reviews_array'],id: widget.data['id'],)),
                        );
                      },
                      child: Container(
                        height: height / 13,
                        width: width / 2.5,
                        decoration: BoxDecoration(
                            color: bottomCircleColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Text(
                          english == true ? 'View All' : "Mostra tutto",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    /*Container(
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
                    )*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 20,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/letter-x.png'),
                            )),
                          ),
                          Text(
                            'Add Review',
                            style: TextStyle(
                                color: signColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () {
                                print(widget.data);
                                fetchStr();
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: bottomCircleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        'Rate this Application',
                        style: TextStyle(
                            color: signColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: Text(
                        'Tell Others what you think',
                        style: TextStyle(
                          color: signColor.withOpacity(0.3),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    /* Padding(
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
                    ),*/
                    RatingBar.builder(
                      initialRating: _userRating,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 5,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    /* RatingBarIndicator(
                      rating: 2.75,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 10.0,
                      direction: Axis.horizontal,
                    ),*/
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        'Descibe your Experience',
                        style: TextStyle(
                            color: signColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        controller: comment,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(bottom: 11, top: 11, right: 15),
                            hintText: 'Write Here',
                            hintStyle: TextStyle(
                                color: signColor.withOpacity(0.5),
                                fontSize: 12)),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
