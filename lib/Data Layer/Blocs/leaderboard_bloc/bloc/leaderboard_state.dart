part of 'leaderboard_bloc.dart';

class LeaderboardState extends Equatable {
  const LeaderboardState();
  
  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {

  @override
  List<Object> get props => [];
}


class LeaderBoardLoading extends LeaderboardState{

  @override
  List<Object> get props => [];

}

class LeaderboardLoaded extends LeaderboardState{
  final List<LeaderBoardEntry> leaderboard;
  
  const LeaderboardLoaded({required this.leaderboard});


  @override
  List<Object> get props => [leaderboard];

}

class LeaderboarError extends LeaderboardState{
  final String message;

  const LeaderboarError({required this.message});

  @override
  List<Object> get props => [message];
}