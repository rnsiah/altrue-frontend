// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForProfitCompany _$ForProfitCompanyFromJson(Map<String, dynamic> json) =>
    ForProfitCompany(
      json['image'] as String?,
      (json['totalDonationCount'] as num?)?.toInt(),
      (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['id'] as num).toInt(),
      json['logo'] as String?,
      json['donationsMade'] == null
          ? null
          : AllCompanyDonations.fromJson(
              json['donationsMade'] as Map<String, dynamic>),
      json['mission'] as String?,
      json['year_started'] as String,
      json['name'] as String,
      json['description'] as String?,
      json['headquarters'] as String?,
      json['owner'] == null
          ? null
          : Profile.fromJson(json['owner'] as Map<String, dynamic>),
      (json['totalDonated'] as num?)?.toDouble(),
      json['slug'] as String,
      json['website_address'] as String,
      (json['coupons'] as List<dynamic>?)
          ?.map((e) => CompanyCoupon.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['atrocities'] as List<dynamic>?)
          ?.map((e) => CompanyAtrocity.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['atrocityRelationships'] as List<dynamic>?)
          ?.map((e) => CompanyAtrocityMatchRelationShip.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['nonprofitRelationships'] as List<dynamic>?)
          ?.map((e) => CompanyNonProfitMatchRelationship.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['locations'] as List<dynamic>?)
          ?.map((e) => CompanyStore.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['nonprofits'] as List<dynamic>?)
          ?.map((e) => CompanyNonProfit.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['contributors'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForProfitCompanyToJson(ForProfitCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'year_started': instance.yearStarted,
      'mission': instance.mission,
      'website_address': instance.websiteAddress,
      'slug': instance.slug,
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
      'nonprofits': instance.nonprofits?.map((e) => e.toJson()).toList(),
      'atrocities': instance.atrocities?.map((e) => e.toJson()).toList(),
      'owner': instance.owner?.toJson(),
      'contributors': instance.contributors?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'headquarters': instance.headquarters,
      'locations': instance.locations?.map((e) => e.toJson()).toList(),
      'image': instance.image,
      'links': instance.links?.map((e) => e.toJson()).toList(),
      'totalDonated': instance.totalDonated,
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
      'atrocityRelationships':
          instance.atrocityMatchRelationships?.map((e) => e.toJson()).toList(),
      'nonprofitRelationships':
          instance.nonprofitMatchRelationships?.map((e) => e.toJson()).toList(),
      'totalDonationCount': instance.totalDonationCount,
      'donationsMade': instance.donationsMade?.toJson(),
    };
