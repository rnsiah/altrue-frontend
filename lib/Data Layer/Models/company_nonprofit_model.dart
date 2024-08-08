import 'package:json_annotation/json_annotation.dart';
part 'company_nonprofit_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyNonProfit {
  final int id;
  final String name;
  final String logo;

  CompanyNonProfit({required this.id, required this.logo, required this.name});

  factory CompanyNonProfit.fromJson(Map<String, dynamic> data) =>
      _$CompanyNonProfitFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyNonProfitToJson(this);
}
