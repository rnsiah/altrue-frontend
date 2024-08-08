// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAttachment _$PostAttachmentFromJson(Map<String, dynamic> json) =>
    PostAttachment(
      created_by: ProfileRepresentation.fromJson(
          json['created_by'] as Map<String, dynamic>),
      image: json['image'] as String,
    );

Map<String, dynamic> _$PostAttachmentToJson(PostAttachment instance) =>
    <String, dynamic>{
      'image': instance.image,
      'created_by': instance.created_by.toJson(),
    };
