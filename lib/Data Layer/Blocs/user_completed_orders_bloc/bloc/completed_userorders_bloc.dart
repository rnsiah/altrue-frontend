import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/order_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'completed_userorders_event.dart';
part 'completed_userorders_state.dart';

class CompletedUserordersBloc
    extends Bloc<CompletedUserordersEvent, CompletedUserordersState> {
  final OrderRepository orderRepository;
  final UserRepository userRepository;
  CompletedUserordersBloc(
      {required this.orderRepository, required this.userRepository})
      : super(const CompletedUserordersState());

  @override
  Stream<CompletedUserordersState> mapEventToState(
    CompletedUserordersEvent event,
  ) async* {
    if (event is FetchCompletedOrders) {
      User? user = await userRepository.userDao.getCurrentUser(0);
      if (user != null) {
        List<Order> completedOrders =
            await orderRepository.getUserCompletedOrders(user);
        for (var i = 0; i < completedOrders.length; i++) {}
        yield state.copyWith(completedOrders: completedOrders);
      }
    }
  }
}
