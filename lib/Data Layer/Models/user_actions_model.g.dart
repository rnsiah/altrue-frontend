// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_actions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActions _$UserActionsFromJson(Map<String, dynamic> json) => UserActions(
      json['is_promotion'] as bool?,
      AltrueAction.fromJson(json['altrue_action'] as Map<String, dynamic>),
      json['date_completed'] as String,
      json['is_aggregate'] as bool?,
      json['aggregate_complete_date'] as String?,
    );

Map<String, dynamic> _$UserActionsToJson(UserActions instance) {
  final val = <String, dynamic>{
    'altrue_action': instance.altrueAction.toJson(),
    'date_completed': instance.dateCompleted,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('is_promotion', instance.isPromotion);
  val['is_aggregate'] = instance.is_aggregate;
  val['aggregate_complete_date'] = instance.aggregate_complete_date;
  return val;
}
