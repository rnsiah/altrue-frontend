part of 'individual_shirt_bloc.dart';

enum IndiShirtStatus { initial, loading, lodaded, failed }

abstract class IndividualShirtState extends Equatable {
  const IndividualShirtState();

  @override
  List<Object> get props => [];
}

class IndiShirtLoadInProgress extends IndividualShirtState {}

class IndiShirtLoadSuccess extends IndividualShirtState {
  final Shirt shirt;

  const IndiShirtLoadSuccess({required this.shirt});

  @override
  List<Object> get props => [shirt];
}

class IndiShirtLoadFailure extends IndividualShirtState {}
