import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';

part 'company_campaign_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyCampaign {
  final int id;
  final String name;
  final String? description;
  final double matchMultiplier;
  
  @JsonKey(name: 'budget_cap')
  final double budgetCap;
  
  @JsonKey(name: 'amount_matched')
  final double amountMatched;
  
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  
  @JsonKey(name: 'is_active')
  final bool isActive;
  
  @JsonKey(name: 'sponsor_logo_placement')
  final String? sponsorLogoPlacement;
  
  @JsonKey(name: 'cause_categories')
  final List<dynamic>? causeCategories;
  
  @JsonKey(name: 'days_remaining')
  final int? daysRemaining;
  
  @JsonKey(name: 'progress_percentage')
  final double? progressPercentage;

  CompanyCampaign({
    required this.id,
    required this.name,
    this.description,
    required this.matchMultiplier,
    required this.budgetCap,
    required this.amountMatched,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    this.sponsorLogoPlacement,
    this.causeCategories,
    this.daysRemaining,
    this.progressPercentage,
  });

  factory CompanyCampaign.fromJson(Map<String, dynamic> json) =>
      _$CompanyCampaignFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyCampaignToJson(this);

  double get remainingBudget => budgetCap - amountMatched;
  
  double get matchPercentage => ((amountMatched / budgetCap) * 100).clamp(0, 100);
  
  bool get isFullyMatched => amountMatched >= budgetCap;
  
  String get formattedMatchMultiplier => '${matchMultiplier}x';
}

@JsonSerializable(explicitToJson: true)
class MatchOffer {
  final ForProfitCompany company;
  final double matchPercentage;
  
  @JsonKey(name: 'is_base_match')
  final bool isBaseMatch;
  
  @JsonKey(name: 'is_campaign_match')
  final bool isCampaignMatch;
  
  @JsonKey(name: 'campaign_name')
  final String? campaignName;
  
  @JsonKey(name: 'max_match_amount')
  final double? maxMatchAmount;
  
  @JsonKey(name: 'match_multiplier')
  final double? matchMultiplier;

  MatchOffer({
    required this.company,
    required this.matchPercentage,
    required this.isBaseMatch,
    required this.isCampaignMatch,
    this.campaignName,
    this.maxMatchAmount,
    this.matchMultiplier,
  });

  factory MatchOffer.fromJson(Map<String, dynamic> json) =>
      _$MatchOfferFromJson(json);

  Map<String, dynamic> toJson() => _$MatchOfferToJson(this);

  double calculateMatch(double donationAmount) {
    if (matchMultiplier != null) {
      return donationAmount * (matchMultiplier! - 1);
    }
    double match = donationAmount * (matchPercentage / 100);
    if (maxMatchAmount != null && match > maxMatchAmount!) {
      return maxMatchAmount!;
    }
    return match;
  }
}

@JsonSerializable(explicitToJson: true)
class AvailableMatchesResponse {
  final List<MatchOffer> matches;
  
  @JsonKey(name: 'total_impact')
  final double totalImpact;
  
  @JsonKey(name: 'user_donation')
  final double userDonation;
  
  @JsonKey(name: 'total_match_amount')
  final double totalMatchAmount;

  AvailableMatchesResponse({
    required this.matches,
    required this.totalImpact,
    required this.userDonation,
    required this.totalMatchAmount,
  });

  factory AvailableMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableMatchesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableMatchesResponseToJson(this);
}
