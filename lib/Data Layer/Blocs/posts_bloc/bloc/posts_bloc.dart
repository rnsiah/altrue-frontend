import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/new_posts_repository.dart';

import '../../../Models/post_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository = PostRepository();

  PostsBloc() : super(const PostsState()) {
    on<FetchPostList>(_fetchPostList);
    on<FetchPost>(_fetchPost);
  }



  void _fetchPostList(FetchPostList event, Emitter<PostsState>emit)async{
    try{
      List<Post> postList= await postRepository.fetchNewPosts();
      PostsState newState = state.copyWith(posts: postList, status: PostStatus.success);
      emit(newState);
    }catch(e){
      emit(state.copyWith(status: PostStatus.failure));
    }
  }


  void _fetchPost(FetchPost event, Emitter<PostsState>emit)async{
    
      await postRepository.fetchPost(event.post.id);
    
  }
}
