import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/UserPostTile.dart';
import 'package:lottie/lottie.dart';

import '../../common/utils/colors.dart';
import '../../components/gradient_text.dart';
import '../../models/UserPosts.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({super.key});

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch>{
  List<Widget> listPosts = [];
  var count = 0;

  Future<List<UserPosts?>> queryListItems() async {
    try {
      final request = ModelQueries.list(UserPosts.classType);
      final response = await Amplify.API.query(request: request).response;

      final items = response.data?.items;
      if (items == null) {
        print('errors: ${response.errors}');
        return <UserPosts?>[];
      }
      return items;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return <UserPosts?>[];
  }

  Future<List<Widget>> load() async{ 
    if(count > 0)
    {return listPosts;}
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
    //await Future.delayed(Duration(seconds: 2));
    count++;
    return listPosts;
  }

  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();

    reload(var itemz)  async {
      safePrint("Reloading");
      List<Widget> newPosts = [];
      for(int i = 0; i < itemz.length; i++)
      {
        newPosts.add(UserPostBox(post: itemz[i]!));
      }
      setState(() {
        listPosts = newPosts;
      });
    }

    Future<List<UserPosts?>> querySpecificItems(String queries) async {
      if(!(queries.isEmpty || queries == null))  {
        try {
          var query2 = queries.toLowerCase();
          var query3 = queries.toUpperCase();
          var query4 = queries[0].toUpperCase();

          final request = ModelQueries.list(
            UserPosts.classType,
            where: UserPosts.AUTHOR.contains(queries).or(UserPosts.TITLE.contains(queries))
                  .or(UserPosts.TITLE.contains(query2)).or(UserPosts.TITLE.contains(query2))
                  .or(UserPosts.TITLE.contains(query3)).or(UserPosts.TITLE.contains(query3))
                  .or(UserPosts.TITLE.contains(query4)).or(UserPosts.TITLE.contains(query4)),
          );
          final response = await Amplify.API.query(request: request).response;

          final items = response.data?.items;
          if (items == null) {
            print('errors: ${response.errors}');
            return <UserPosts?>[];
          }
          safePrint(items);
          reload(items);
          return items;
        } on ApiException catch (e) {
          print('Query failed: $e');
        }
      }
      else
      {
        safePrint("Query is empty");
        count = -1;
        load();
      }
      return <UserPosts?>[];
    }

    return FutureBuilder<void>(
      future: load(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top:32.0),
                  child: Container(
                    // Add padding around the search bar
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    // Use a Material design search bar
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: querySpecificItems,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        // Add a search icon or button to the search bar
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(crossAxisCount: 3, children: listPosts,),
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
            children = <Widget>[
              Lottie.asset(
                "assets/animations/53152-loading-dots.json",
                frameRate: FrameRate.composition,
              ),
              const GradientText(
                'Loading Results',
                style: TextStyle(
                  fontSize: 36, 
                  fontFamily: 'Poppins', 
                  fontWeight: FontWeight.bold
                  ),
                gradient: ideArtColor1,
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
      );
  }
}