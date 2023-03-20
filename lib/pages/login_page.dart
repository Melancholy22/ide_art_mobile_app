// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:ide_art_mobile_app/components/my_button.dart';
import 'package:ide_art_mobile_app/components/my_textfield.dart';
import 'package:ide_art_mobile_app/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

    // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120,),

              //Logo
              Row(
                children: [
                  const SizedBox(width: 65,),
                  Container(
                    child: Image(image: AssetImage('assets/images/LogoTitle2.png',),),
                    height: 121
                  ),
                ],
              ),
              
              // Stack(
              //   children: [
              //     // Container(
              //     //   child: Image(image: AssetImage('assets/images/Rectangle.png')),
              //     //   alignment: Alignment.topCenter,
              //     //   height: 150,
              //     //   width: 400,
              //     // ),
              //     Container(
              //       // child: Image(image: AssetImage('assets/images/ideArt.png')),
              //       // ignore: prefer_const_constructors
              //     //   child: Row(
              //     //     children: [
              //     //       Container(
              //     //         child: Image(image: AssetImage('assets/images/Logo1.png',),),
              //     //         height: 115
              //     //       ),
              //     //       Text(
              //     //         'ideArt',
              //     //         // ignore: prefer_const_constructors
              //     //         style: TextStyle(
              //     //           color: Colors.black, 
              //     //           fontSize: 40, 
              //     //           fontFamily: 'Outfit', 
              //     //           fontWeight: FontWeight.bold
              //     //         ),
              //     //       ),
              //     //     ],
              //     //   ),
              //     //   padding: const EdgeInsets.all(50),
              //     //   alignment: Alignment.bottomCenter,
              //     // ),
                  
              //   ]
              // ),

              const SizedBox(height: 60,),

              // Welcome back
              // Text(
              //   'Welcome back!',
              //   style: TextStyle(
              //     color: Colors.grey[700],
              //     fontSize: 16,
              //   ),
              // ),
              // const SizedBox(height: 25,),
              
              // Username
              MyTextField(
                controller: usernameController, 
                hintText: 'Username', 
                obscureText: false,
              ),
              const SizedBox(height: 10,),

              // Password
              MyTextField(
                controller: passwordController, 
                hintText: 'Password', 
                obscureText: true,
              ),
              const SizedBox(height: 10,),
              
              // Forgot Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Sign in Button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 5),
              // // or continue with
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //         child: Text(
              //           'Or continue with',
              //           style: TextStyle(color: Colors.grey[700]),
              //         ),
              //       ),
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // const SizedBox(height: 50),
              
              // // Sign in options
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: const [
              //     // google button
              //     SquareTile(imagePath: 'assets/images/google.png'),

              //     SizedBox(width: 25),

              //     // apple button
              //     SquareTile(imagePath: 'assets/images/apple.png')
              //   ],
              // ),

              // const SizedBox(height: 50),
              
              // Register Now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  
                  RichText(
                    text: TextSpan(
                      text: 'Register here',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('The Register button is clicked!');
                        },
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),

                  // const Text(
                  //   'Register now',
                  //   style: TextStyle(
                  //     color: Colors.blue,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              )
          ]),
        ),
      ),
    );
  }
}
