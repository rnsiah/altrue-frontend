import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_location_model.dart';

part 'company_coupon_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyCoupon {
  String name;
  CompanyStore? locations;
  @JsonKey(name: 'coupon_code')
  String? couponCode;
  @JsonKey(name: 'expiration_date')
  String? expirationDate;
  String? description;
  @JsonKey(name: 'coupon_image')
  String? couponImage;
  String? slug;

  CompanyCoupon(this.couponImage, this.name, this.couponCode,
      this.expirationDate, this.description, this.slug,
      [this.locations]);

  factory CompanyCoupon.fromJson(Map<String, dynamic> data) =>
      _$CompanyCouponFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyCouponToJson(this);
}
