// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_company_impact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCompanyImpact _$UserCompanyImpactFromJson(Map<String, dynamic> json) =>
    UserCompanyImpact(
      totalMatched: (json['total_matched'] as num).toDouble(),
      totalDonations: (json['total_donations'] as num).toInt(),
      byCompany: (json['by_company'] as List<dynamic>)
          .map((e) => CompanyMatchSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentMatches: (json['recent_matches'] as List<dynamic>?)
          ?.map((e) => RecentMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserCompanyImpactToJson(UserCompanyImpact instance) =>
    <String, dynamic>{
      'total_matched': instance.totalMatched,
      'total_donations': instance.totalDonations,
      'by_company': instance.byCompany.map((e) => e.toJson()).toList(),
      'recent_matches': instance.recentMatches?.map((e) => e.toJson()).toList(),
    };

CompanyMatchSummary _$CompanyMatchSummaryFromJson(Map<String, dynamic> json) =>
    CompanyMatchSummary(
      company:
          ForProfitCompany.fromJson(json['company'] as Map<String, dynamic>),
      totalMatched: (json['total_matched'] as num).toDouble(),
      donationCount: (json['donation_count'] as num).toInt(),
      lastMatchedAt: json['last_matched_at'] == null
          ? null
          : DateTime.parse(json['last_matched_at'] as String),
      topCause: json['top_cause'] as String?,
    );

Map<String, dynamic> _$CompanyMatchSummaryToJson(
        CompanyMatchSummary instance) =>
    <String, dynamic>{
      'company': instance.company.toJson(),
      'total_matched': instance.totalMatched,
      'donation_count': instance.donationCount,
      'last_matched_at': instance.lastMatchedAt?.toIso8601String(),
      'top_cause': instance.topCause,
    };

RecentMatch _$RecentMatchFromJson(Map<String, dynamic> json) => RecentMatch(
      id: (json['id'] as num).toInt(),
      donorName: json['donor_name'] as String,
      donationAmount: (json['donation_amount'] as num).toDouble(),
      matchAmount: (json['match_amount'] as num).toDouble(),
      causeName: json['cause_name'] as String?,
      nonprofitName: json['nonprofit_name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RecentMatchToJson(RecentMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'donor_name': instance.donorName,
      'donation_amount': instance.donationAmount,
      'match_amount': instance.matchAmount,
      'cause_name': instance.causeName,
      'nonprofit_name': instance.nonprofitName,
      'created_at': instance.createdAt.toIso8601String(),
    };
