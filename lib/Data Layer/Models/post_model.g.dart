// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  id: json['id'] as String,
  created_at: json['created_at'] as String,
  attachements: (json['attachements'] as List<dynamic>?)
      ?.map((e) => PostAttachment.fromJson(e as Map<String, dynamic>))
      .toList(),
  body: json['body'] as String,
  created_by: ProfileRepresentation.fromJson(
    json['created_by'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.created_at,
  'created_by': instance.created_by.toJson(),
  'body': instance.body,
  'attachements': instance.attachements?.map((e) => e.toJson()).toList(),
};
