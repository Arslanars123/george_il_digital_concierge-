import 'package:flutter/material.dart';
import 'package:untitled6/config/colors.dart';
import 'package:untitled6/messages_screen.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leadingWidth: 80,
          bottomOpacity: 0.0,
         leading: Image.asset('assets/side_bar_menu.png',scale: 1.7,),

          centerTitle: true,
          title: const Text(
            'Messages',
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.blueGrey,
                size: 22,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        ),
        body: Column(

          children: [
            SizedBox(height: height/25,),
            Padding(
              padding:  EdgeInsets.only(left: width/50,right: width/50),
              child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 border: Border.all(width: 1,color: signColor)
               ),
                  width: double.infinity,
                child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Search Messages',
                      hintStyle:
                      TextStyle(color: signColor.withOpacity(0.5),fontSize: 16)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(left: width/50,right: width/50,top: height/50,bottom: height/50),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen(data: '',)),
                        );
                      },
                      child: Container(
                        child: Stack(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                    Container(
                            height: height/10,
                            width: width/5,
                            decoration: BoxDecoration(

                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/picture.jpeg')
                              )
                            ),
                    ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(

                                        width: width/1.8,
                                        child: Text('Shoaib Akhtar',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: signColor),)),
                                    Container(

                                      width: width/1.8,
                                        child: Text('Hi Brother I am going to college. wwe will met after 5 pm',style: TextStyle(fontSize: 12),)),
                                  ],
                                ),
                                Text('2/1/2022',style: TextStyle(color: forgotColor,fontSize: 12),),
                              ],
                            ),
                            Positioned(
                            top: height/20,
                              left: width/1.2,
                              child:     Container(
                                height: height/20,
                                width: width/15,
                                child: Center(child: Text('1',style: TextStyle(color: Colors.white,fontSize: 12),)),
                                decoration: BoxDecoration(
                                  color: bottomCircleColor,
                                  shape: BoxShape.circle,


                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
