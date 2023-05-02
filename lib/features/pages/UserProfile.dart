import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/common/utils/colors.dart';
import 'package:ide_art_mobile_app/common/utils/styles.dart';
import 'package:ide_art_mobile_app/components/top_app_bar.dart';

import '../../components/UserPostTile.dart';
import '../../models/UserPosts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var username;
  var user;
  int count = 0;
  List<Widget> listPosts = [];

  @override
  Widget build(BuildContext context) {

    Future<List<UserPosts?>> queryListItems() async {
      try {
        final request = ModelQueries.list(
          UserPosts.classType,
          where: UserPosts.AUTHOR.eq(username)
        );
        final response = await Amplify.API.query(request: request).response;

        final items = response.data?.items;
        if (items == null) {
          print('errors: ${response.errors}');
          return <UserPosts?>[];
        }
        safePrint(items);
        return items;
      } on ApiException catch (e) {
        print('Query failed: $e');
      }
      return <UserPosts?>[];
    }

    void load() async{ 
      if(count > 0){ return;}
      var items = await queryListItems();
      safePrint("load");
      List<Widget> newPosts = [];
      for(int i = 0; i < items.length; i++)
      {
        newPosts.add(UserPostBox(post: items[i]!));
      }
      setState(() {
        listPosts = newPosts;
      });
      count++;
      return;
    }

    Future<String> fetchCurrentUserAttributes() async {
      try {
        final result = await Amplify.Auth.fetchUserAttributes();
        final data = {for (var e in result) e.userAttributeKey.key: e.value};
        
        username = data['preferred_username'];
        user = data['email'];
        safePrint(data);
        return username;
      } on AuthException catch (e) {
        safePrint('Error fetching user attributes: ${e.message}');
        return "";
      }
    }

    return Scaffold(
      appBar: topBar(),
      body: FutureBuilder<String>(
        future: fetchCurrentUserAttributes().whenComplete(() => load()), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: ideArtColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.2, 0.5, 0.7, 0.9],
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 50,),
                              const CircleAvatar(
                                backgroundImage: AssetImage("assets/images/profilepic.png"),
                                radius: 60,
                              ),
                              //const SizedBox(height: 5,),
                              Text(
                                snapshot.data ?? "",
                                style: const TextStyle(
                                  fontSize: 24, 
                                  fontFamily: 'Poppins', 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(height: 7,),
                    Container(
                      color: Colors.white,
                      height: 50,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText("Your Posts",
                            textStyle: titleStyle,
                            colors: ideArtColors,
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.count(crossAxisCount: 3, children: listPosts,),
                    ),
                  ],
                ),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}