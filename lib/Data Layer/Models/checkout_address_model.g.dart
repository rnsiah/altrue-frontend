// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutAddress _$CheckoutAddressFromJson(Map<String, dynamic> json) =>
    CheckoutAddress(
      user: Profile.fromJson(json['user'] as Map<String, dynamic>),
      country: json['country'] as String,
      zip: json['zip'] as String,
      streetAddress: json['streetAddress'] as String,
    )
      ..apartmentNumber = json['apartment_address'] as String?
      ..specialDirections = json['special_directions'] as String?;

Map<String, dynamic> _$CheckoutAddressToJson(CheckoutAddress instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'streetAddress': instance.streetAddress,
      'apartment_address': instance.apartmentNumber,
      'country': instance.country,
      'zip': instance.zip,
      'special_directions': instance.specialDirections,
    };
