part of 'feed_bloc.dart';

class FeedState extends Equatable {
  const FeedState();
  
  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}


class FeedLoading extends FeedState{
  
}

class FeedLoaded extends FeedState {
  final List<FeedItem> feedItems;

  const FeedLoaded(this.feedItems);

  @override
  List<Object> get props => [feedItems];
}

class FeedError extends FeedState {
  final String message;

  const FeedError(this.message);

  @override
  List<Object> get props => [message];
}
