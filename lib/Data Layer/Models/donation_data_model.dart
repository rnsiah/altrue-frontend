import 'package:json_annotation/json_annotation.dart';
part 'donation_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DonationData {
  final int amount;
  final String id;
  @JsonKey(name: 'donation_type')
  final String donationType;

  DonationData({
    required this.amount,
    required this.id,
    required this.donationType,
  });

  factory DonationData.fromJson(Map<String, dynamic> data) =>
      _$DonationDataFromJson(data);

  Map<String, dynamic> toJson() => _$DonationDataToJson(this);
}
