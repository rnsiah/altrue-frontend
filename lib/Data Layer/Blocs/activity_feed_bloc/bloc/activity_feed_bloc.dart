import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/feed_entry_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'activity_feed_event.dart';
part 'activity_feed_state.dart';

class ActivityFeedBloc extends Bloc<ActivityFeedEvent, ActivityFeedState> {
  final UserRepository _userRepository;
  
  ActivityFeedBloc({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(ActivityFeedInitial()) {
    on<FetchActivityFeed>(_onFetchActivityFeed);
    on<LoadMoreActivities>(_onLoadMoreActivities);
    on<MatchDonation>(_onMatchDonation);
  }

  Future<void> _onFetchActivityFeed(
    FetchActivityFeed event,
    Emitter<ActivityFeedState> emit,
  ) async {
    emit(ActivityFeedLoading());
    
    try {
      final activities = await _userRepository.fetchFeed();
      emit(ActivityFeedLoaded(
        activities: activities,
        hasMore: activities.length >= 20,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(ActivityFeedError(message: 'Failed to load activity feed: $e'));
    }
  }

  Future<void> _onLoadMoreActivities(
    LoadMoreActivities event,
    Emitter<ActivityFeedState> emit,
  ) async {
    final currentState = state;
    if (currentState is ActivityFeedLoaded) {
      emit(currentState.copyWith(isLoadingMore: true));
      
      try {
        // TODO: Implement pagination with lastTimestamp when API supports it
        final moreActivities = await _userRepository.fetchFeed();
        
        final allActivities = [...currentState.activities, ...moreActivities];
        
        emit(ActivityFeedLoaded(
          activities: allActivities,
          hasMore: moreActivities.length >= 20,
          isLoadingMore: false,
        ));
      } catch (e) {
        emit(ActivityFeedError(message: 'Failed to load more activities: $e'));
      }
    }
  }

  Future<void> _onMatchDonation(
    MatchDonation event,
    Emitter<ActivityFeedState> emit,
  ) async {
    final currentState = state;
    
    try {
      // TODO: Implement actual donation matching API call
      // For now, simulate success
      await Future.delayed(const Duration(seconds: 1));
      
      emit(MatchDonationSuccess(
        message: 'You matched ${event.username}\'s \$${event.amount.toStringAsFixed(2)} donation!',
      ));
      
      // Re-emit the loaded state to maintain UI
      if (currentState is ActivityFeedLoaded) {
        emit(currentState);
      }
    } catch (e) {
      emit(MatchDonationError(message: 'Failed to match donation: $e'));
      if (currentState is ActivityFeedLoaded) {
        emit(currentState);
      }
    }
  }
}
