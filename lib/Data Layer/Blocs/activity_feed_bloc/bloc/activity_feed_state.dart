part of 'activity_feed_bloc.dart';

abstract class ActivityFeedState extends Equatable {
  const ActivityFeedState();
  
  @override
  List<Object> get props => [];
}

class ActivityFeedInitial extends ActivityFeedState {}

class ActivityFeedLoading extends ActivityFeedState {}

class ActivityFeedLoaded extends ActivityFeedState {
  final List<FeedItem> activities;
  final bool hasMore;
  final bool isLoadingMore;
  
  const ActivityFeedLoaded({
    required this.activities,
    this.hasMore = true,
    this.isLoadingMore = false,
  });
  
  ActivityFeedLoaded copyWith({
    List<FeedItem>? activities,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ActivityFeedLoaded(
      activities: activities ?? this.activities,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
  
  @override
  List<Object> get props => [activities, hasMore, isLoadingMore];
}

class ActivityFeedError extends ActivityFeedState {
  final String message;
  
  const ActivityFeedError({required this.message});
  
  @override
  List<Object> get props => [message];
}

class MatchDonationSuccess extends ActivityFeedState {
  final String message;
  
  const MatchDonationSuccess({required this.message});
  
  @override
  List<Object> get props => [message];
}

class MatchDonationError extends ActivityFeedState {
  final String message;
  
  const MatchDonationError({required this.message});
  
  @override
  List<Object> get props => [message];
}
