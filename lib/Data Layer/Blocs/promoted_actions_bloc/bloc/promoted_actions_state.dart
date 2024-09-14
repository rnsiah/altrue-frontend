part of 'promoted_actions_bloc.dart';

class PromotedActionsState extends Equatable {
  const PromotedActionsState();
  
  @override
  List<Object> get props => [];
}

class PromotedActionsInitial extends PromotedActionsState {}

class PromotedActionsLoading extends PromotedActionsState{
  
}

class PromotedActionsLoaded extends PromotedActionsState{
  final List<AltrueAction> promotedActions;

  const PromotedActionsLoaded({required this.promotedActions});
}


class PromotedActionsError extends PromotedActionsState{
  final String message;
  const PromotedActionsError({required this.message});
}
