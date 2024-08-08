// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      user: Profile.fromJson(json['user'] as Map<String, dynamic>),
      stars: (json['stars'] as num).toInt(),
      company: (json['company'] as num?)?.toInt(),
      nonprofit: (json['nonprofit'] as num?)?.toInt(),
      project: (json['project'] as num?)?.toInt(),
      shirt: (json['shirt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'shirt': instance.shirt,
      'nonprofit': instance.nonprofit,
      'project': instance.project,
      'company': instance.company,
      'user': instance.user,
      'stars': instance.stars,
    };
