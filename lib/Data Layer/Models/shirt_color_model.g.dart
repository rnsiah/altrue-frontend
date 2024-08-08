// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_color_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShirtColor _$ShirtColorFromJson(Map<String, dynamic> json) => ShirtColor(
      color: json['color'] as String,
      id: (json['id'] as num?)?.toInt(),
      hex: json['hex'] as String,
    );

Map<String, dynamic> _$ShirtColorToJson(ShirtColor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'hex': instance.hex,
    };
