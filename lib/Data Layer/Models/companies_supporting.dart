import 'package:json_annotation/json_annotation.dart';

part 'companies_supporting.g.dart';

@JsonSerializable(explicitToJson: true)
class CompaniesSupporting {
  final String companyName;
  final String companyLogo;

  CompaniesSupporting(this.companyName, this.companyLogo);

  factory CompaniesSupporting.fromJson(Map<String, dynamic> data) =>
      _$CompaniesSupportingFromJson(data);

  Map<String, dynamic> toJson() => _$CompaniesSupportingToJson(this);
}
