import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ide_art_mobile_app/models/ArtIdea.dart';
import 'package:ide_art_mobile_app/models/UserPosts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';


final postDataStoreServiceProvider = Provider<PostsDataStoreService> ((ref) {
  final service = PostsDataStoreService();
  return service;
});

class PostsDataStoreService {
  PostsDataStoreService();
  
  Future<void> addPosts(UserPosts post) async{
    final item = UserPosts(
                  author: "Lorem ipsum dolor sit amet",
                  title: "Lorem ipsum dolor sit amet",
                  description: "Lorem ipsum dolor sit amet",
                  image: "Lorem ipsum dolor sit amet");
    try{
      await Amplify.DataStore.save(item);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
  
  Future<void> deletePosts(UserPosts post) async {
    try {
      await Amplify.DataStore.delete(post);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updatePost(UserPosts updatedPost) async {
    try {
      final postWithID = await Amplify.DataStore.query(
        UserPosts.classType,
        where: UserPosts.ID.eq(updatedPost.id),
      );

      final oldPost = postWithID.first;
      final updatedItem = oldPost.copyWith(
          //author: updatedPost.author,
          title: updatedPost.title,
          description: updatedPost.description,
          image: updatedPost.image);
      await Amplify.DataStore.save(updatedItem);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Stream<UserPosts>getUserStream(String id)  {
    final userStream = Amplify.DataStore.observeQuery(UserPosts.classType, where: UserPosts.ID.eq(id))
                        .map((event) => event.items.toList().single);
    return userStream;
  }

  Stream<List<UserPosts>> listenToPosts() {
    return Amplify.DataStore.observeQuery(
      UserPosts.classType,
    )
        .map((event) => event.items.toList())
        .handleError(
      (error) {
        debugPrint('listenToTrips: A Stream error happened');
      },
    );
  }
}