part of 'payment_type_bloc_bloc.dart';

enum PaymentStatus {
  initial,
  payWithFunds,
  payWithPoints,
  hybridPayment,
  hyrbidFundPayment,
  hybridPointPayment
}

class PaymentTypeBlocState extends Equatable {
  final PaymentStatus status;

  const PaymentTypeBlocState({required this.status});

  PaymentTypeBlocState copyWith({PaymentStatus? status}) {
    return PaymentTypeBlocState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
