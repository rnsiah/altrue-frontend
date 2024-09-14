import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/statistics_repository.dart';

part 'promoted_actions_event.dart';
part 'promoted_actions_state.dart';

class PromotedActionsBloc extends Bloc<PromotedActionsEvent, PromotedActionsState> {
  AltrueStatisticsRepository repository = AltrueStatisticsRepository();

  PromotedActionsBloc() : super(PromotedActionsInitial()) {
    on<FetchPromotedActions>(_fetchPromotedActions);
  }

  void _fetchPromotedActions(FetchPromotedActions event, Emitter<PromotedActionsState> emit )async{
    emit(PromotedActionsLoading());
    try{
      List<AltrueAction> actions  = await repository.getPromotedActions();
      emit(PromotedActionsLoaded(promotedActions: actions));
    }catch(e){
      emit(PromotedActionsError(message: e.toString()));
    }
    
    

  }
}
