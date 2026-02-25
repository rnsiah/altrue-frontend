import 'package:json_annotation/json_annotation.dart';

import 'company_atrocity_model.dart';

part 'company_atrocity_matching_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyAtrocityMatchRelationShip {
  @JsonKey(name: 'match_level')
  final int matchLevel;
  @JsonKey(name: 'match')
  final int? match;
  @JsonKey(name: 'total_raised')
  final double totalRaised;
  final CompanyAtrocity atrocity;
  @JsonKey(name: 'funding_limit')
  final double fundingLimit;

  CompanyAtrocityMatchRelationShip(
      {required this.atrocity,
      this.match,
      required this.fundingLimit,
      required this.matchLevel,
      required this.totalRaised});

  factory CompanyAtrocityMatchRelationShip.fromJson(
          Map<String, dynamic> data) =>
      _$CompanyAtrocityMatchRelationShipFromJson(data);

  Map<String, dynamic> toJson() =>
      _$CompanyAtrocityMatchRelationShipToJson(this);
}
