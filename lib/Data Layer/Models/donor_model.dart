import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';

part 'donor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Donor {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  @JsonKey(name: 'amount_donated')
  final String amountDonated;

  @JsonKey(name: 'donation_category')
  Category? altruCategory;
  @JsonKey(name: 'stripe_charge_id')
  String stripeChargeId;

  Donor(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.amountDonated,
      required this.stripeChargeId,
      required this.altruCategory});

  factory Donor.fromJson(Map<String, dynamic> data) => _$DonorFromJson(data);

  Map<String, dynamic> toJson() => _$DonorToJson(this);
}
