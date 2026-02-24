part of 'matching_bloc.dart';

enum MatchingStatus { initial, loading, success, failure }

class MatchingState extends Equatable {
  final List<MatchOffer> matches;
  final MatchingStatus status;
  final String? errorMessage;
  final double totalImpact;
  final double userDonation;
  final double totalMatchAmount;
  final double donationAmount;
  final int? selectedCauseId;
  final int? selectedNonprofitId;

  const MatchingState({
    this.matches = const [],
    this.status = MatchingStatus.initial,
    this.errorMessage,
    this.totalImpact = 0,
    this.userDonation = 0,
    this.totalMatchAmount = 0,
    this.donationAmount = 0,
    this.selectedCauseId,
    this.selectedNonprofitId,
  });

  MatchingState copyWith({
    List<MatchOffer>? matches,
    MatchingStatus? status,
    String? errorMessage,
    double? totalImpact,
    double? userDonation,
    double? totalMatchAmount,
    double? donationAmount,
    int? selectedCauseId,
    int? selectedNonprofitId,
  }) {
    return MatchingState(
      matches: matches ?? this.matches,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      totalImpact: totalImpact ?? this.totalImpact,
      userDonation: userDonation ?? this.userDonation,
      totalMatchAmount: totalMatchAmount ?? this.totalMatchAmount,
      donationAmount: donationAmount ?? this.donationAmount,
      selectedCauseId: selectedCauseId ?? this.selectedCauseId,
      selectedNonprofitId: selectedNonprofitId ?? this.selectedNonprofitId,
    );
  }

  @override
  List<Object?> get props => [
        matches,
        status,
        errorMessage,
        totalImpact,
        userDonation,
        totalMatchAmount,
        donationAmount,
        selectedCauseId,
        selectedNonprofitId,
      ];

  bool get hasMatches => matches.isNotEmpty;
  
  String get impactSummary => 
      'Your \$${donationAmount.toStringAsFixed(0)} → \$${totalImpact.toStringAsFixed(0)} impact';
}
