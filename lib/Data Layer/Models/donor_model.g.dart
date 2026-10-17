// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Donor _$DonorFromJson(Map<String, dynamic> json) => Donor(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  email: json['email'] as String,
  amountDonated: json['amount_donated'] as String,
  stripeChargeId: json['stripe_charge_id'] as String,
  altruCategory: json['donation_category'] == null
      ? null
      : Category.fromJson(json['donation_category'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DonorToJson(Donor instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'amount_donated': instance.amountDonated,
  'donation_category': instance.altruCategory?.toJson(),
  'stripe_charge_id': instance.stripeChargeId,
};
