// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_company_nonprofitMatch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCompanyNonProfitRelationShip _$SendCompanyNonProfitRelationShipFromJson(
  Map<String, dynamic> json,
) => SendCompanyNonProfitRelationShip(
  matchLevel: (json['match_level'] as num).toInt(),
  fundingLimit: (json['funding_limit'] as num).toDouble(),
  company: ForProfitCompany.fromJson(json['company'] as Map<String, dynamic>),
  nonprofit: NonProfit.fromJson(json['nonprofit'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SendCompanyNonProfitRelationShipToJson(
  SendCompanyNonProfitRelationShip instance,
) => <String, dynamic>{
  'match_level': instance.matchLevel,
  'funding_limit': instance.fundingLimit,
  'nonprofit': instance.nonprofit.toJson(),
  'company': instance.company.toJson(),
};
