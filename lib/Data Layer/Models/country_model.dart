import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  Country({
    required this.id,
    required this.name,
    required this.flag,
  });

  int id;
  String name;
  String flag;

  factory Country.fromJson(Map<String, dynamic> data) =>
      _$CountryFromJson(data);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
