import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/gradient_text.dart';
import 'package:ide_art_mobile_app/common/utils/colors.dart';


class topBar extends StatelessWidget implements PreferredSizeWidget{
  const topBar({super.key});


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);

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
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            // ignore: prefer_const_constructors
            GradientText(
              'ideArt',
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              gradient: ideArtColor1,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    signOutCurrentUser();
                  }, 
                  icon: const Icon(Icons.logout, color: Colors.black),
                ) 
              ],
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
              color: Colors.black12,
              height: 1.0,
          ),
        ),
      ),
    );
  }
}