import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_statistics_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/statistics_repository.dart';

part 'altrue_statistics_event.dart';
part 'altrue_statistics_state.dart';

class AltrueStatisticsBloc extends Bloc<AltrueStatisticsEvent, AltrueStatisticsState> {
  final AltrueStatisticsRepository repository = AltrueStatisticsRepository();

  AltrueStatisticsBloc() : super(AltrueStatisticsInitial()) {
   on<FetchAltrueStatistics>(_fetchAltrueStatistics);
   
  }

    Future<void> _fetchAltrueStatistics(
      FetchAltrueStatistics event, Emitter<AltrueStatisticsState> emit) async {
    emit(AltrueStatisticsLoading());

    try {
      final statistics = await repository.getStatistics();
      emit(AltrueStatisticsLoaded(statistics));
    } catch (error) {
      emit(AltrueStatisticsError(error.toString()));
    }
  }
}
