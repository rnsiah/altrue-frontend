part of 'completed_userorders_bloc.dart';

abstract class CompletedUserordersEvent extends Equatable {
  const CompletedUserordersEvent();

  @override
  List<Object> get props => [];
}

class FetchCompletedOrders extends CompletedUserordersEvent {
  final List<Order> completedOrders;

  const FetchCompletedOrders({required this.completedOrders});
  @override
  List<Object> get props => [completedOrders];
}
