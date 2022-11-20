import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/product_list_code.dart';
import 'package:untitled6/products_list_screen.dart';
import 'package:untitled6/test/two_screen.dart';

class HotelProducts extends StatefulWidget {
  HotelProducts({Key? key, required this.data,required this.info,required this.userdata}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic info;
  final dynamic userdata;
  @override
  _ProductScreenState createState() => _ProductScreenState();
}
class _ProductScreenState extends State<HotelProducts> {
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height/3;
    final double itemWidth = size.width / 2;
    return Scaffold(
        backgroundColor: backgroundColorProduct,
        body:
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            Expanded(
              child: GridView.count(
                  padding: EdgeInsets.only(bottom: 40),
                  crossAxisCount: 2,
                  children: List.generate(widget.data['product_categories'].length, (index) {
                    return Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/60,left: MediaQuery.of(context).size.width/40,right:MediaQuery.of(context).size.width/40, ),
                      child: InkWell(
                        onTap: (){
                          print( widget.data['product_categories'][index]);
                          widget.data['product_categories'][index]['products'].length !=  0?
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => TwoScreen(data:  widget.data['product_categories'][index], realhotel: widget.data,info: widget.info,userdata:widget.userdata)),
                          ):Fluttertoast.showToast(
                              msg: "No Products",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: MediaQuery.of(context).size.height/7,
                                  child: widget.data['product_categories'][index]['image'] != null ?
                                  CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: 'http://giovannis37.sg-host.com/'+widget.data['product_categories'][index]['image'],
                                    placeholder: (context, url) => Image.asset('assets/noimage.png'),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ) : Image.asset('assets/noimage.png')
                              ),
                              Expanded(
                                child: Padding(
                                  padding:  EdgeInsets.only(right:  MediaQuery.of(context).size.height/80,left:  MediaQuery.of(context).size.height/80,),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/300,),
                                        child: Text(widget.data['product_categories'][index]['name'] != null ? widget.data['product_categories'][index]['name'] : '',style: TextStyle(color: forgotColor,fontSize: 17,fontWeight: FontWeight.bold),),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ));
  }
}