import '../Data Providers/user_profile_api.dart';

import '../Models/post_model.dart';

class PostRepository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();
  ApiProvider authProvider = ApiProvider();
  final String host = 'https://f40b-2601-2c6-500-16f0-354f-818a-95d2-260.ngrok-free.app';

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
