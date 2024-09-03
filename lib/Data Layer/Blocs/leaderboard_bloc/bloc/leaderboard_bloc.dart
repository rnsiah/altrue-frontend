import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/leaderboard_entry_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  UserRepository userRepository = UserRepository();
  LeaderboardBloc() : super(LeaderboardInitial()) {
    on<FetchLeaderboard>(_onFetchLeaderboard);
  }

  Future<void> _onFetchLeaderboard(FetchLeaderboard event, Emitter<LeaderboardState> emit) async {
    emit(LeaderBoardLoading());

    try {
      List<LeaderBoardEntry> leaderboard = await userRepository.fetchLeaderBoard();
      emit(LeaderboardLoaded(leaderboard: leaderboard));
      
  }catch(e){
    emit(LeaderboarError(message: 
    e.toString()));
  }
}
}