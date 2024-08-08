// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShirtGroup _$ShirtGroupFromJson(Map<String, dynamic> json) => ShirtGroup(
      name: json['name'] as String?,
      creator: json['creator'] as String?,
      description: json['description'] as String?,
      groupImage: json['groupImage'] as String?,
      shirts: (json['shirts'] as List<dynamic>?)
          ?.map((e) => Shirt.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShirtGroupToJson(ShirtGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groupImage': instance.groupImage,
      'description': instance.description,
      'creator': instance.creator,
      'shirts': instance.shirts?.map((e) => e.toJson()).toList(),
    };
