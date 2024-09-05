// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altrue_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AltrueLevel _$AltrueLevelFromJson(Map<String, dynamic> json) => AltrueLevel(
      name: json['name'] as String,
      levelNumber: (json['level_number'] as num).toInt(),
      maximumPoints: (json['maximum_points'] as num).toInt(),
      minimumPoints: (json['minimum_points'] as num).toInt(),
      requiredActions: (json['requiredActions'] as List<dynamic>?)
          ?.map((e) => AltrueAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AltrueLevelToJson(AltrueLevel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'minimum_points': instance.minimumPoints,
      'maximum_points': instance.maximumPoints,
      'level_number': instance.levelNumber,
      'requiredActions':
          instance.requiredActions?.map((e) => e.toJson()).toList(),
    };
