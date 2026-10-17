// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_representation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyRep _$CompanyRepFromJson(Map<String, dynamic> json) => CompanyRep(
  id: (json['id'] as num).toInt(),
  logo: json['logo'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$CompanyRepToJson(CompanyRep instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'id': instance.id,
      'name': instance.name,
    };
