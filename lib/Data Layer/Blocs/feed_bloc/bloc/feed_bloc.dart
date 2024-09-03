import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/feed_entry_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  UserRepository userRepository = UserRepository();
  FeedBloc() : super(FeedInitial()) {
    on<FetchFeed>(_onFetchFeed);
   
  }
  void _onFetchFeed(FetchFeed event, Emitter<FeedState> emit) async {
    try {
      emit(FeedLoading());
      final feedItems = await userRepository.fetchFeed();
      emit(FeedLoaded(feedItems));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }
}
