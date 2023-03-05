// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/get_started.dart';
import 'package:ide_art_mobile_app/pages/login_page.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void onPressed () {
    LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 320),

                Image.asset('assets/images/bulb.png'),

                const Text(
                  'ideArt',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 50, 
                    fontFamily: 'Poppins', 
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 200),

                MyButton2(
                  onTap: onPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
