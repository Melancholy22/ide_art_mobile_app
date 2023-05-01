import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/UserPostTile.dart';

import '../../models/UserPosts.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({super.key});

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch>{
  List<Widget> listPosts = [];

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

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
    var items = await queryListItems();
    safePrint(items);
    for(int i = 0; i < items.length; i++)
    {
      listPosts.add(UserPostBox(post: items[i]!));
    }
    return listPosts;
  }

  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();

    return FutureBuilder<void>(
      future: load(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
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
      );
    // return Scaffold(
    //   body: Column(
    //     children: [
    //       SafeArea(
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             // Add padding around the search bar
    //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //             // Use a Material design search bar
    //             child: TextField(
    //               controller: _searchController,
    //               decoration: InputDecoration(
    //                 hintText: 'Search...',
    //                 // Add a clear button to the search bar
    //                 suffixIcon: IconButton(
    //                   icon: Icon(Icons.clear),
    //                   onPressed: () => _searchController.clear(),
    //                 ),
    //                 // Add a search icon or button to the search bar
    //                 prefixIcon: IconButton(
    //                   icon: Icon(Icons.search),
    //                   onPressed: () {
    //                     // Perform the search here
    //                   },
    //                 ),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(20.0),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: GridView.count(
    //           crossAxisCount: 3,
    //           children: [
    //             //UserPostBox(),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}