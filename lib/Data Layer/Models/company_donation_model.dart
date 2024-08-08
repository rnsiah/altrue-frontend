import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_donation_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import 'company_representation_model.dart';

part 'company_donation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyDonation {
  final CompanyRep company;
  final int id;
  final String amount;
  final Atrocity? atrocity;
  final NonProfit? nonprofit;
  final NonProfitProjectRep? project;
  @JsonKey(name: 'donation_date')
  final String donationDate;

  CompanyDonation(
      {required this.amount,
      required this.id,
      required this.atrocity,
      required this.company,
      required this.donationDate,
      required this.nonprofit,
      required this.project});

  factory CompanyDonation.fromJson(Map<String, dynamic> data) =>
      _$CompanyDonationFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyDonationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyMatchDonation {
  ProfileRepresentation user;
  int id;
  AtrocityRep? atrocity;
  NonProfitRep? nonprofit;
  NonProfitProjectRep? project;
  String amount;
  @JsonKey(name: 'transaction_matched')
  UserDonation? transactionMatched;

  CompanyMatchDonation(
      {required this.amount,
      required this.transactionMatched,
      required this.id,
      required this.atrocity,
      required this.nonprofit,
      required this.project,
      required this.user});

  factory CompanyMatchDonation.fromJson(Map<String, dynamic> data) =>
      _$CompanyMatchDonationFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyMatchDonationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllCompanyDonations {
  List<CompanyDonation>? donations;
  List<CompanyMatchDonation>? matched;

  AllCompanyDonations({required this.donations, required this.matched});

  factory AllCompanyDonations.fromJson(Map<String, dynamic> data) =>
      _$AllCompanyDonationsFromJson(data);

  Map<String, dynamic> toJson() => _$AllCompanyDonationsToJson(this);
}
