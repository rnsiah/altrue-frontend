// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atrocity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Atrocity _$AtrocityFromJson(Map<String, dynamic> json) => Atrocity(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      region: json['region'] as String?,
      recentDonors: (json['recentDonors'] as List<dynamic>?)
          ?.map(
              (e) => ProfileRepresentation.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: json['info'] as String?,
      imageUrl: json['image_url'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      slug: json['slug'] as String?,
      videoURL: json['videoURL'] as String?,
      balance: (json['total_balance'] as num?)?.toDouble(),
      shirtList: (json['atrocity_shirt_list'] as List<dynamic>?)
          ?.map((e) => Shirt.fromJson(e as Map<String, dynamic>))
          .toList(),
      nonprofitList: (json['np_list'] as List<dynamic>?)
          ?.map((e) => NonProfit.fromJson(e as Map<String, dynamic>))
          .toList(),
      noOfDonations: (json['noOfDonations'] as num?)?.toInt(),
    )..links = (json['links'] as List<dynamic>?)
        ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$AtrocityToJson(Atrocity instance) => <String, dynamic>{
      'title': instance.title,
      'noOfDonations': instance.noOfDonations,
      'region': instance.region,
      'info': instance.info,
      'image_url': instance.imageUrl,
      'category': instance.category?.map((e) => e.toJson()).toList(),
      'country': instance.country?.toJson(),
      'slug': instance.slug,
      'videoURL': instance.videoURL,
      'id': instance.id,
      'total_balance': instance.balance,
      'atrocity_shirt_list':
          instance.shirtList?.map((e) => e.toJson()).toList(),
      'np_list': instance.nonprofitList?.map((e) => e.toJson()).toList(),
      'links': instance.links?.map((e) => e.toJson()).toList(),
      'recentDonors': instance.recentDonors?.map((e) => e.toJson()).toList(),
    };

AtrocityRep _$AtrocityRepFromJson(Map<String, dynamic> json) => AtrocityRep(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$AtrocityRepToJson(AtrocityRep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
