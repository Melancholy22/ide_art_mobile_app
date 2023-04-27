import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

import 'package:ide_art_mobile_app/features/pages/landing_page.dart';
import 'package:ide_art_mobile_app/common/navigation/routes.dart';
import 'package:ide_art_mobile_app/common/utils/colors.dart';
import 'package:ide_art_mobile_app/pages/home_page.dart';

class ideArtApp extends StatelessWidget {
  const ideArtApp({
    required this.isAmplifySuccessfullyConfigured,
    Key? key,
  }) : super(key: key);

  final bool isAmplifySuccessfullyConfigured;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) => isAmplifySuccessfullyConfigured
              ? const LandingPage()
              : const Scaffold(
                  body: Center(
                    child: Text(
                      'Tried to reconfigure Amplify; '
                      'this can occur when your app restarts on Android.',
                    ),
                  ),
                ),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    );

return Authenticator(
  // builder used to show a custom sign in and sign up experience
  authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
    const padding = EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
    switch (state.currentStep) {
      case AuthenticatorStep.signIn:
        return Scaffold(
          body: Padding(
            padding: padding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120,),
                  //Logo
                  Row(
                    children: [
                      const SizedBox(width: 60,),
                      Container(
                        child: Image(image: AssetImage('assets/images/LogoTitle2.png',),),
                        height: 121
                      ),
                    ],
                  ),
                  // prebuilt sign in form from amplify_authenticator package
                  SignInForm(),
                ],
              ),
            ),
          ),
          // custom button to take the user to sign up
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () => state.changeStep(
                    AuthenticatorStep.signUp,
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        );
        case AuthenticatorStep.signUp:
          return Scaffold(
            body: SingleChildScrollView(
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
                  // prebuilt sign up form from amplify_authenticator package
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SignUpForm(),
                  ),
                ],
              ),
            ),
            // custom button to take the user to sign in
            persistentFooterButtons: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => state.changeStep(
                      AuthenticatorStep.signIn,
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          );
        default:
          // returning null defaults to the prebu ilt authenticator for all other steps
          return null;
      }
    },
    child: MaterialApp(
      builder: Authenticator.builder(),
      home: HomePage(),
    ),
  );
  }
}