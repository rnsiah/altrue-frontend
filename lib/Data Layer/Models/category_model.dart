import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class   Category {
  Category({
    this.projects,
    this.projectCount,
    this.donationTotal,
    this.nonprofitCount,
    this.id,
    this.name,
    this.image,
    this.information,
    this.nonprofitList,
    this.blurb,
    // this.quizes
    
  });
  @JsonKey(name: 'nonprofit_count')
  int? nonprofitCount;
  double? donationTotal;
  @JsonKey(name: 'project_count')
  int? projectCount;
  List<NonProfitProject>? projects;
  int? id;
  @JsonKey(name: 'all_nonprofits')
  List<NonProfitRep>? nonprofitList;
  String? name;
  String? image;
  String? information;
  String? blurb;
  // List<int>? quizes;


  factory Category.fromJson(Map<String, dynamic> data) =>
      _$CategoryFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
