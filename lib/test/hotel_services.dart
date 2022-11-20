import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/experiences_list.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/list_chat.dart';
import 'package:untitled6/test/four_screen.dart';


class HotelServices extends StatefulWidget {
  HotelServices(
      {Key? key,
      required this.data,
      required this.info,
      required this.userdata})
      : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic info;
  final dynamic userdata;

  @override
  State<HotelServices> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<HotelServices> {
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Expanded(
            child: widget.data['service_categories'] != null
                ? ListView.builder(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 30,
                        right: MediaQuery.of(context).size.width / 30),
                    itemCount: widget.data['service_categories'].length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        FourScreen(
                                            data: widget
                                                    .data['service_categories']
                                                [index],
                                            realHotel: widget.data,
                                            info: widget.info,
                                            userdata: widget.userdata)),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: displayHeight / 14.5,
                                  width: displayWidth / 7,
                                  child: widget.data['service_categories']
                                              [index]['image'] !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl: widget.serv +
                                              widget.data['service_categories']
                                                  [index]['image'],
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Image.asset(
                                          'assets/noimage.png',
                                        ),
                                ),
                                SizedBox(
                                  width: displayWidth * 0.02,
                                ),
                                Container(
                                    width: displayWidth / 1.48,
                                    child: Text(
                                      widget.data['service_categories'][index]
                                                  ['name'] !=
                                              null
                                          ? widget.data['service_categories']
                                              [index]['name']
                                          : 'no',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: displayWidth * 0.02,
                          ),
                          Container(
                            height: displayHeight * 0.04,
                            width: displayWidth * 0.05,
                            child: const Icon(
                              Icons.favorite,
                              size: 10,
                              color: Colors.white,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.pinkAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      );
                    })
                : Text('')),
      ],
    ));
  }
}
