// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altrue_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AltrueAction _$AltrueActionFromJson(Map<String, dynamic> json) => AltrueAction(
      name: json['requirement'] as String?,
      pointsAwarded: (json['points_awarded'] as num?)?.toInt(),
      isPromoted: json['is_promoted'] as bool,
    )
      ..promotion = json['promotion'] == null
          ? null
          : AltruePointPromotion.fromJson(
              json['promotion'] as Map<String, dynamic>)
      ..actionCode = json['action_code'] == null
          ? null
          : AltrueActionCode.fromJson(
              json['action_code'] as Map<String, dynamic>)
      ..info = json['info'] as String?;

Map<String, dynamic> _$AltrueActionToJson(AltrueAction instance) =>
    <String, dynamic>{
      'requirement': instance.name,
      'points_awarded': instance.pointsAwarded,
      'is_promoted': instance.isPromoted,
      'promotion': instance.promotion?.toJson(),
      'action_code': instance.actionCode?.toJson(),
      'info': instance.info,
    };
