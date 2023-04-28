import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/common/utils/colors.dart';
import '../../components/gradient_text.dart';
import '../../components/top_app_bar.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: topBar(),
      body: Center(
        child: GradientText(
          "IdeArt",
          style: const TextStyle(
                            fontSize: 42, 
                            fontFamily: 'Poppins', 
                            fontWeight: FontWeight.bold
                          ),
          gradient: ideArtColor1,
        ),
      ),
    );
  }
}
