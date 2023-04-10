import 'package:ide_art_mobile_app/features/services/post_datastore_service.dart';
import 'package:ide_art_mobile_app/models/UserPosts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider = Provider<PostsRepository>((ref)  {
  PostsDataStoreService postsDataStoreService = ref.read(postDataStoreServiceProvider);
  return PostsRepository(postsDataStoreService);
});

final usersListStreamProvider = StreamProvider.autoDispose<List<UserPosts?>>((ref) {
  final postRepository = ref.watch(userRepositoryProvider);
  return postRepository.getPosts();
});

final postProvider = StreamProvider.autoDispose.family<UserPosts?, String> ((ref, id) {
    final postRepository = ref.watch(userRepositoryProvider);
  return postRepository.get(id);
});

class PostsRepository {
  PostsRepository(this.postsDataStoreService);

  final PostsDataStoreService postsDataStoreService;

  Stream<List<UserPosts>> getPosts()  {
    return postsDataStoreService.listenToPosts();
  }
  
  Future<void> add(UserPosts p) async {
    await postsDataStoreService.addPosts(p);
  }

  Future<void> update(UserPosts p) async  {
    await postsDataStoreService.updatePost(p);
  }

  Future<void> delete(UserPosts p) async{
    await postsDataStoreService.deletePosts(p);
  }

  Stream<UserPosts> get(String id)  {
    return postsDataStoreService.getUserStream(id);
  }
}

