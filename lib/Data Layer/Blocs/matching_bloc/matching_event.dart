part of 'matching_bloc.dart';

abstract class MatchingEvent extends Equatable {
  const MatchingEvent();

  @override
  List<Object?> get props => [];
}

class FetchAvailableMatches extends MatchingEvent {
  final double amount;
  final int causeId;
  final int? nonprofitId;

  const FetchAvailableMatches({
    required this.amount,
    required this.causeId,
    this.nonprofitId,
  });

  @override
  List<Object?> get props => [amount, causeId, nonprofitId];
}

class UpdateDonationAmount extends MatchingEvent {
  final double amount;

  const UpdateDonationAmount({required this.amount});

  @override
  List<Object?> get props => [amount];
}

class UpdateSelectedCause extends MatchingEvent {
  final int causeId;
  final int? nonprofitId;

  const UpdateSelectedCause({
    required this.causeId,
    this.nonprofitId,
  });

  @override
  List<Object?> get props => [causeId, nonprofitId];
}

class ClearMatches extends MatchingEvent {
  const ClearMatches();
}
