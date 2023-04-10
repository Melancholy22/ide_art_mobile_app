import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/features/data/posts_repository.dart';
import 'package:ide_art_mobile_app/models/UserPosts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final PostsListControllerProvider = Provider<PostsListController>((ref) {
  return PostsListController(ref);
});

class PostsListController {
  PostsListController(this.ref);
  final Ref ref;

  Future<void> add({
    required String name,
    required String desc,
    required String imag,
  }) async  {
    UserPosts post = UserPosts(
      title: name,
      description: desc,
      image: imag,
    );
    final PostsRepository = ref.read(userRepositoryProvider);

    await PostsRepository.add(post);
  }
}