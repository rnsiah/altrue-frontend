// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationData _$DonationDataFromJson(Map<String, dynamic> json) => DonationData(
      amount: (json['amount'] as num).toInt(),
      id: json['id'] as String,
      donationType: json['donation_type'] as String,
    );

Map<String, dynamic> _$DonationDataToJson(DonationData instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'id': instance.id,
      'donation_type': instance.donationType,
    };
