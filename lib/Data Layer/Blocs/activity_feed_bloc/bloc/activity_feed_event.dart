part of 'activity_feed_bloc.dart';

abstract class ActivityFeedEvent extends Equatable {
  const ActivityFeedEvent();

  @override
  List<Object> get props => [];
}

class FetchActivityFeed extends ActivityFeedEvent {
  final bool refresh;
  
  const FetchActivityFeed({this.refresh = false});
  
  @override
  List<Object> get props => [refresh];
}

class LoadMoreActivities extends ActivityFeedEvent {
  final String? lastTimestamp;
  
  const LoadMoreActivities({this.lastTimestamp});
  
  @override
  List<Object> get props => [lastTimestamp ?? ''];
}

class MatchDonation extends ActivityFeedEvent {
  final String username;
  final double amount;
  final int nonprofitId;
  
  const MatchDonation({
    required this.username,
    required this.amount,
    required this.nonprofitId,
  });
  
  @override
  List<Object> get props => [username, amount, nonprofitId];
}
