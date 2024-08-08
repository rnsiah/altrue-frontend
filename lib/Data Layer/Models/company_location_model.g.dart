// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyStore _$CompanyStoreFromJson(Map<String, dynamic> json) => CompanyStore(
      json['street_address'] as String?,
      json['zip'] as String?,
      json['country'] as String?,
      json['state'] as String?,
    );

Map<String, dynamic> _$CompanyStoreToJson(CompanyStore instance) =>
    <String, dynamic>{
      'street_address': instance.streetAddress,
      'zip': instance.zip,
      'country': instance.country,
      'state': instance.state,
    };
