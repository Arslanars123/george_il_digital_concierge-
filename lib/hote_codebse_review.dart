import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/test/reviews_all.dart';
import 'package:untitled6/test/seven_screen.dart';

class CodeBaseReview extends StatefulWidget {
  CodeBaseReview(
      {Key? key,
      required this.data,
      required this.userdata,
      required this.checkInfo})
      : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic userdata;
  final dynamic checkInfo;

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<CodeBaseReview> {
  TextEditingController comment = TextEditingController();
  double _userRating = 0;

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
    var pref = await SharedPreferences.getInstance();
    Map data = {
      'stars': _userRating.toString(),
      'comment': comment.text,
      'hotel_id': widget.data['id'],
      'user_id': pref.getInt('id'),
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var checking = jsonDecode(response.body);
    if (checking['status'] == 200) {
      Fluttertoast.showToast(
          msg: "Review added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: forgotColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "something wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }

    print(jsonDecode(response.body));
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }
@override
  void initState() {
 print(widget.data['reviews_array']);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: height / 50,
              ),
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
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    widget.data['number_of_reviews'].toString(),
                    style: TextStyle(
                      color: forgotColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 50,
              ),
              InkWell(
                onTap: () {
                  print(widget.data['average_rating']);
                },
                child: SizedBox(
                  width: width,
                  height: height / 50,
                ),
              ),
              Container(
                height:widget.data['reviews_array'].length != 0 ? height / 1.7:0,
                child: widget.data['reviews_array'].length != 0 ?ListView.builder(
                  itemCount: widget.data['reviews_array'].length > 3 ? 4 : 1,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: InkWell(
                          child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (widget.data['reviews_array'][index]
                                        ['user_image'] !=
                                    null)
                                  Container(
                                    height: height / 10,
                                    width: width / 8,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(widget.serv +
                                                widget.data['reviews_array']
                                                    [index]['user_image'])),
                                        shape: BoxShape.circle),
                                  ),
                                if (widget.data['reviews_array'][index]
                                        ['user_image'] ==
                                    null)
                                  Container(
                                    height: height / 10,
                                    width: width / 8,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.6),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                widget.data['reviews_array']
                                                        [index]['user_name']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: signColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width / 3.5,
                                          child: RatingBarIndicator(
                                            rating: widget.data['reviews_array']
                                                    [index]['stars']
                                                .toDouble(),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              size: 1,
                                              color: forgotColor,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            widget.data['reviews_array'][index]
                                                ['comment'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color:
                                                    signColor.withOpacity(0.5)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      )),
                    );
                  },
                ):Container(),
              ),
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
                              builder: (context) => SevenScreen(
                                  realHotel: widget.data,
                                  data: widget.data['reviews_array'],
                                  userdata: widget.userdata,
                                  checkInfo: widget.checkInfo)),
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
                          'View All',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Container(
                      height: height / 13,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                          color: bottomCircleColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                          child: GestureDetector(
                              onTap: () {
                                _modalBottomSheetMenu(context);
                              },
                              child: Text(
                                'Add Review',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ))),
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

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350.0,
            color: Colors.transparent,
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
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 20,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/letter-x.png'),
                              )),
                            ),
                          ),
                          Text(
                            'Add Review',
                            style: TextStyle(
                                color: signColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () {
                                if (comment.text.isNotEmpty) {
                                  print(widget.data);
                                  fetchStr();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'something wrong');
                                }
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
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
                    RatingBar.builder(
                      initialRating: 0.5,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 5,
                        color: forgotColor,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        setState(() {
                          _userRating = rating;
                        });
                      },
                    ),
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
