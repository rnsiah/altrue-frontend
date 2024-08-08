import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'order_status_event.dart';
part 'order_status_state.dart';

class OrderStatusBloc extends Bloc<OrderStatusEvent, OrderStatusState> {
  final UserRepository repo = UserRepository();

  OrderStatusBloc() : super(OrderStatusState.initial) {
    on<FetchOrderStatus>(_fetchOrderStatus);
  }

  void _fetchOrderStatus(
      FetchOrderStatus event, Emitter<OrderStatusState> emit) async {
    OrderStatusState state = OrderStatusState.loading;
    String? status = await repo.getOrderStatus(event.stripeId);
    print('The status of the order is $status');
  }
}
