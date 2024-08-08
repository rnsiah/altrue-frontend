import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_code.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_point_promotion.dart';
part 'altrue_action_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AltrueAction {
  @JsonKey(name: 'requirement')
  String? name;
  @JsonKey(name: 'points_awarded')
  int? pointsAwarded;
  @JsonKey(name: 'is_promoted')
  bool isPromoted;
  AltruePointPromotion? promotion;
  @JsonKey(name: 'action_code')
  AltrueActionCode? actionCode;
  @JsonKey(name: 'info')
  String? info;

  AltrueAction(
      {required this.name,
      required this.pointsAwarded,
      required this.isPromoted});

  factory AltrueAction.fromJson(Map<String, dynamic> data) =>
      _$AltrueActionFromJson(data);

  Map<String, dynamic> toJson() => _$AltrueActionToJson(this);
}
