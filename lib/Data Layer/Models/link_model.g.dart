// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      json['atrocity'] == null
          ? null
          : Atrocity.fromJson(json['atrocity'] as Map<String, dynamic>),
      json['company'] == null
          ? null
          : ForProfitCompany.fromJson(json['company'] as Map<String, dynamic>),
      json['nonprofit'] == null
          ? null
          : NonProfit.fromJson(json['nonprofit'] as Map<String, dynamic>),
      link: json['link'] as String,
      author: json['author'] as String,
      publication: json['publication'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'atrocity': instance.atrocity?.toJson(),
      'company': instance.company?.toJson(),
      'nonprofit': instance.nonprofit?.toJson(),
      'author': instance.author,
      'publication': instance.publication,
    };
