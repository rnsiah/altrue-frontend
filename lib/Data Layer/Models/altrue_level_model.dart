import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';

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
  List<AltrueAction>? requiredActions;

  AltrueLevel(
      {required this.name,
      required this.levelNumber,
      required this.maximumPoints,
      required this.minimumPoints,
       this.requiredActions});

  factory AltrueLevel.fromJson(Map<String, dynamic> data) =>
      _$AltrueLevelFromJson(data);

  Map<String, dynamic> toJson() => _$AltrueLevelToJson(this);
}
