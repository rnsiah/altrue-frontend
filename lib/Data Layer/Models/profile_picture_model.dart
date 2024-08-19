import 'package:json_annotation/json_annotation.dart';

part 'profile_picture_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfilePicture {
  @JsonKey(name:'image_url')
  final String url;

  ProfilePicture({required this.url});

  factory ProfilePicture.fromJson(Map<String, dynamic> data) =>
      _$ProfilePictureFromJson(data);

  Map<String, dynamic> toJson() => _$ProfilePictureToJson(this);
}
