part of 'payment_type_bloc_bloc.dart';

class PaymentTypeBlocEvent extends Equatable {
  const PaymentTypeBlocEvent();

  @override
  List<Object> get props => [];
}

class MakeDollarDonation extends PaymentTypeBlocEvent {}

class MakePointDonation extends PaymentTypeBlocEvent {}

class MakeHybridDonation extends PaymentTypeBlocEvent {}

class MakeHybridFundDonation extends PaymentTypeBlocEvent {}

class MakeHybridPointDonation extends PaymentTypeBlocEvent {}
