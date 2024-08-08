import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
part 'shirt_group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ShirtGroup {
  String? name;
  String? groupImage;
  String? description;
  String? creator;
  List<Shirt>? shirts;

  ShirtGroup(
      {required this.name,
      required this.creator,
      required this.description,
      required this.groupImage,
      this.shirts});

  factory ShirtGroup.fromJson(Map<String, dynamic> data) =>
      _$ShirtGroupFromJson(data);

  Map<String, dynamic> toJson() => _$ShirtGroupToJson(this);
}
