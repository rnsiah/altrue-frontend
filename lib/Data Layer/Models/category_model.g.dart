// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => NonProfitProject.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectCount: (json['project_count'] as num?)?.toInt(),
      donationTotal: (json['donationTotal'] as num?)?.toDouble(),
      nonprofitCount: (json['nonprofit_count'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      information: json['information'] as String?,
      nonprofitList: (json['all_nonprofits'] as List<dynamic>?)
          ?.map((e) => NonProfitRep.fromJson(e as Map<String, dynamic>))
          .toList(),
      blurb: json['blurb'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'nonprofit_count': instance.nonprofitCount,
      'donationTotal': instance.donationTotal,
      'project_count': instance.projectCount,
      'projects': instance.projects?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'all_nonprofits': instance.nonprofitList?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'image': instance.image,
      'information': instance.information,
      'blurb': instance.blurb,
    };
