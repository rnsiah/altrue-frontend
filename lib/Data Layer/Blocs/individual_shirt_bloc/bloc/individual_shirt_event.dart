part of 'individual_shirt_bloc.dart';

abstract class IndividualShirtEvent extends Equatable {
  const IndividualShirtEvent();

  @override
  List<Object> get props => [];
}

class IndividualShirtLoaded extends IndividualShirtEvent {
  final Shirt shirt;
  const IndividualShirtLoaded(this.shirt);

  @override
  List<Object> get props => [shirt];
}
