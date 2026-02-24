part of 'company_campaigns_bloc.dart';

enum CompanyCampaignsStatus { initial, loading, success, failure }

class CompanyCampaignsState extends Equatable {
  final List<CompanyCampaign> campaigns;
  final CompanyCampaignsStatus status;
  final String? errorMessage;
  final ForProfitCompany? company;
  final CompanyCampaign? selectedCampaign;

  const CompanyCampaignsState({
    this.campaigns = const [],
    this.status = CompanyCampaignsStatus.initial,
    this.errorMessage,
    this.company,
    this.selectedCampaign,
  });

  CompanyCampaignsState copyWith({
    List<CompanyCampaign>? campaigns,
    CompanyCampaignsStatus? status,
    String? errorMessage,
    ForProfitCompany? company,
    CompanyCampaign? selectedCampaign,
  }) {
    return CompanyCampaignsState(
      campaigns: campaigns ?? this.campaigns,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      company: company ?? this.company,
      selectedCampaign: selectedCampaign ?? this.selectedCampaign,
    );
  }

  @override
  List<Object?> get props => [
        campaigns,
        status,
        errorMessage,
        company,
        selectedCampaign,
      ];
}
