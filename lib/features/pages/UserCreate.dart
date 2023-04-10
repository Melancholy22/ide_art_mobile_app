import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/my_textfield.dart';
import 'package:ide_art_mobile_app/features/controller/post_list_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class UserCreate extends StatelessWidget {
  const UserCreate({super.key});


  @override
  Widget build(BuildContext context) {
    final authorController = TextEditingController();
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final imageController = TextEditingController();

    return Scaffold(
      body:SafeArea(child:  Center(
        child: Column(
          children: [
              // title
              MyTextField(
                controller: titleController, 
                hintText: 'title', 
                obscureText: false,
              ),
              const SizedBox(height: 10,),

              // Description
              MyTextField(
                controller: descController, 
                hintText: 'Password', 
                obscureText: true,
              ),
              const SizedBox(height: 10,),

              // Description
              MyTextField(
                controller: descController, 
                hintText: 'Password', 
                obscureText: true,
              ),
              const SizedBox(height: 10,),
          ],
        ),
      )),
    );
  }
}
