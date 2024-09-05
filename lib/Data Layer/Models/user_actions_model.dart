import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';
part 'user_actions_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserActions {
  UserActions(this.isPromotion,this.altrueAction, this.dateCompleted, this.is_aggregate, this.aggregate_complete_date);

  @JsonKey(name:'altrue_action')
  final AltrueAction altrueAction;
  @JsonKey(name:'date_completed')
  final String dateCompleted;
  @JsonKey(name: 'is_promotion', includeIfNull: false)
  final bool? isPromotion;
  final bool? is_aggregate;
  final String? aggregate_complete_date;


factory UserActions.fromJson(Map<String, dynamic>data)=>
_$UserActionsFromJson(data);

Map<String,dynamic>toJson()=> _$UserActionsToJson(this);


}