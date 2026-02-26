import '../Data Providers/user_profile_api.dart';

import '../Models/post_model.dart';

class PostRepository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();
  ApiProvider authProvider = ApiProvider();
  final String host =
      'https://d04c-2600-1700-a340-10e0-930-c134-41df-c8e2.ngrok-free.app';
  final String baseHost = 'http://127.0.0.1:8000';

  Future<List<Post>> fetchNewPosts() async {
    List<Post> postList = [];
    final response = await _provider.get('api/posts/');
    for (var post in response) {
      postList.add(Post.fromJson(post));
    }
    return postList;
  }

  Future<Post> fetchPost(String id) async {
    final response = await _provider.get('api/posts/$id/');
    Post post = Post.fromJson(response);
    return post;
  }
}
