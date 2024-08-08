// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCoupon _$CompanyCouponFromJson(Map<String, dynamic> json) =>
    CompanyCoupon(
      json['coupon_image'] as String?,
      json['name'] as String,
      json['coupon_code'] as String?,
      json['expiration_date'] as String?,
      json['description'] as String?,
      json['slug'] as String?,
      json['locations'] == null
          ? null
          : CompanyStore.fromJson(json['locations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyCouponToJson(CompanyCoupon instance) =>
    <String, dynamic>{
      'name': instance.name,
      'locations': instance.locations?.toJson(),
      'coupon_code': instance.couponCode,
      'expiration_date': instance.expirationDate,
      'description': instance.description,
      'coupon_image': instance.couponImage,
      'slug': instance.slug,
    };
