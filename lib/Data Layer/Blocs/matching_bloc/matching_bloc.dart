import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/matching_repository.dart';

part 'matching_event.dart';
part 'matching_state.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  final MatchingRepository _repository = MatchingRepository();

  MatchingBloc() : super(const MatchingState()) {
    on<FetchAvailableMatches>(_onFetchAvailableMatches);
    on<UpdateDonationAmount>(_onUpdateDonationAmount);
    on<UpdateSelectedCause>(_onUpdateSelectedCause);
    on<ClearMatches>(_onClearMatches);
  }

  Future<void> _onFetchAvailableMatches(
    FetchAvailableMatches event,
    Emitter<MatchingState> emit,
  ) async {
    emit(state.copyWith(status: MatchingStatus.loading));
    
    try {
      final response = await _repository.getAvailableMatches(
        amount: event.amount,
        causeId: event.causeId,
        nonprofitId: event.nonprofitId,
      );
      
      emit(state.copyWith(
        status: MatchingStatus.success,
        matches: response.matches,
        totalImpact: response.totalImpact,
        userDonation: response.userDonation,
        totalMatchAmount: response.totalMatchAmount,
        donationAmount: event.amount,
        selectedCauseId: event.causeId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MatchingStatus.failure,
        errorMessage: 'Failed to load matches: $e',
      ));
    }
  }

  void _onUpdateDonationAmount(
    UpdateDonationAmount event,
    Emitter<MatchingState> emit,
  ) {
    emit(state.copyWith(
      donationAmount: event.amount,
      status: MatchingStatus.initial,
    ));
    
    if (state.selectedCauseId != null && event.amount > 0) {
      add(FetchAvailableMatches(
        amount: event.amount,
        causeId: state.selectedCauseId!,
        nonprofitId: state.selectedNonprofitId,
      ));
    }
  }

  void _onUpdateSelectedCause(
    UpdateSelectedCause event,
    Emitter<MatchingState> emit,
  ) {
    emit(state.copyWith(
      selectedCauseId: event.causeId,
      selectedNonprofitId: event.nonprofitId,
      status: MatchingStatus.initial,
    ));
    
    if (state.donationAmount > 0) {
      add(FetchAvailableMatches(
        amount: state.donationAmount,
        causeId: event.causeId,
        nonprofitId: event.nonprofitId,
      ));
    }
  }

  void _onClearMatches(
    ClearMatches event,
    Emitter<MatchingState> emit,
  ) {
    emit(const MatchingState());
  }

  double calculateTotalImpact(double donation, List<MatchOffer> matches) {
    double totalMatch = 0;
    for (final match in matches) {
      totalMatch += match.calculateMatch(donation);
    }
    return donation + totalMatch;
  }
}
