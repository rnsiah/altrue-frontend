// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_nonprofit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyNonProfit _$CompanyNonProfitFromJson(Map<String, dynamic> json) =>
    CompanyNonProfit(
      id: (json['id'] as num).toInt(),
      logo: json['logo'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CompanyNonProfitToJson(CompanyNonProfit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
