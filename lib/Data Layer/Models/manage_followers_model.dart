import 'package:json_annotation/json_annotation.dart';

part 'manage_followers_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ManageFollower {
  final int id;
  @JsonKey(name: 'following')
  String follow;

  ManageFollower({required this.id, required this.follow});

  factory ManageFollower.fromJson(Map<String, dynamic> data) =>
      _$ManageFollowerFromJson(data);

  Map<String, dynamic> toJson() => _$ManageFollowerToJson(this);

  @override
  String toString() {
    return ('id:$id, following: $follow');
  }
}
