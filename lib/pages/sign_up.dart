// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/my_textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/Cloudy.png"), fit: BoxFit.fill),
                      
                    ),
                  ),

                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 255,
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 42, 
                        fontFamily: 'Poppins', 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
              ]),

              const SizedBox(height: 70,),

              // Username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  // ignore: unnecessary_new
                  controller: usernameController,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                  ),
                  // ignore: unnecessary_new
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 25,),

              // Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  // ignore: unnecessary_new
                  controller: emailController,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                  ),
                  // ignore: unnecessary_new
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  // ignore: unnecessary_new
                  controller: passwordController,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                  ),
                  // ignore: unnecessary_new
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 25,),

                            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  // ignore: unnecessary_new
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                  ),
                  // ignore: unnecessary_new
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  // ignore: unnecessary_new
                  controller: nameController,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                  ),
                  // ignore: unnecessary_new
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Display name',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 120,),

              GestureDetector(
                onTap: () => {

                },
                child: Image.asset('assets/images/Confirm2.png'),
              ),

              const SizedBox(height: 15,),
      
              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       image: DecorationImage(image: AssetImage("assets/images/WavyBot1.png"), fit: BoxFit.fill),
              //     ),
              //   ),
              // ),

            ]
          ),
        ),
      )
    );
  }
}
