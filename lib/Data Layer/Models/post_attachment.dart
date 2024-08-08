import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
part 'post_attachment.g.dart';


@JsonSerializable(explicitToJson:true)
class PostAttachment{
  String image;
  ProfileRepresentation created_by;

  PostAttachment({required this.created_by, required this.image});
  
  factory PostAttachment.fromJson(Map<String,dynamic>data) => _$PostAttachmentFromJson(data);

  Map<String, dynamic>toJson()=>_$PostAttachmentToJson(this);
}