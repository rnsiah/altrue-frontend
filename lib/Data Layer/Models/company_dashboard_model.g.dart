// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDashboard _$CompanyDashboardFromJson(Map<String, dynamic> json) =>
    CompanyDashboard(
      matchedThisMonth: (json['matched_this_month'] as num).toDouble(),
      budgetRemaining: (json['budget_remaining'] as num).toDouble(),
      monthlyBudget: (json['monthly_budget'] as num).toDouble(),
      uniqueDonors: (json['unique_donors'] as num).toInt(),
      totalDonors: (json['total_donors'] as num).toInt(),
      activeCampaigns: (json['active_campaigns'] as List<dynamic>)
          .map((e) => CompanyCampaign.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletBalance: (json['wallet_balance'] as num).toDouble(),
      autoRefillEnabled: json['auto_refill_enabled'] as bool,
      recentMatches: (json['recent_matches'] as List<dynamic>)
          .map((e) => RecentMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
      impactStats: CompanyImpactStats.fromJson(
          json['impact_stats'] as Map<String, dynamic>),
      isOwner: json['is_owner'] as bool,
    );

Map<String, dynamic> _$CompanyDashboardToJson(CompanyDashboard instance) =>
    <String, dynamic>{
      'matched_this_month': instance.matchedThisMonth,
      'budget_remaining': instance.budgetRemaining,
      'monthly_budget': instance.monthlyBudget,
      'unique_donors': instance.uniqueDonors,
      'total_donors': instance.totalDonors,
      'active_campaigns':
          instance.activeCampaigns.map((e) => e.toJson()).toList(),
      'wallet_balance': instance.walletBalance,
      'auto_refill_enabled': instance.autoRefillEnabled,
      'recent_matches': instance.recentMatches.map((e) => e.toJson()).toList(),
      'impact_stats': instance.impactStats.toJson(),
      'is_owner': instance.isOwner,
    };

CompanyImpactStats _$CompanyImpactStatsFromJson(Map<String, dynamic> json) =>
    CompanyImpactStats(
      totalMatchedAllTime: (json['total_matched_all_time'] as num).toDouble(),
      totalDonationsMatched: (json['total_donations_matched'] as num).toInt(),
      nonprofitsSupported: (json['nonprofits_supported'] as num).toInt(),
      causesSupported: (json['causes_supported'] as num).toInt(),
      avgMatchAmount: (json['avg_match_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$CompanyImpactStatsToJson(CompanyImpactStats instance) =>
    <String, dynamic>{
      'total_matched_all_time': instance.totalMatchedAllTime,
      'total_donations_matched': instance.totalDonationsMatched,
      'nonprofits_supported': instance.nonprofitsSupported,
      'causes_supported': instance.causesSupported,
      'avg_match_amount': instance.avgMatchAmount,
    };
