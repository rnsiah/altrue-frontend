import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';

part 'user_donation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserDonation {
  final int? id;
  @JsonKey(name: 'dollar_amount')
  final String dollarAmount;
  UserDonationAtrocity? atrocity;

  UserDonationNonProfit? nonprofit;
  NonProfitProject? project;

  UserDonation(
      {required this.dollarAmount,
      this.id,
      this.nonprofit,
      this.atrocity,
      this.project});

  factory UserDonation.fromJson(Map<String, dynamic> data) =>
      _$UserDonationFromJson(data);

  Map<String, dynamic> toJson() => _$UserDonationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserDonationAtrocity {
  int id;
  List<Category> category;
  String title;

  UserDonationAtrocity(
      {required this.id, required this.title, required this.category});

  factory UserDonationAtrocity.fromJson(Map<String, dynamic> data) =>
      _$UserDonationAtrocityFromJson(data);

  Map<String, dynamic> toJson() => _$UserDonationAtrocityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserDonationNonProfit {
  String? name;
  int? id;
  String? logo;

  UserDonationNonProfit(
      {required this.id, required this.logo, required this.name});

  factory UserDonationNonProfit.fromJson(Map<String, dynamic> data) =>
      _$UserDonationNonProfitFromJson(data);

  Map<String, dynamic> toJson() => _$UserDonationNonProfitToJson(this);
}
