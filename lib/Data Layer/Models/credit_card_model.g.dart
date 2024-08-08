// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardDetails _$CreditCardDetailsFromJson(Map<String, dynamic> json) =>
    CreditCardDetails(
      brand: json['brand'] as String,
      expMonth: (json['exp_month'] as num).toInt(),
      expYear: (json['exp_year'] as num).toInt(),
      last4: json['last4'] as String,
      name: json['card_holder_name'] as String,
    );

Map<String, dynamic> _$CreditCardDetailsToJson(CreditCardDetails instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'exp_year': instance.expYear,
      'exp_month': instance.expMonth,
      'last4': instance.last4,
      'card_holder_name': instance.name,
    };
