import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_type_bloc_event.dart';
part 'payment_type_bloc_state.dart';

class PaymentTypeBloc extends Bloc<PaymentTypeBlocEvent, PaymentTypeBlocState> {
  PaymentTypeBloc()
      : super(const PaymentTypeBlocState(status: PaymentStatus.initial)) {
    on<MakeDollarDonation>(_makeDollarDonation);
    on<MakeHybridDonation>(_makeHybridDonation);
    on<MakeHybridFundDonation>(_makeHybridFundDonation);
    on<MakeHybridPointDonation>(_makeHybridPointDonation);
  }

  void _makeDollarDonation(
      MakeDollarDonation event, Emitter<PaymentTypeBlocState> emit) async {
    emit(state.copyWith(status: PaymentStatus.payWithFunds));
  }

  void _makeHybridDonation(
      MakeHybridDonation event, Emitter<PaymentTypeBlocState> emit) async {
    emit(state.copyWith(status: PaymentStatus.hybridPayment));
  }

  void _makeHybridFundDonation(
      MakeHybridFundDonation event, Emitter<PaymentTypeBlocState> emit) async {
    emit(state.copyWith(status: PaymentStatus.hyrbidFundPayment));
  }

  void _makeHybridPointDonation(
      MakeHybridPointDonation event, Emitter<PaymentTypeBlocState> emit) async {
    emit(state.copyWith(status: PaymentStatus.hybridPointPayment));
  }
}
