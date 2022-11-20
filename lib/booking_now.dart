import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled6/global.dart';

import 'config/colors.dart';

class BookingNow extends StatefulWidget {
  BookingNow(
      {Key? key,
      required this.data,
      required this.realHotel,
      required this.userdata,
      required this.checkInfo})
      : super(key: key);
  final serv = 'http://giovannis37.sg-host.com/';
  final dynamic data;
  final dynamic realHotel;
  final dynamic userdata;
  final dynamic checkInfo;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<BookingNow> {
  DateTime? selectedDate;
  var approximateCostController = TextEditingController();
  var details = TextEditingController();

  var HourTo = TextEditingController();
  var HourFrom = TextEditingController();
  var peoples = TextEditingController();
  var childs = TextEditingController();
  var reserveDate = TextEditingController();
  var eventDate = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  final maintenanceRequestType = ['Adult', 'Child'];
  final f = new DateFormat('yyyy-MM-dd');

  Future<http.Response> fetchStr() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 20,
          width: 20,
          child: Center(
            child: CircularProgressIndicator(
              color: forgotColor,
            ),
          ),
        );
      },
    );
    print(userID);
    var url = 'http://giovannis37.sg-host.com/api/reserve-service';
    var preference = await SharedPreferences.getInstance();
    Map data = {
      'user_id': preference.getInt('id'),
      'event_date': eventDate.text,
      'reserve_date': reserveDate.text,
      'number_of_people': peoples.text,
      'number_of_children': childs.text,
      'hours_from': HourFrom.text,
      'hours_to': HourTo.text,
      'detail': details.text,
      'service_id': widget.data['id']
    };
    print(data);
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    Fluttertoast.showToast(
        msg: "Service Book",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: forgotColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
    print(jsonDecode(response.body));
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  void initState() {
    var a = DateFormat.yMMMEd().format(DateTime.now());
    print(a.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    var displayWidth = MediaQuery.of(context).size.width;
    final firstDate = DateTime(DateTime.now().year - 120);
    final lastDate = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                                Text(english == true ? 'Back' : 'indietro',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                21)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            child: english == true
                                ? Text(
                                    english == true ? 'Booking Now' : '',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                : Text(
                                    'Prenota ora',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: <Widget>[
                            getPartOneTextField(
                                english == true
                                    ? 'number of peoples'
                                    : 'numero di popoli',
                                english == true
                                    ? 'Number of Peoples'
                                    : 'numero di popoli',
                                peoples,
                                TextInputType.text,
                                false),
                            getPartOneTextField(
                                english == true
                                    ? 'number of childrens'
                                    : 'numero di bambini',
                                english == true
                                    ? 'Number of childres'
                                    : 'numero di bambini',
                                childs,
                                TextInputType.text,
                                false),
                            getPartOneTextField(
                                english == true ? 'details' : 'details',
                                english == true
                                    ? 'Details'
                                    : 'numero di popoli',
                                details,
                                TextInputType.text,
                                false),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  english == true
                                      ? 'Date & Time'
                                      : 'appuntamento',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            FormBuilderDateTimePicker(
                              name: english == true
                                  ? 'ReserveDate'
                                  : 'data di riserva',
                              style: TextStyle(fontSize: 17),
                              controller: reserveDate,
                              format: DateFormat('yyyy-MM-dd'),
                              inputType: InputType.date,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter reserve date';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: english == true
                                      ? 'ReserveDate'
                                      : 'data di riserva',
                                  suffixIcon: Icon(Icons.date_range)),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                            ),
                            FormBuilderDateTimePicker(
                              controller: eventDate,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter event date';
                                }
                                return null;
                              },
                              name: english == true
                                  ? 'Event date'
                                  : 'data dell evento',
                              style: TextStyle(fontSize: 17),
                              format: DateFormat('yyyy-MM-dd'),
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                  labelText: english == true
                                      ? 'Event date'
                                      : 'data dell evento',
                                  suffixIcon: Icon(Icons.date_range)),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                            ),
                            FormBuilderDateTimePicker(
                              name: english == true ? 'Hour from' : 'ore da',
                              style: TextStyle(fontSize: 17),
                              controller: HourFrom,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select hour from';
                                }
                                return null;
                              },
                              inputType: InputType.time,
                              decoration: InputDecoration(
                                  labelText:
                                      english == true ? 'Hour from' : 'ore dao',
                                  suffixIcon: Icon(Icons.date_range)),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                            ),
                            FormBuilderDateTimePicker(
                              name: english == true ? 'Hour from' : 'ora a',
                              style: TextStyle(fontSize: 17),
                              controller: HourTo,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select hour to';
                                }
                                return null;
                              },
                              inputType: InputType.time,
                              decoration: InputDecoration(
                                  labelText:
                                      english == true ? 'Hour from' : 'ora a',
                                  suffixIcon: Icon(Icons.date_range)),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              // initialValue: DateTime.now(),
                              // enabled: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: displayHeight * 0.01,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      // color: Color.fromRGBO(83, 82, 236, 1),
                                      child: Text(
                                        english == true
                                            ? "Continue"
                                            : 'Continua',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromRGBO(
                                                      83, 82, 236, 1)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ))),
                                      onPressed: () {
                                        _formKey.currentState!.save();
                                        if (_formKey.currentState!.validate()) {
                                          fetchStr();
                                        } else {
                                          print("validation failed");

                                          /*Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => CardDetails()),
                                          );*/

                                        }
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                              topRight: Radius.circular(50))),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPartOneTextField(name, labelText, controller, keyboardType, enabled) =>
      FormBuilderTextField(
        enabled: true,
        name: name,
        decoration: InputDecoration(
            labelText: labelText, labelStyle: TextStyle(fontSize: 17)),
        controller: controller,
        keyboardType: keyboardType,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
      );

  getPartTwoTextField(name, hint, list) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.42,
        child: FormBuilderDropdown(
          name: name,
          allowClear: true,
          hint: Text(hint),
          validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(context)]),
          items: maintenanceRequestType
              .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(
                      '$gender',
                      style: TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
        ),
      );
}
