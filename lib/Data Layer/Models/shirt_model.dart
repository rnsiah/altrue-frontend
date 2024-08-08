import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_level_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/country_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_size_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_variation_model.dart';

part 'shirt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Shirt {
  Shirt(
      {this.id,
      this.variations,
      this.quantityLimited,
      this.pointsNeededToPurchase,
      this.totalQuanity,
      this.name,
      this.productUniqueId,
      this.price,
      this.country,
      this.shirtImage,
      this.slug,
      this.availableColors,
      this.shirtSizes,
      this.atrocity,
      this.originalImage,
      this.category,
      this.altrueInfo,
      this.otherShirts,
      this.shirtMaterials,
      this.averageRating,
      this.shirtStyle,
      this.noOfRatings,
      this.requiredLevel,
      this.shirtBackImage});

  final int? id;
  @JsonKey(name: 'points_needed_to_purchase')
  final int? pointsNeededToPurchase;
  final String? name;
  @JsonKey(name: 'shirt_back_image')
  final String? shirtBackImage;
  @JsonKey(name: 'no_of_ratings')
  int? noOfRatings;
  @JsonKey(name: 'average_rating')
  double? averageRating;
  double? price;
  @JsonKey(name: 'shirt_style')
  String? shirtStyle;
  @JsonKey(name: 'shirt_materials')
  String? shirtMaterials;
  @JsonKey(name: 'quantity_limited')
  bool? quantityLimited;
  @JsonKey(name: 'total_quantity')
  int? totalQuanity;
  Country? country;
  @JsonKey(name: 'shirt_image')
  String? shirtImage;
  @JsonKey(name: 'atrocityList')
  List<Atrocity>? atrocity;
  String? slug;
  @JsonKey(name: 'original_image')
  String? originalImage;
  Category? category;
  @JsonKey(name: 'altrue_story', required: false)
  String? altrueInfo;
  @JsonKey(name: 'similar_shirts')
  List<Shirt>? otherShirts;
  @JsonKey(name: 'available_colors')
  List<ShirtColor>? availableColors;
  @JsonKey(name: 'available_sizes')
  List<ShirtSize>? shirtSizes;
  List<ShirtVariation>? variations;
  @JsonKey(name: 'required_level')
  AltrueLevel? requiredLevel;
  @JsonKey(name: 'product_unique_id')
  String? productUniqueId;

  factory Shirt.fromJson(Map<String, dynamic> data) => _$ShirtFromJson(data);

  Map<String, dynamic> toJson() => _$ShirtToJson(this);

  String getShirt() {
    if (atrocity != null && atrocity!.length > 1) {
      for (Atrocity atro in atrocity!) {
        return atro.title.toString();
      }
    }
    return 'nthing';
  }

  shirtRepresentation(Shirt shirt) {
    return shirt.name;
  }
}
