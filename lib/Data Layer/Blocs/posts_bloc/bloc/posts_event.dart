part of 'posts_bloc.dart';

 class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPostList extends PostsEvent{
  
}

class FetchPost extends PostsEvent{
  final Post post;
  
  const FetchPost({required this.post});
}
