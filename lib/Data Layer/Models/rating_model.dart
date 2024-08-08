
import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';


part 'rating_model.g.dart';

@JsonSerializable()
class Rating{
  int? shirt;
  int? nonprofit;
  int? project;
  int? company;
  Profile user;
  int stars;


  Rating({required this.user, required this.stars, this.company, this.nonprofit, this.project, this.shirt});


  factory Rating.fromJson(Map<String, dynamic> data)=> _$RatingFromJson(data);

  Map<String, dynamic> toJson()=> _$RatingToJson(this);
  
}