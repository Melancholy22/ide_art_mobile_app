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
        key: ValueKey(post.image!),
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
      shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container(
        decoration: BoxDecoration(  
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        width: 400,
        height: 600,
        child: Column(
          children: [
            Stack(
              children:[ 
              Container(
                key: ValueKey(post.image!),
                height: 300,
                width: 400,
                child: ClipRRect(borderRadius: const BorderRadius.only(topLeft:Radius.circular(20.0), topRight:Radius.circular(20.0)), 
                child: Image.network(
                  post.image ?? "", 
                  fit: BoxFit.cover, 
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Text('ð¢');
                  },
                )
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(  
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
              
                  child: CloseButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context), 
                  ),
                ),
              )
              ]
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:[
                    Text(
                    post.title ?? "",
                    style: titleStyle,
                    ),
                    Text(
                    "by: ${post.author}",
                    style: textStyle,
                    ),
                    Text(
                      post.description ?? "" ,
                      style: textStyle,
                    ),
                  ] 
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

}