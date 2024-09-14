part of 'altrue_statistics_bloc.dart';

abstract class AltrueStatisticsState extends Equatable {
  const AltrueStatisticsState();

  @override
  List<Object?> get props => [];
}

// Initial state
class AltrueStatisticsInitial extends AltrueStatisticsState {}

// Loading state
class AltrueStatisticsLoading extends AltrueStatisticsState {}

// Loaded state with the statistics data
class AltrueStatisticsLoaded extends AltrueStatisticsState {
  final AltrueStatistics statistics;

  const AltrueStatisticsLoaded(this.statistics);

  @override
  List<Object?> get props => [statistics];
}

// Error state
class AltrueStatisticsError extends AltrueStatisticsState {
  final String message;

  const AltrueStatisticsError(this.message);

  @override
  List<Object?> get props => [message];
}