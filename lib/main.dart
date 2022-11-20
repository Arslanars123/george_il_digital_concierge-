import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/test/one_screen.dart';
import 'verify_screen.dart';
import 'splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'lato'),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      home: prefs.getInt('id') == null
          ? SplashScreen()
          : prefs.getString('reservation') != null
              ? MainScreen()
              : VerifyScreen(userdata: prefs.getInt('id'))));
}
