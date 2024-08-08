// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_actions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActions _$UserActionsFromJson(Map<String, dynamic> json) => UserActions(
      json['is_promotion'] as bool?,
      AltrueAction.fromJson(json['altrue_action'] as Map<String, dynamic>),
      json['date_completed'] as String,
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
  return val;
}
