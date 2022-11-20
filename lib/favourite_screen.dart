import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/test/services_list_without_code.dart';
import 'package:url_launcher/url_launcher.dart';
import 'global.dart';
class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key, required this.data}) : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
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
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
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
                                      height: MediaQuery.of(context).size.height / 15,
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
            child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.height / 5,
                child: Center(child: Text(name[1].toString())),
                decoration: BoxDecoration(
                    color: forgotColor,
                    borderRadius: BorderRadius.circular(20))));
  }

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
          child: ListView.builder(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30),
              itemCount: widget.data['service_categories'].length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicesListWithout(
                                    data: widget.data['service_categories']
                                        [index])),
                          );
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                widget.serv +
                                    widget.data['service_categories'][index]
                                        ['image'],
                                height: displayHeight * 0.1,
                                width: displayWidth * 0.16,
                              ),
                            ),
                            SizedBox(
                              width: displayWidth * 0.02,
                            ),
                            Container(
                              width: displayWidth / 1.47,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data['service_categories'][index]
                                        ['name'],
                                    style:
                                        TextStyle(fontSize: displayWidth / 18),
                                  ),
                                ],
                              ),
                            ),
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
                  ),
                );
              }),
        ),
      ],
    ));
  }
}
