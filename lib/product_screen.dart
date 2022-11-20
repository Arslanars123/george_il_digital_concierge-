import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/products_list_screen.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.data}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  dynamic data;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColorProduct,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Expanded(
              child: Container(
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                        widget.data['product_categories'].length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 60,
                            left: MediaQuery.of(context).size.width / 60,
                            right: MediaQuery.of(context).size.width / 60),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList(
                                      hotel: widget.data['product_categories']
                                          [index])),
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 8,
                            width: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          300,
                                      left: MediaQuery.of(context).size.width /
                                          80,
                                      right: MediaQuery.of(context).size.width /
                                          80,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              120),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: widget.data['product_categories']
                                                    [index]['image'] !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    'http://giovannis37.sg-host.com/' +
                                                        widget.data[
                                                                'product_categories']
                                                            [index]['image'],
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        'assets/noimage.png'),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )
                                            : Image.asset(
                                                'assets/noimage.png')),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.height / 80,
                                      left: MediaQuery.of(context).size.height / 80,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.height / 300,
                                          ),
                                          child: Text(widget.data['product_categories'][index]['name'] != null ? widget.data['product_categories'][index]['name'] : '',
                                            style: TextStyle(
                                                color: forgotColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
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
            ),
          ],
        ));
  }
}
