import 'package:json_annotation/json_annotation.dart';
part 'altrue_point_promotion.g.dart';

@JsonSerializable()
class AltruePointPromotion {
  final int? multiplier;
  final String name;
  final String description;
  @JsonKey(name: 'donation_increase')
  final int? donationIncrease;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;

  AltruePointPromotion(
      {required this.description,
      required this.name,
      required this.isActive,
      this.donationIncrease,
      this.endDate,
      this.multiplier,
      this.startDate});

  factory AltruePointPromotion.fromJson(Map<String, dynamic> data) =>
      _$AltruePointPromotionFromJson(data);

  Map<String, dynamic> toJson() => _$AltruePointPromotionToJson(this);
}
