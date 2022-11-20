import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/config/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global.dart';

class Overview extends StatefulWidget {
  Overview({Key? key, required this.data}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;

  @override
  _State createState() => _State();
}

class _State extends State<Overview> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  var name;
  var type;
  int state = 1;

  _launchURL(String url) async {
    var docUrl = 'http://giovannis37.sg-host.com/' + url;
    if (await canLaunch(docUrl)) {
      await launch(docUrl);
    } else {
      throw 'Could not launch $url';
    }
  }
  rendering(String data) {
    name = data.split('/');
    type = data.split('.');
    print(type[1]);
    return type[1] == 'jpg' ||
            type[1] == 'png' ||
            type[1] == 'jpeg' ||
            type[1] == 'svg' ||
            type[1] == 'gif'
        ? Container(
      width: MediaQuery.of(context).size.width/3,
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(widget.serv + data))),
          )
        : InkWell(
            onTap: () {
              type[1] == 'pdf'
                  ? showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.zero,
                          content: Container(
                              height: MediaQuery.of(context).size.height / 1.2,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Column(
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
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
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_back_ios,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      english == true
                                                          ? 'Back'
                                                          : 'indietro',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              22),
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
                                                name[1],
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                    child: Container(
                                        child: SfPdfViewer.network(
                                      'http://giovannis37.sg-host.com/' + data,
                                      key: _pdfViewerKey,
                                    )),
                                  ),
                                ],
                              )),
                        );
                      },
                      animationType: DialogTransitionType.slideFromBottomFade,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                    )
                  : _launchURL(data);
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                  height: MediaQuery.of(context).size.height / 17,
                  width: MediaQuery.of(context).size.height / 6,
                  child: Center(
                      child: Text(
                    name[1].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
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
                      borderRadius: BorderRadius.circular(20))),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      child: ListView.builder(
        itemCount: widget.data['info'].length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.data['info'][index]['label'] != null
                        ? widget.data['info'][index]['label']
                        : '',
                    style: TextStyle(
                        color: signColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                if (widget.data['info'][index]['type'] == 'file')
                  rendering(widget.data['info'][index]['value']),
                if (widget.data['info'][index]['type'] != 'file')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.data['info'][index]['value'].toString() != null
                          ? widget.data['info'][index]['value'].toString()
                          : '',
                      style: TextStyle(
                          fontSize: 15, color: signColor.withOpacity(0.5)),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    )
        /*Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/50,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(widget.hotel['info'],style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      Text(dayText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Padding(
                        padding: const EdgeInsets.only(left: 2,right: 2),
                        child: Text(monthText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      ),
                      Text(yeartext,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),

                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/40,),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text('Duration',style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      Text(numberOfDaysText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Text(daystext,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Text(slashText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                      Text(numberNightsText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),

                      Text(nightsText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/40,),

          Align(
          alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Container(child: Text(discoverText,maxLines: 2,style: TextStyle(color: signColor,fontSize: 15,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Text(fansText,style: TextStyle(color: signColor.withOpacity(0.5),fontSize: 12),),
          ),
        ],
      ),*/
        );
  }
}
