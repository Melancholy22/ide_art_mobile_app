import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/pages/entry copy.dart';
import 'package:ide_art_mobile_app/pages/landing_page.dart';
import 'package:ide_art_mobile_app/pages/sign_up.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: entryScreen(),
        //home: HomePage(),
        //home: LandingPage(),
        //home: LoginPage(),
        theme: ThemeData(primarySwatch: Colors.blue)); //MaterialApp
  }
}