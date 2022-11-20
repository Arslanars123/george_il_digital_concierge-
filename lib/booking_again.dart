import 'package:flutter/material.dart';

class BookingAgain extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: const [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              Text(
                'Back',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Booking Again',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Booking For',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(94, 112, 224, 1)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Faysal Bank + 20 B0742 B28',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Adult',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: displayHeight * 0.02,
                                      width: displayWidth * 0.038,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  94, 112, 224, 1))),
                                      child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 10,
                                            color: Color.fromRGBO(94, 112, 224, 1),
                                          ))),
                                  Container(
                                      height: displayHeight * 0.02,
                                      width: displayWidth * 0.038,
                                      decoration: BoxDecoration(
                                          color:
                                          const Color.fromRGBO(193, 193, 221, 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  94, 112, 224, 1))),
                                      child: const Center(
                                          child: Text(
                                            '3',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color.fromRGBO(
                                                    94, 112, 224, 1)),
                                          ))),
                                  Container(
                                      height: displayHeight * 0.02,
                                      width: displayWidth * 0.038,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  94, 112, 224, 1))),
                                      child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 10,
                                            color: Color.fromRGBO(94, 112, 224, 1),
                                          ))),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: displayWidth * 0.2,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Child',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: displayHeight * 0.02,
                                      width: displayWidth * 0.038,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  94, 112, 224, 1))),
                                      child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 10,
                                            color: Color.fromRGBO(94, 112, 224, 1),
                                          ))),
                                  Container(
                                      height: displayHeight * 0.02,
                                      width: displayWidth * 0.038,
                                      decoration: BoxDecoration(
                                          color:
                                          const Color.fromRGBO(193, 193, 221, 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  94, 112, 224, 1))),
                                      child: const Center(
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color.fromRGBO(
                                                    94, 112, 224, 1)),
                                          ))),
                                  Container(
                                      height: displayHeight * 0.02,
                                      width: displayWidth * 0.038,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(2)),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              94, 112, 224, 1),
                                        ),
                                      ),
                                      child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 10,
                                            color: Color.fromRGBO(94, 112, 224, 1),
                                          ))),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Divider(),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Apply Promo Code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                          suffixIcon: Text(
                            'Reverse',
                            style: TextStyle(
                                color: Color.fromRGBO(94, 112, 224, 1)),
                          ),
                          hintText: "PRS5001",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Per Person', style: TextStyle(fontWeight: FontWeight.w400),),
                          Text('\$1,020', style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                      SizedBox(height: displayHeight*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Total Persons   x5', style: TextStyle(fontWeight: FontWeight.w400),),
                          Text('\$6,000', style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                      SizedBox(height: displayHeight*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Promo Code', style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(149,212,186,1)),),
                          Text('\$500', style: TextStyle(color: Color.fromRGBO(149,212,186,1)),),
                        ],
                      ),
                      SizedBox(height: displayHeight*0.02,),
                      const Divider(),
                      SizedBox(height: displayHeight*0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Total Amount', style: TextStyle(fontWeight: FontWeight.w300),),
                          Text('\$5,500', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(109,119,204,1), fontSize: 22),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: displayHeight*0.03,),
              Stack(
                children:[
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: ElevatedButton(
                      // color: Color.fromRGBO(83, 82, 236, 1),
                      child: const Text(
                        "Pay Now",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(83, 82, 236, 1)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ))),
                      onPressed: () {

                    /*    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Payment_Successful()),
                        );*/
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(displayWidth*0.64, 10, 0, 8),
                    child: Container(
                      height: displayHeight * 0.062,
                      width: displayWidth*0.17,
                      child: Icon(Icons.arrow_forward, color: Colors.white,),
                      decoration: const BoxDecoration( color: Color.fromRGBO(94,112,224,1),shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
