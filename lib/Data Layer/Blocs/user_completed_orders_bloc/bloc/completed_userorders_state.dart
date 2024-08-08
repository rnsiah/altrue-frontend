part of 'completed_userorders_bloc.dart';

enum CompletedOrderStatus { initial, success, failure }

class CompletedUserordersState extends Equatable {
  final List<Order> completedOrders;
  final CompletedOrderStatus status;

  const CompletedUserordersState(
      {this.completedOrders = const <Order>[],
      this.status = CompletedOrderStatus.initial});

  CompletedUserordersState copyWith({
    List<Order>? completedOrders,
    CompletedOrderStatus? status,
  }) {
    return CompletedUserordersState(
        completedOrders: completedOrders ?? this.completedOrders,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [completedOrders, status];
}
