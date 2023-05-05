import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/features/pages/challengemodel.dart';

class ChallengeTile extends StatelessWidget {
  final Challenge child;

  ChallengeTile({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 125,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:8.0, left:8.0, right:8.0) ,
            child: Container(
              height: 150,
              width: 125,
              decoration: BoxDecoration(  
                image: DecorationImage(
                  image: NetworkImage(
                  child.image,
                  ),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top:8.0, left:8.0, right:8.0),
          child: Text(child.title, style: const TextStyle(
              fontSize: 16, 
              fontFamily: 'Poppins', 
              fontWeight: FontWeight.w500
            )),
        ),
        ],
      ),
    );
  }
}