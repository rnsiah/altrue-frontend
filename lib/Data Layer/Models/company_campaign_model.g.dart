// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_campaign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCampaign _$CompanyCampaignFromJson(Map<String, dynamic> json) =>
    CompanyCampaign(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      matchMultiplier: (json['matchMultiplier'] as num).toDouble(),
      budgetCap: (json['budget_cap'] as num).toDouble(),
      amountMatched: (json['amount_matched'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      isActive: json['is_active'] as bool,
      sponsorLogoPlacement: json['sponsor_logo_placement'] as String?,
      causeCategories: json['cause_categories'] as List<dynamic>?,
      daysRemaining: (json['days_remaining'] as num?)?.toInt(),
      progressPercentage: (json['progress_percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CompanyCampaignToJson(CompanyCampaign instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'matchMultiplier': instance.matchMultiplier,
      'budget_cap': instance.budgetCap,
      'amount_matched': instance.amountMatched,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'is_active': instance.isActive,
      'sponsor_logo_placement': instance.sponsorLogoPlacement,
      'cause_categories': instance.causeCategories,
      'days_remaining': instance.daysRemaining,
      'progress_percentage': instance.progressPercentage,
    };

MatchOffer _$MatchOfferFromJson(Map<String, dynamic> json) => MatchOffer(
      company:
          ForProfitCompany.fromJson(json['company'] as Map<String, dynamic>),
      matchPercentage: (json['matchPercentage'] as num).toDouble(),
      isBaseMatch: json['is_base_match'] as bool,
      isCampaignMatch: json['is_campaign_match'] as bool,
      campaignName: json['campaign_name'] as String?,
      maxMatchAmount: (json['max_match_amount'] as num?)?.toDouble(),
      matchMultiplier: (json['match_multiplier'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MatchOfferToJson(MatchOffer instance) =>
    <String, dynamic>{
      'company': instance.company.toJson(),
      'matchPercentage': instance.matchPercentage,
      'is_base_match': instance.isBaseMatch,
      'is_campaign_match': instance.isCampaignMatch,
      'campaign_name': instance.campaignName,
      'max_match_amount': instance.maxMatchAmount,
      'match_multiplier': instance.matchMultiplier,
    };

AvailableMatchesResponse _$AvailableMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    AvailableMatchesResponse(
      matches: (json['matches'] as List<dynamic>)
          .map((e) => MatchOffer.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalImpact: (json['total_impact'] as num).toDouble(),
      userDonation: (json['user_donation'] as num).toDouble(),
      totalMatchAmount: (json['total_match_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$AvailableMatchesResponseToJson(
        AvailableMatchesResponse instance) =>
    <String, dynamic>{
      'matches': instance.matches.map((e) => e.toJson()).toList(),
      'total_impact': instance.totalImpact,
      'user_donation': instance.userDonation,
      'total_match_amount': instance.totalMatchAmount,
    };
