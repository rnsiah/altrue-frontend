import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_campaign_repository.dart';

part 'company_campaigns_event.dart';
part 'company_campaigns_state.dart';

class CompanyCampaignsBloc extends Bloc<CompanyCampaignsEvent, CompanyCampaignsState> {
  final CompanyCampaignRepository _repository = CompanyCampaignRepository();

  CompanyCampaignsBloc() : super(const CompanyCampaignsState()) {
    on<FetchCompanyCampaigns>(_onFetchCompanyCampaigns);
    on<FetchCampaignDetail>(_onFetchCampaignDetail);
    on<RefreshCampaigns>(_onRefreshCampaigns);
  }

  Future<void> _onFetchCompanyCampaigns(
    FetchCompanyCampaigns event,
    Emitter<CompanyCampaignsState> emit,
  ) async {
    emit(state.copyWith(status: CompanyCampaignsStatus.loading));
    
    try {
      final campaigns = await _repository.getCompanyCampaigns(
        companyId: event.company.id,
        isActive: event.activeOnly,
      );
      
      emit(state.copyWith(
        campaigns: campaigns,
        status: CompanyCampaignsStatus.success,
        company: event.company,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CompanyCampaignsStatus.failure,
        errorMessage: 'Failed to load campaigns: $e',
      ));
    }
  }

  Future<void> _onFetchCampaignDetail(
    FetchCampaignDetail event,
    Emitter<CompanyCampaignsState> emit,
  ) async {
    emit(state.copyWith(status: CompanyCampaignsStatus.loading));
    
    try {
      final campaign = await _repository.getCampaignDetail(event.campaignId);
      
      emit(state.copyWith(
        selectedCampaign: campaign,
        status: CompanyCampaignsStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CompanyCampaignsStatus.failure,
        errorMessage: 'Failed to load campaign: $e',
      ));
    }
  }

  Future<void> _onRefreshCampaigns(
    RefreshCampaigns event,
    Emitter<CompanyCampaignsState> emit,
  ) async {
    if (state.company == null) return;
    
    emit(state.copyWith(status: CompanyCampaignsStatus.loading));
    
    try {
      final campaigns = await _repository.getCompanyCampaigns(
        companyId: state.company!.id,
        isActive: true,
      );
      
      emit(state.copyWith(
        campaigns: campaigns,
        status: CompanyCampaignsStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CompanyCampaignsStatus.failure,
        errorMessage: 'Failed to refresh campaigns: $e',
      ));
    }
  }
}
