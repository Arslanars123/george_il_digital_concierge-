import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/global.dart';
import 'package:untitled6/test/five_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/config/colors.dart';
import 'package:http/http.dart' as http;
import 'global.dart';
class ExperiencesScreen extends StatefulWidget {
  ExperiencesScreen(
      {Key? key,
      required this.data,
      required this.realHotel,
      required this.info,
      required this.userdata})
      : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
   dynamic data;
  final dynamic info;
  final dynamic realHotel;
  final dynamic userdata;

  @override
  State<ExperiencesScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<ExperiencesScreen> {
  var connectivity = 'yes';
  Future internet() async {
    bool connection = await InternetConnectionChecker().hasConnection;
    if (connection == true) {
      var prefs = await SharedPreferences.getInstance();
      var url = 'http://giovannis37.sg-host.com/api/get-category-of-services';
      Map data = {'user_id': prefs.getInt('id'),

        'category_id' : widget.data['id']
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      var decode = jsonDecode(response.body);

      setState(() {
        connectivity = 'yes';
        widget.data = decode['data'];
      });
    } else {
      setState(() {
        connectivity = '';
      });
    }

  }
  @override
  void initState() {
  internet();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
   

    return RefreshIndicator(
      onRefresh: internet,
      child: ListView(
        children: [
          Container(
            height: displayHeight,
            width: displayWidth,
            child: SafeArea(
              child: Scaffold(
                  body: Column(
                children: [
                  Container(
                      height: displayHeight / 15,
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
                                      english == true ? 'Back' : 'indietro',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MediaQuery.of(context).size.width / 22),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                english == true ? 'Experiences' : 'Esperienze',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width / 18,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Expanded(
                    child: widget.data['services'] == null
                        ? Container(
                            height: 10, width: 10, child: CircularProgressIndicator())
                        : ListView.builder(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 30,
                                right: MediaQuery.of(context).size.width / 30),
                            itemCount: widget.data['services'].length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FiveScreen(
                                                data: widget.data['services'][index],
                                                realHotel: widget.realHotel,
                                                info: widget.info,
                                                userdata: widget.userdata)),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: displayHeight / 14.5,
                                            width: displayWidth / 7,
                                            child: widget.data['services'][index]
                                                        ['image'] !=
                                                    null
                                                ? CachedNetworkImage(
                                                    imageUrl: widget.serv +
                                                        widget.data['services'][index]
                                                            ['image'],
                                                    placeholder: (context, url) =>
                                                        Image.asset(
                                                            'assets/noimage.png'),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  )
                                                : Image.asset('assets/noimage.png')),
                                        SizedBox(
                                          width: displayWidth * 0.02,
                                        ),
                                        english == true
                                            ? Container(
                                                width: displayWidth / 1.48,
                                                child: Text(
                                                  widget.data['services'][index]
                                                              ['name'] !=
                                                          null
                                                      ? widget.data['services'][index]
                                                          ['name']
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  maxLines: 1,
                                                ))
                                            : Text(
                                                widget.data['services'][index]
                                                            ['name'] !=
                                                        null
                                                    ? widget.data['services'][index]
                                                        ['name']
                                                    : '',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  overflow: TextOverflow.clip,
                                                ),
                                                maxLines: 1,
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: displayWidth * 0.02,
                                    ),
                                    Container(
                                      height: displayHeight * 0.04,
                                      width: displayWidth * 0.05,
                                      child: Icon(
                                        Icons.favorite,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.pinkAccent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
    /*GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(widget.data['service_categories'].length, (index) {

                    return Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/60,left: MediaQuery.of(context).size.width/60,right:MediaQuery.of(context).size.width/60 ),
                      child: InkWell(
                        onTap: (){
                          print(widget.serv+widget.data['service_categories'][index]['image'] );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/4,
                                height: MediaQuery.of(context).size.height/5,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(

                                fit: BoxFit.fill,
                                  image: NetworkImage(widget.serv+widget.data['service_categories'][index]['image'] ))
                                ),

*/ /*
             )
*/ /*
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width/25),
                              Text( widget.data['service_categories'][index]['name'],style: TextStyle(color: signColor,fontSize: 14,fontWeight: FontWeight.bold)),

                            ],
                          ),
                        ),
                      ),
                    );
                  })));*/

    /*Container(


              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          widget.serv+widget.data['service_categories'][index]['image'],
                          height: displayHeight*0.1,
                          width: displayWidth*0.16,
                        ),
                      ),
                      SizedBox(width: displayWidth/22,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.data['service_categories'][index]['name']),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on,size: 12, color: Colors.grey,),
                                SizedBox(width: displayWidth*0.02,),
                                const Text('Australia', style: TextStyle(color: Colors.grey, fontSize: 12),),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                              SizedBox(width: displayWidth*0.01,),
                              const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                              SizedBox(width: displayWidth*0.01,),
                              const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                              SizedBox(width: displayWidth*0.01,),
                              const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                              SizedBox(width: displayWidth*0.01,),
                              const Icon(Icons.star, size: 15, color: Colors.grey,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Container(
                        height: displayHeight * 0.04,
                        width: displayWidth*0.05,
                        child: const Icon(Icons.favorite, size: 10, color: Colors.white,),
                        decoration: const BoxDecoration( color: Colors.pinkAccent, shape: BoxShape.circle, ),
                      ),
                      SizedBox(width: displayWidth/10,)
                    ],
                  ),
                ],
              ),
            );*/
    /*     Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      widget.serv+widget.data['service_categories'][index]['image'],
                      height: displayHeight*0.1,
                      width: displayWidth*0.16,
                    ),
                  ),
                  SizedBox(width: displayWidth*0.04,),
                  Text(widget.data['service_categories'][index]['name']),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(

                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.data['service_categories'][index]['name']),
                              SizedBox(width: displayWidth*0.24,),
                              Container(
                                height: displayHeight * 0.04,
                                width: displayWidth*0.05,
                                child: const Icon(Icons.favorite, size: 10, color: Colors.white,),
                                decoration: const BoxDecoration( color: Colors.pinkAccent, shape: BoxShape.circle, ),
                              ),
                            ],
                          ),
                          Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on,size: 12, color: Colors.grey,),
                              SizedBox(width: displayWidth*0.02,),
                              const Text('Australia', style: TextStyle(color: Colors.grey, fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: displayHeight*0.012,),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                          SizedBox(width: displayWidth*0.01,),
                          const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                          SizedBox(width: displayWidth*0.01,),
                          const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                          SizedBox(width: displayWidth*0.01,),
                          const Icon(Icons.star, size: 15, color: Colors.deepOrange,),
                          SizedBox(width: displayWidth*0.01,),
                          const Icon(Icons.star, size: 15, color: Colors.grey,),
                        ],
                      ),
                    ],
                  )
                ],
              );*/
  }
}
