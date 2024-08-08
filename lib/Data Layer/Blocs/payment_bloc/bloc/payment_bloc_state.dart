part of 'payment_bloc_bloc.dart';

enum PaymentType { none, card, hybrid, points }

class PaymentBlocState extends Equatable {
  final PaymentType? paymenttype;
  const PaymentBlocState({this.paymenttype = PaymentType.none});

  @override
  List<Object> get props => [];
}

class PaymentBlocInitial extends PaymentBlocState {}
