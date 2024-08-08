// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_donation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDonation _$UserDonationFromJson(Map<String, dynamic> json) => UserDonation(
      dollarAmount: json['dollar_amount'] as String,
      id: (json['id'] as num?)?.toInt(),
      nonprofit: json['nonprofit'] == null
          ? null
          : UserDonationNonProfit.fromJson(
              json['nonprofit'] as Map<String, dynamic>),
      atrocity: json['atrocity'] == null
          ? null
          : UserDonationAtrocity.fromJson(
              json['atrocity'] as Map<String, dynamic>),
      project: json['project'] == null
          ? null
          : NonProfitProject.fromJson(json['project'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDonationToJson(UserDonation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dollar_amount': instance.dollarAmount,
      'atrocity': instance.atrocity?.toJson(),
      'nonprofit': instance.nonprofit?.toJson(),
      'project': instance.project?.toJson(),
    };

UserDonationAtrocity _$UserDonationAtrocityFromJson(
        Map<String, dynamic> json) =>
    UserDonationAtrocity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      category: (json['category'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDonationAtrocityToJson(
        UserDonationAtrocity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category.map((e) => e.toJson()).toList(),
      'title': instance.title,
    };

UserDonationNonProfit _$UserDonationNonProfitFromJson(
        Map<String, dynamic> json) =>
    UserDonationNonProfit(
      id: (json['id'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserDonationNonProfitToJson(
        UserDonationNonProfit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'logo': instance.logo,
    };
