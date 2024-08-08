import 'package:json_annotation/json_annotation.dart';
part 'altrue_action_code.g.dart';

@JsonSerializable()
class AltrueActionCode {
  final String code;
  final int id;

  AltrueActionCode({required this.code, required this.id});

  factory AltrueActionCode.fromJson(Map<String, dynamic> data) =>
      _$AltrueActionCodeFromJson(data);

  Map<String, dynamic> toJson() => _$AltrueActionCodeToJson(this);
}
