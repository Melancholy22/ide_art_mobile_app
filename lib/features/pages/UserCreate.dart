import 'package:amplify_api/model_mutations.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/get_started.dart';
import 'package:ide_art_mobile_app/components/my_button.dart';
import 'package:ide_art_mobile_app/components/my_textfield.dart';
import 'package:ide_art_mobile_app/features/controller/post_list_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/ModelProvider.dart';
import 'dart:io';

import '../../models/UserPosts.dart';


class UserCreate extends StatefulWidget {
  @override
  _UserCreateState createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {

  XFile? image;

  final ImagePicker picker = ImagePicker();

  var url;

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  Future<void> uploadImage() async {
    // Select image from user's gallery
    final pickedFile = image;//await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      safePrint('No image selected');
      return;
    }

    // Upload image with the current time as the key
    final key = pickedFile.name;//DateTime.now().toString();
    final file = File(pickedFile.path);
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: key,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      safePrint('Successfully uploaded image: ${result.key}');
    } on StorageException catch (e) {
      safePrint('Error uploading image: $e');
    }
  }

  Future<void> getDownloadUrl() async {
    final pickedFile = image;

    if (pickedFile == null) {
      safePrint('No image selected');
      return;
    }

    try {
      final result = await Amplify.Storage.getUrl(key: pickedFile.name);
      // NOTE: This code is only for demonstration
      // Your debug console may truncate the printed url string
      safePrint('Got URL: ${result.url}');
      url = result.url;
    } on StorageException catch (e) {
      safePrint('Error getting download URL: $e');
    }
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    var username;

    Future<void> createUserPosts() async {
      try {
        final model = UserPosts(
        author: username,
        title: titleController.text,
        description: descController.text,
        image: url);
        final request = ModelMutations.create(model);
        final response = await Amplify.API.mutate(request: request).response;

        final createdUserPosts = response.data;
        if (createdUserPosts == null) {
          safePrint('errors: ${response.errors}');
          return;
        }
        safePrint('Mutation result: ${createdUserPosts.id}');
      } on ApiException catch (e) {
        safePrint('Mutation failed: $e');
      }
    }

    Future<void> fetchCurrentUserAttributes() async {
      try {
        final result = await Amplify.Auth.fetchUserAttributes();
        final data = {for (var e in result) e.userAttributeKey.key: e.value};
        
        username = data['preferred_username'];
        safePrint(username);
      } on AuthException catch (e) {
        safePrint('Error fetching user attributes: ${e.message}');
      }
    }

    onTap() async {
      fetchCurrentUserAttributes().whenComplete(() => uploadImage().whenComplete(() => getDownloadUrl().whenComplete(() => createUserPosts())));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              hintText: 'description', 
              obscureText: false,
            ),
            const SizedBox(height: 10,),
            //if image not null show the image
            //if image null show text
            image != null
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  //to show image, you type like this.
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ),
            )
          : Text(
              "No Image",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                myAlert();
              },
              child: Text('Upload Photo'),
            ),

            SizedBox(
              height: 10,
            ),

            MyButton(onTap: onTap)
          ],
          
        ),
      ),
    );
  }
}