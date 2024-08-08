import 'package:json_annotation/json_annotation.dart';
part 'credit_card_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditCardDetails {
  final String brand;
  @JsonKey(name: 'exp_year')
  final int expYear;
  @JsonKey(name:'exp_month')
  final int expMonth;
  final String last4;
  @JsonKey(name:'card_holder_name')
  final String name;

  CreditCardDetails(
      {required this.brand,
      required this.expMonth,
      required this.expYear,
      required this.last4,
      required this.name});

  factory CreditCardDetails.fromJson(Map<String, dynamic> data) =>
      _$CreditCardDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$CreditCardDetailsToJson(this);

  String  get getCombinedExpiration => '${expMonth.toString().padLeft(2, '0')}${expYear.toString().substring(2)}';
}
