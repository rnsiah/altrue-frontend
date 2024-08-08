// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_followers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageFollower _$ManageFollowerFromJson(Map<String, dynamic> json) =>
    ManageFollower(
      id: (json['id'] as num).toInt(),
      follow: json['following'] as String,
    );

Map<String, dynamic> _$ManageFollowerToJson(ManageFollower instance) =>
    <String, dynamic>{
      'id': instance.id,
      'following': instance.follow,
    };
