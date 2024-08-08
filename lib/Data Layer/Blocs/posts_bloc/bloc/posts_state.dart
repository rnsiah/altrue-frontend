part of 'posts_bloc.dart';


enum PostStatus {initial, success, failure}


 class PostsState extends Equatable {
  final List<Post> posts;
  final PostStatus status;

  const PostsState({this.posts = const<Post>[], this.status= PostStatus.initial});
  
  PostsState copyWith({final List<Post>? posts,
  final PostStatus? status}){
    return PostsState(posts: posts ?? this.posts,
    status: status?? this.status);
  }
  
  @override
  List<Object> get props => [];
}

