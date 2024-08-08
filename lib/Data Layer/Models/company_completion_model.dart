import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
part 'company_completion_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyCompletion {
  @JsonKey(name: 'name')
  final String companyName;
  @JsonKey(name: 'owner')
  final Profile profile;
  @JsonKey(name: 'mission')
  final String? missionStatement;
  @JsonKey(name: 'address')
  final String companyAddress;
  final String description;
  final String? facebook;
  final String? logo;
  final int userId;
  final String? instagram;
  final String mainImage;
  @JsonKey(name: 'website_address')
  final String? wehsite;
  @JsonKey(name: 'year_started')
  final String yearStarted;
  final List<Category>? categories;

  CompanyCompletion(
      {required this.companyAddress,
      required this.companyName,
      required this.description,
      this.facebook,
      this.instagram,
      this.missionStatement,
      required this.profile,
      this.wehsite,
      required this.yearStarted,
      this.logo,
      required this.userId,
      this.categories,
      required this.mainImage});

  factory CompanyCompletion.fromJson(Map<String, dynamic> data) =>
      _$CompanyCompletionFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyCompletionToJson(this);
}
