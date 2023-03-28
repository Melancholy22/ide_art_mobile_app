// Landing page //
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/get_started.dart';
import 'package:ide_art_mobile_app/features/pages/login_page.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void onPressed (BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                SizedBox(height: screenHeight / 3),

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

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MyButton2(
                      onTap: (){
                        onPressed(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}