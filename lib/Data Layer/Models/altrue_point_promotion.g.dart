// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altrue_point_promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AltruePointPromotion _$AltruePointPromotionFromJson(
        Map<String, dynamic> json) =>
    AltruePointPromotion(
      description: json['description'] as String,
      name: json['name'] as String,
      isActive: json['is_active'] as bool,
      donationIncrease: (json['donation_increase'] as num?)?.toInt(),
      endDate: json['end_date'] as String?,
      multiplier: (json['multiplier'] as num?)?.toInt(),
      startDate: json['start_date'] as String?,
    );

Map<String, dynamic> _$AltruePointPromotionToJson(
        AltruePointPromotion instance) =>
    <String, dynamic>{
      'multiplier': instance.multiplier,
      'name': instance.name,
      'description': instance.description,
      'donation_increase': instance.donationIncrease,
      'is_active': instance.isActive,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
