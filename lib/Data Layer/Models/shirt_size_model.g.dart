// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_size_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShirtSize _$ShirtSizeFromJson(Map<String, dynamic> json) => ShirtSize(
      id: (json['size'] as num?)?.toInt(),
      size: json['sizevalue'] as String,
    );

Map<String, dynamic> _$ShirtSizeToJson(ShirtSize instance) => <String, dynamic>{
      'size': instance.id,
      'sizevalue': instance.size,
    };
