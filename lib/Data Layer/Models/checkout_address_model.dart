import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

part 'checkout_address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckoutAddress {
  Profile user;
  String streetAddress;
  @JsonKey(name: 'apartment_address')
  String? apartmentNumber;
  String country;
  String zip;
  @JsonKey(name: 'special_directions')
  String? specialDirections;

  CheckoutAddress(
      {required this.user,
      required this.country,
      required this.zip,
      required this.streetAddress});

  factory CheckoutAddress.fromJson(Map<String, dynamic> data) =>
      _$CheckoutAddressFromJson(data);

  Map<String, dynamic> toJson() => _$CheckoutAddressToJson(this);
}
