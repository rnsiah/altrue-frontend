import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';
import 'country_model.dart';

part 'company_atrocity_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyAtrocity {
  final int id;
  final String title;
  final List<Category> category;
  final Country country;

  CompanyAtrocity({
    required this.id,
    required this.title,
    required this.category,
    required this.country,
  });

  factory CompanyAtrocity.fromJson(Map<String, dynamic> data) =>
      _$CompanyAtrocityFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyAtrocityToJson(this);
}
