import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_bloc_event.dart';
part 'payment_bloc_state.dart';

class PaymentBlocBloc extends Bloc<PaymentBlocEvent, PaymentBlocState> {
  PaymentBlocBloc()
      : super(const PaymentBlocState(paymenttype: PaymentType.none)) {
    on<HybridPurchas>(_hybridPurchase);
    on<MoneyPurchase>(_moneyPurchase);
    on<PointPurchase>(_pointPurchase);
  }

  void _hybridPurchase(HybridPurchas event, Emitter<PaymentBlocState> emit) {
    PaymentBlocState newState =
        const PaymentBlocState(paymenttype: PaymentType.hybrid);
    emit(newState);
  }

  void _moneyPurchase(MoneyPurchase event, Emitter<PaymentBlocState> emit) {
    PaymentBlocState newState =
        const PaymentBlocState(paymenttype: PaymentType.card);
    emit(newState);
  }

  void _pointPurchase(PointPurchase event, Emitter<PaymentBlocState> emit) {
    PaymentBlocState newState =
        const PaymentBlocState(paymenttype: PaymentType.points);
    emit(newState);
  }
}
