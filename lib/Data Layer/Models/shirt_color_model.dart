import 'package:json_annotation/json_annotation.dart';

part 'shirt_color_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ShirtColor {
  final int? id;
  final String color;
  final String hex;

  ShirtColor({required this.color, this.id, required this.hex});

  factory ShirtColor.fromJson(Map<String, dynamic> data) =>
      _$ShirtColorFromJson(data);

  Map<String, dynamic> toJson() => _$ShirtColorToJson(this);
}
