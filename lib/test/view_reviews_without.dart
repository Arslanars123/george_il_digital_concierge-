import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/global.dart';
import 'package:http/http.dart' as http;
class ReviewsAllWithout extends StatefulWidget {
  ReviewsAllWithout({Key? key, required this.hotel,required this.id}) : super(key: key);
   dynamic hotel;
   dynamic id;
  final serv = 'http://giovannis37.sg-host.com/';
  @override
  State<ReviewsAllWithout> createState() => _ReviewsAllState();
}

class _ReviewsAllState extends State<ReviewsAllWithout> {
  var connectivity = 'yes';


  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var prefs = await SharedPreferences.getInstance();
      var url = 'http://giovannis37.sg-host.com/api/get-hotel-detail2';
      Map data = {'user_id': prefs.getInt('id'),
        'hotel_id' : widget.id
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      var decode = jsonDecode(response.body);
      print(decode['data']);

      setState(() {
        connectivity = 'yes';
        widget.hotel= decode['data']['reviews_array'];

      });

    } else {
      setState(() {
        connectivity = '';
      });
    }
    print(connectivity);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: internet,
      child: ListView(
        children: [
          Container(
            height: height,
            width: width,
            child: SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    Container(
                        height: height / 15,
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(
                                       english == true ? 'Back' :'indietro',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
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
                                 english== true ? 'Reviews' :'Recensioni',
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )),
                    Expanded(child: ListView.builder(
                      itemCount: widget.hotel!.length,
                      itemBuilder: (context, index) {

                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10),
                          child: widget.hotel.length > 0
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
                                        SizedBox(width: width/50,),
                                        Container(

                                          child: Column(
                                            children: [
                                              if (widget.hotel
                                              [index]['user_image'] !=
                                                  null)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit:BoxFit.fill,
                                                      image: NetworkImage(widget.serv +
                                                          widget.hotel
                                                          [
                                                          index]['user_image'],)
                                                    ),
                                                      shape: BoxShape.circle),
                                                  height: height / 10,
                                                  width: width / 8,

                                                ),
                                              if (widget.hotel
                                              [index]['user_image'] == null)
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
                                        SizedBox(width: width/50,),
                                        Container(
                                          width: width/1.3168,

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
                                                  widget.hotel
                                                  [index]['user_name']
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: signColor,
                                                    fontSize: width/19,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(widget
                                                      .hotel);
                                                },
                                                child: Container(
                                                  width: width / 3.5,
                                                  child: RatingBarIndicator(
                                                    rating: widget
                                                        .hotel
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
                                                  widget.hotel
                                                  [index]
                                                  ['comment'] !=
                                                      null
                                                      ? widget.hotel
                                                  [index]['comment']
                                                      : '',
                                                  style: TextStyle(
                                                      fontSize: width/23,
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
                                        SizedBox(width: width/50,),
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
                    ),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
