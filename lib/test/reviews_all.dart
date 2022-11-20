import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled6/config/colors.dart';
class ReviewsAll extends StatefulWidget {
  ReviewsAll({Key? key, required this.hotel}) : super(key: key);
  final dynamic hotel;
  final serv = 'http://giovannis37.sg-host.com/';
  @override
  State<ReviewsAll> createState() => _ReviewsAllState();
}

class _ReviewsAllState extends State<ReviewsAll> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
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
                          onTap: () {
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
                                'Back',
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
                      child: InkWell(
                        onTap: (){
                          print(widget.hotel);
                        },
                        child: Container(
                          child: Text(
                            'Reviews',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
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
                      left: 10, right: 10, bottom: 10),
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (widget.hotel[index]
                                ['user_image'] !=
                                    null)
                                  Container(
                                    height: height / 10,
                                    width: width / 8,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(widget.serv +
                                                widget.hotel
                                                [index]['user_image'])),
                                        shape: BoxShape.circle),
                                  ),
                                if (widget.hotel[index]
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
                                                widget.hotel
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
                                            rating: widget.hotel
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
                                            widget.hotel[index]
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
            ),)
          ],
        ),
      ),
    );
  }
}
