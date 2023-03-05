import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/pages/landing_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

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
        home: LandingPage(),
        //home: HomePage(),
        theme: ThemeData(primarySwatch: Colors.blue)); //MaterialApp
  }
}
