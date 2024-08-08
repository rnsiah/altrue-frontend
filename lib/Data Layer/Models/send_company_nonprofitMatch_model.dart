import 'package:json_annotation/json_annotation.dart';

import 'company_model.dart';
import 'non_profit_model.dart';

part 'send_company_nonprofitMatch_model.g.dart';


@JsonSerializable(explicitToJson:true)
class SendCompanyNonProfitRelationShip{
  @JsonKey(name:'match_level')
  final int matchLevel;

  @JsonKey(name:'funding_limit')
  final double fundingLimit;
  final NonProfit nonprofit;
  final ForProfitCompany company;

  SendCompanyNonProfitRelationShip({required this.matchLevel, required this.fundingLimit, required this.company, required this.nonprofit});


  factory SendCompanyNonProfitRelationShip.fromJson(
    Map<String, dynamic> data)=>_$SendCompanyNonProfitRelationShipFromJson(data);

  Map<String,dynamic>toJson()=>_$SendCompanyNonProfitRelationShipToJson(this);
}