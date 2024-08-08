// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_completion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCompletion _$CompanyCompletionFromJson(Map<String, dynamic> json) =>
    CompanyCompletion(
      companyAddress: json['address'] as String,
      companyName: json['name'] as String,
      description: json['description'] as String,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      missionStatement: json['mission'] as String?,
      profile: Profile.fromJson(json['owner'] as Map<String, dynamic>),
      wehsite: json['website_address'] as String?,
      yearStarted: json['year_started'] as String,
      logo: json['logo'] as String?,
      userId: (json['userId'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainImage: json['mainImage'] as String,
    );

Map<String, dynamic> _$CompanyCompletionToJson(CompanyCompletion instance) =>
    <String, dynamic>{
      'name': instance.companyName,
      'owner': instance.profile.toJson(),
      'mission': instance.missionStatement,
      'address': instance.companyAddress,
      'description': instance.description,
      'facebook': instance.facebook,
      'logo': instance.logo,
      'userId': instance.userId,
      'instagram': instance.instagram,
      'mainImage': instance.mainImage,
      'website_address': instance.wehsite,
      'year_started': instance.yearStarted,
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
    };
