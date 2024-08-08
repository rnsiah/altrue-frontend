// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_donation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDonation _$CompanyDonationFromJson(Map<String, dynamic> json) =>
    CompanyDonation(
      amount: json['amount'] as String,
      id: (json['id'] as num).toInt(),
      atrocity: json['atrocity'] == null
          ? null
          : Atrocity.fromJson(json['atrocity'] as Map<String, dynamic>),
      company: CompanyRep.fromJson(json['company'] as Map<String, dynamic>),
      donationDate: json['donation_date'] as String,
      nonprofit: json['nonprofit'] == null
          ? null
          : NonProfit.fromJson(json['nonprofit'] as Map<String, dynamic>),
      project: json['project'] == null
          ? null
          : NonProfitProjectRep.fromJson(
              json['project'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyDonationToJson(CompanyDonation instance) =>
    <String, dynamic>{
      'company': instance.company.toJson(),
      'id': instance.id,
      'amount': instance.amount,
      'atrocity': instance.atrocity?.toJson(),
      'nonprofit': instance.nonprofit?.toJson(),
      'project': instance.project?.toJson(),
      'donation_date': instance.donationDate,
    };

CompanyMatchDonation _$CompanyMatchDonationFromJson(
        Map<String, dynamic> json) =>
    CompanyMatchDonation(
      amount: json['amount'] as String,
      transactionMatched: json['transaction_matched'] == null
          ? null
          : UserDonation.fromJson(
              json['transaction_matched'] as Map<String, dynamic>),
      id: (json['id'] as num).toInt(),
      atrocity: json['atrocity'] == null
          ? null
          : AtrocityRep.fromJson(json['atrocity'] as Map<String, dynamic>),
      nonprofit: json['nonprofit'] == null
          ? null
          : NonProfitRep.fromJson(json['nonprofit'] as Map<String, dynamic>),
      project: json['project'] == null
          ? null
          : NonProfitProjectRep.fromJson(
              json['project'] as Map<String, dynamic>),
      user:
          ProfileRepresentation.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyMatchDonationToJson(
        CompanyMatchDonation instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'id': instance.id,
      'atrocity': instance.atrocity?.toJson(),
      'nonprofit': instance.nonprofit?.toJson(),
      'project': instance.project?.toJson(),
      'amount': instance.amount,
      'transaction_matched': instance.transactionMatched?.toJson(),
    };

AllCompanyDonations _$AllCompanyDonationsFromJson(Map<String, dynamic> json) =>
    AllCompanyDonations(
      donations: (json['donations'] as List<dynamic>?)
          ?.map((e) => CompanyDonation.fromJson(e as Map<String, dynamic>))
          .toList(),
      matched: (json['matched'] as List<dynamic>?)
          ?.map((e) => CompanyMatchDonation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCompanyDonationsToJson(
        AllCompanyDonations instance) =>
    <String, dynamic>{
      'donations': instance.donations?.map((e) => e.toJson()).toList(),
      'matched': instance.matched?.map((e) => e.toJson()).toList(),
    };
