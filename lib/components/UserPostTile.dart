import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/models/ModelProvider.dart';

class UserPostBox extends StatelessWidget {
  final UserPosts post;
  const UserPostBox({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(post.image ?? ""),
    );
  }
}