import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/top_app_bar.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(),
      body: Center(child: Text('Profile')),
    );
  }
}
