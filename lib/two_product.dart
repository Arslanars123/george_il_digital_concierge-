import 'package:flutter/material.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/global.dart';

class ProductScreenTwo extends StatefulWidget {
  ProductScreenTwo({Key? key, required this.data}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColorProduct,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottomOpacity: 0.0,
          leadingWidth: 80,
          leading: Image.asset(
            'assets/side_bar_menu.png',
            scale: 1.7,
          ),
          centerTitle: true,
          title: Text(
            english == true ? 'Products' : 'Prodotti',
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(widget.data['product_categories'].length,
                (index) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 60,
                    left: MediaQuery.of(context).size.width / 60,
                    right: MediaQuery.of(context).size.width / 60),
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
                            top: MediaQuery.of(context).size.height / 300,
                            left: MediaQuery.of(context).size.width / 80,
                            right: MediaQuery.of(context).size.width / 80,
                            bottom: MediaQuery.of(context).size.height / 120),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(widget.serv +
                                        widget.data['product_categories'][index]
                                            ['image']))),
                          ),
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
                                  bottom:
                                      MediaQuery.of(context).size.height / 300,
                                ),
                                child: Text(
                                  widget.data['product_categories'][index]
                                      ['name'],
                                  style: TextStyle(
                                      color: forgotColor,
                                      fontSize: 14,
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
              );
            })));
  }
}
