import 'package:json_annotation/json_annotation.dart';
part 'company_representation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyRep {
  String logo;
  int id;
  String name;

  CompanyRep({required this.id, required this.logo, required this.name});

  factory CompanyRep.fromJson(Map<String, dynamic> data) =>
      _$CompanyRepFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyRepToJson(this);
}
