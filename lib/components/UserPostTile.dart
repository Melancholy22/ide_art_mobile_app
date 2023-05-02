import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/common/utils/styles.dart';
import 'package:ide_art_mobile_app/models/ModelProvider.dart';

class UserPostBox extends StatelessWidget {
  final UserPosts post;
  const UserPostBox({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => ImageDialog(post: post,)
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(post.image ?? ""),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final UserPosts post;
  const ImageDialog({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 500,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image.network(post.image ?? "", fit: BoxFit.contain,),
              height: 380,
              width: 400,
            ),
            Text(
              post.title ?? "",
              style: titleStyle,
            ),
            Text(
              "Created by: ${post.author}",
              style: textStyle,
            ),
            Text(
              "Description:",
              style: textStyle,
            ),
            Text(
              post.description ?? "",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}