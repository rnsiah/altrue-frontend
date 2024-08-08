part of 'payment_bloc_bloc.dart';

abstract class PaymentBlocEvent extends Equatable {
  const PaymentBlocEvent();

  @override
  List<Object> get props => [];
}

class NameCompleted extends PaymentBlocEvent {
  final String name;

  const NameCompleted({required this.name});
}

class ExpiryDateCompleted extends PaymentBlocEvent {
  final String expiryDate;

  const ExpiryDateCompleted({required this.expiryDate});
}

class HybridPurchas extends PaymentBlocEvent {}

class PointPurchase extends PaymentBlocEvent {}

class MoneyPurchase extends PaymentBlocEvent {}



// class CVV extends