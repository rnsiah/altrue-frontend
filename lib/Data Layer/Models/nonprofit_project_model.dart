import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

part 'nonprofit_project_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NonProfitProject {
  final int? id;
  final String? information;
  final String title;
  final List<ProfileRepresentation>? supporters;
  final List<ProfileRepresentation>? followers;
  final NonProfitRep? nonprofit;
  final Category? cause;
  final Atrocity? atrocity;
  final double? currentFunds;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'fundraising_goal')
  String? fundraisingGoal;
  final bool? featured;
  @JsonKey(name:'project_image')
  final String? projectImage;
  @JsonKey(name:'no_of_ratings')
  final int? noOfRatings;
  @JsonKey(name:'average_rating')
  final double? averageRating;
  final String? supplies;

  NonProfitProject(
      {this.id,
      this.supplies,
      this.featured,
      this.averageRating,
      this.noOfRatings,
      this.projectImage,
      this.currentFunds,
      this.isActive,
      this.information,
      this.atrocity,
      this.cause,
      this.followers,
      this.fundraisingGoal,
      this.nonprofit,
      this.supporters,
      required this.title});

  factory NonProfitProject.fromJson(Map<String, dynamic> data) =>
      _$NonProfitProjectFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitProjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NonProfitProjectCreation {
  final String title;
  final String information;
  final int? atrocity;
  final int? category;
  final int fundraisingGoal;
  final int nonprofit;
  final String? supplies;

  NonProfitProjectCreation(
      {required this.atrocity,
      required this.category,
      required this.supplies,
      required this.fundraisingGoal,
      required this.information,
      required this.nonprofit,
      required this.title});


  factory NonProfitProjectCreation.fromJson(Map<String, dynamic>data)=>
  _$NonProfitProjectCreationFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitProjectCreationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NonProfitProjectRep {
  int id;
  String title;
  String? projectImage;
  NonProfitRep? nonprofit;
  

  NonProfitProjectRep({required this.id, required this.title, this.projectImage,  this.nonprofit});

  factory NonProfitProjectRep.fromJson(Map<String, dynamic> data) =>
      _$NonProfitProjectRepFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitProjectRepToJson(this);
}
