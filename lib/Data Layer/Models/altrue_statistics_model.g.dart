// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altrue_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AltrueStatistics _$AltrueStatisticsFromJson(Map<String, dynamic> json) =>
    AltrueStatistics(
      totalUsers: (json['total_users'] as num).toInt(),
      totalAmountRaised: json['total_amount_raised'] as String,
      totalDonated: json['total_donated'] as String,
      totalPointsAccumulated: json['total_points_accumulated'] as String,
      totalNonprofits: (json['total_nonprofits'] as num).toInt(),
      totalCompanies: (json['total_companies'] as num).toInt(),
      totalAtrocities: (json['total_atrocities'] as num).toInt(),
      totalDonors: (json['total_donors'] as num).toInt(),
    );

Map<String, dynamic> _$AltrueStatisticsToJson(AltrueStatistics instance) =>
    <String, dynamic>{
      'total_users': instance.totalUsers,
      'total_amount_raised': instance.totalAmountRaised,
      'total_donated': instance.totalDonated,
      'total_points_accumulated': instance.totalPointsAccumulated,
      'total_nonprofits': instance.totalNonprofits,
      'total_companies': instance.totalCompanies,
      'total_atrocities': instance.totalAtrocities,
      'total_donors': instance.totalDonors,
    };
