
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';

part 'individual_shirt_event.dart';
part 'individual_shirt_state.dart';

class IndividualShirtBloc
    extends Bloc<IndividualShirtEvent, IndividualShirtState> {
  ShirtRepository shirtRepository;

  IndividualShirtBloc(this.shirtRepository) : super(IndiShirtLoadInProgress()){
    on<IndividualShirtLoaded>(_individualShirtLoaded);
  }

  void _individualShirtLoaded(IndividualShirtLoaded event, Emitter<IndividualShirtState> emit) async {
    try {
      Shirt shirt = await shirtRepository.fetchShirt(event.shirt.id!);
      emit(IndiShirtLoadSuccess(shirt: shirt));
    } catch (e) {
      emit(IndiShirtLoadFailure());
    }
  }


}
