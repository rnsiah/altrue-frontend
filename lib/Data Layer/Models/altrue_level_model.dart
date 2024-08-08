import 'package:json_annotation/json_annotation.dart';

part 'altrue_level_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AltrueLevel {
  String name;
  @JsonKey(name: 'minimum_points')
  int minimumPoints;
  @JsonKey(name: 'maximum_points')
  int maximumPoints;
  @JsonKey(name: 'level_number')
  int levelNumber;

  AltrueLevel(
      {required this.name,
      required this.levelNumber,
      required this.maximumPoints,
      required this.minimumPoints});

  factory AltrueLevel.fromJson(Map<String, dynamic> data) =>
      _$AltrueLevelFromJson(data);

  Map<String, dynamic> toJson() => _$AltrueLevelToJson(this);
}
