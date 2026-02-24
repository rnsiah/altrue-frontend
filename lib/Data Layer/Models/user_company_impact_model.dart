import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';

part 'user_company_impact_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserCompanyImpact {
  @JsonKey(name: 'total_matched')
  final double totalMatched;
  
  @JsonKey(name: 'total_donations')
  final int totalDonations;
  
  @JsonKey(name: 'by_company')
  final List<CompanyMatchSummary> byCompany;
  
  @JsonKey(name: 'recent_matches')
  final List<RecentMatch>? recentMatches;

  UserCompanyImpact({
    required this.totalMatched,
    required this.totalDonations,
    required this.byCompany,
    this.recentMatches,
  });

  factory UserCompanyImpact.fromJson(Map<String, dynamic> json) =>
      _$UserCompanyImpactFromJson(json);

  Map<String, dynamic> toJson() => _$UserCompanyImpactToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyMatchSummary {
  final ForProfitCompany company;
  
  @JsonKey(name: 'total_matched')
  final double totalMatched;
  
  @JsonKey(name: 'donation_count')
  final int donationCount;
  
  @JsonKey(name: 'last_matched_at')
  final DateTime? lastMatchedAt;
  
  @JsonKey(name: 'top_cause')
  final String? topCause;

  CompanyMatchSummary({
    required this.company,
    required this.totalMatched,
    required this.donationCount,
    this.lastMatchedAt,
    this.topCause,
  });

  factory CompanyMatchSummary.fromJson(Map<String, dynamic> json) =>
      _$CompanyMatchSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyMatchSummaryToJson(this);

  double get averageMatch => donationCount > 0 ? totalMatched / donationCount : 0;
}

@JsonSerializable(explicitToJson: true)
class RecentMatch {
  final int id;
  
  @JsonKey(name: 'donor_name')
  final String donorName;
  
  @JsonKey(name: 'donation_amount')
  final double donationAmount;
  
  @JsonKey(name: 'match_amount')
  final double matchAmount;
  
  @JsonKey(name: 'cause_name')
  final String? causeName;
  
  @JsonKey(name: 'nonprofit_name')
  final String? nonprofitName;
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  RecentMatch({
    required this.id,
    required this.donorName,
    required this.donationAmount,
    required this.matchAmount,
    this.causeName,
    this.nonprofitName,
    required this.createdAt,
  });

  factory RecentMatch.fromJson(Map<String, dynamic> json) =>
      _$RecentMatchFromJson(json);

  Map<String, dynamic> toJson() => _$RecentMatchToJson(this);

  String get impactStatement => 
      '\$${donationAmount.toStringAsFixed(0)} → \$${(donationAmount + matchAmount).toStringAsFixed(0)} impact';
}
