// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_atrocity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyAtrocity _$CompanyAtrocityFromJson(Map<String, dynamic> json) =>
    CompanyAtrocity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      category: (json['category'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyAtrocityToJson(CompanyAtrocity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category.map((e) => e.toJson()).toList(),
      'country': instance.country.toJson(),
    };
