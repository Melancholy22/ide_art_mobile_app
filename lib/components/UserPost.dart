import 'package:flutter/material.dart';

class UserPost extends StatelessWidget {
  final String child;

  UserPost({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 375,
        color: Colors.blue[200],
        child: Center(
          child: Text(
            child, 
            style: const TextStyle(fontSize: 40),
            ),
        ) 
      ),
      );
  }
}