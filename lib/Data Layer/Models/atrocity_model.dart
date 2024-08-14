import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/link_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import 'category_model.dart';
import 'country_model.dart';


part 'atrocity_model.g.dart';
@JsonSerializable(explicitToJson: true)
class Atrocity {
  Atrocity({
    this.id,
    required this.title,
    this.region,
    this.recentDonors,
    this.info,
    this.imageUrl,
    this.category,
    this.country,
    this.slug,
    this.videoURL,
    this.balance,
    this.shirtList,
    this.nonprofitList,
    this.noOfDonations,
    this.quizes
  });

  String title;
  int? noOfDonations;
  String? region;
  String? info;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  List<Category>? category;
  Country? country;
  @JsonKey(includeIfNull: true)
  String? slug;
  String? videoURL;
  int? id;
  @JsonKey(name: 'total_balance')
  double? balance;
  @JsonKey(name: 'atrocity_shirt_list')
  List<Shirt>? shirtList;
  @JsonKey(name: 'np_list')
  List<NonProfit>? nonprofitList;
  List<Link>? links;
  List<ProfileRepresentation>? recentDonors;
  List<Quiz>? quizes;

  factory Atrocity.fromJson(Map<String, dynamic> data) =>
      _$AtrocityFromJson(data);

  Map<String, dynamic> toJson() => _$AtrocityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AtrocityRep {
  int id;
  String title;

  AtrocityRep({required this.id, required this.title});

  factory AtrocityRep.fromJson(Map<String, dynamic> data) =>
      _$AtrocityRepFromJson(data);

  Map<String, dynamic> toJson() => _$AtrocityRepToJson(this);
}
// class _Converter<T> implements JsonConverter<T, Object>{
//   const _Converter();


//   @override
//   T fromJson(Object? json) {
//      if (json is Map<dynamic, String> && json.containsKey('key'))
//       throw UnimplementedError();
//     }
  
//     @override
//     Object toJson(T object) {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }}

