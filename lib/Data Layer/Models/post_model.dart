import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/post_attachment.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson:true)
class Post{
  String id;
  String created_at;
  ProfileRepresentation created_by;
  String body;
  List<PostAttachment>? attachements;

  Post({required this.id, required this.created_at,  this.attachements, required this.body, required this.created_by});

  factory Post.fromJson(Map<String,dynamic>data) =>_$PostFromJson(data);

  Map<String, dynamic>toJson()=>_$PostToJson(this);

}
