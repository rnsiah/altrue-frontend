part of 'order_status_bloc.dart';

class OrderStatusEvent extends Equatable {
  const OrderStatusEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderStatus extends OrderStatusEvent {
  final String stripeId;
  const FetchOrderStatus({required this.stripeId});
}
