import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class UserNotifs extends StatelessWidget {
  const UserNotifs({super.key});
  Future<void> signOutCurrentUser() async {
  try {
    await Amplify.Auth.signOut();
  } on AuthException catch (e) {
    print(e.message);
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(113, 203, 255, 100),
        elevation: 0,
        title:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
          // ignore: prefer_const_constructors
          Text(
            'ideArt',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  signOutCurrentUser();
                }, 
                icon: Icon(Icons.density_medium),
              ) 
            ],
          )
        ]),
      ),
      body: Center(child: Text('Notifications')),
    );
  }
}
