import 'package:json_annotation/json_annotation.dart';

part 'company_location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyStore {
  @JsonKey(name: 'street_address')
  String? streetAddress;
  String? zip;
  String? country;
  String? state;

  CompanyStore(this.streetAddress, this.zip, this.country, this.state);

  factory CompanyStore.fromJson(Map<String, dynamic> data) =>
      _$CompanyStoreFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyStoreToJson(this);
}
