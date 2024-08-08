// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_variation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShirtVariation _$ShirtVariationFromJson(Map<String, dynamic> json) =>
    ShirtVariation(
      color: ShirtColor.fromJson(json['color'] as Map<String, dynamic>),
      image: json['image'] as String,
      shirt: (json['shirt'] as num).toInt(),
      backImage: json['back_image'] as String?,
    );

Map<String, dynamic> _$ShirtVariationToJson(ShirtVariation instance) =>
    <String, dynamic>{
      'shirt': instance.shirt,
      'color': instance.color.toJson(),
      'image': instance.image,
      'back_image': instance.backImage,
    };
