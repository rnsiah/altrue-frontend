import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_company_impact_model.dart';

part 'company_dashboard_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyDashboard {
  @JsonKey(name: 'matched_this_month')
  final double matchedThisMonth;
  
  @JsonKey(name: 'budget_remaining')
  final double budgetRemaining;
  
  @JsonKey(name: 'monthly_budget')
  final double monthlyBudget;
  
  @JsonKey(name: 'unique_donors')
  final int uniqueDonors;
  
  @JsonKey(name: 'total_donors')
  final int totalDonors;
  
  @JsonKey(name: 'active_campaigns')
  final List<CompanyCampaign> activeCampaigns;
  
  @JsonKey(name: 'wallet_balance')
  final double walletBalance;
  
  @JsonKey(name: 'auto_refill_enabled')
  final bool autoRefillEnabled;
  
  @JsonKey(name: 'recent_matches')
  final List<RecentMatch> recentMatches;
  
  @JsonKey(name: 'impact_stats')
  final CompanyImpactStats impactStats;
  
  @JsonKey(name: 'is_owner')
  final bool isOwner;

  CompanyDashboard({
    required this.matchedThisMonth,
    required this.budgetRemaining,
    required this.monthlyBudget,
    required this.uniqueDonors,
    required this.totalDonors,
    required this.activeCampaigns,
    required this.walletBalance,
    required this.autoRefillEnabled,
    required this.recentMatches,
    required this.impactStats,
    required this.isOwner,
  });

  factory CompanyDashboard.fromJson(Map<String, dynamic> json) =>
      _$CompanyDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDashboardToJson(this);

  double get monthlyProgress => monthlyBudget > 0 
      ? ((matchedThisMonth / monthlyBudget) * 100).clamp(0, 100) 
      : 0;
  
  bool get isNearBudgetLimit => budgetRemaining < (monthlyBudget * 0.1);
  
  bool get hasActiveCampaigns => activeCampaigns.isNotEmpty;
}

@JsonSerializable(explicitToJson: true)
class CompanyImpactStats {
  @JsonKey(name: 'total_matched_all_time')
  final double totalMatchedAllTime;
  
  @JsonKey(name: 'total_donations_matched')
  final int totalDonationsMatched;
  
  @JsonKey(name: 'nonprofits_supported')
  final int nonprofitsSupported;
  
  @JsonKey(name: 'causes_supported')
  final int causesSupported;
  
  @JsonKey(name: 'avg_match_amount')
  final double avgMatchAmount;

  CompanyImpactStats({
    required this.totalMatchedAllTime,
    required this.totalDonationsMatched,
    required this.nonprofitsSupported,
    required this.causesSupported,
    required this.avgMatchAmount,
  });

  factory CompanyImpactStats.fromJson(Map<String, dynamic> json) =>
      _$CompanyImpactStatsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyImpactStatsToJson(this);
}
