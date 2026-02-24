part of 'company_campaigns_bloc.dart';

abstract class CompanyCampaignsEvent extends Equatable {
  const CompanyCampaignsEvent();

  @override
  List<Object?> get props => [];
}

class FetchCompanyCampaigns extends CompanyCampaignsEvent {
  final ForProfitCompany company;
  final bool activeOnly;

  const FetchCompanyCampaigns({
    required this.company,
    this.activeOnly = true,
  });

  @override
  List<Object?> get props => [company, activeOnly];
}

class FetchCampaignDetail extends CompanyCampaignsEvent {
  final int campaignId;

  const FetchCampaignDetail({required this.campaignId});

  @override
  List<Object?> get props => [campaignId];
}

class RefreshCampaigns extends CompanyCampaignsEvent {
  const RefreshCampaigns();
}
