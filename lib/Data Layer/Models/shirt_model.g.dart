// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shirt _$ShirtFromJson(Map<String, dynamic> json) => Shirt(
      id: (json['id'] as num?)?.toInt(),
      variations: (json['variations'] as List<dynamic>?)
          ?.map((e) => ShirtVariation.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantityLimited: json['quantity_limited'] as bool?,
      pointsNeededToPurchase:
          (json['points_needed_to_purchase'] as num?)?.toInt(),
      totalQuanity: (json['total_quantity'] as num?)?.toInt(),
      name: json['name'] as String?,
      productUniqueId: json['product_unique_id'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      shirtImage: json['shirt_image'] as String?,
      slug: json['slug'] as String?,
      availableColors: (json['available_colors'] as List<dynamic>?)
          ?.map((e) => ShirtColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      shirtSizes: (json['available_sizes'] as List<dynamic>?)
          ?.map((e) => ShirtSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      atrocity: (json['atrocityList'] as List<dynamic>?)
          ?.map((e) => Atrocity.fromJson(e as Map<String, dynamic>))
          .toList(),
      originalImage: json['original_image'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      altrueInfo: json['altrue_story'] as String?,
      otherShirts: (json['similar_shirts'] as List<dynamic>?)
          ?.map((e) => Shirt.fromJson(e as Map<String, dynamic>))
          .toList(),
      shirtMaterials: json['shirt_materials'] as String?,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      shirtStyle: json['shirt_style'] as String?,
      noOfRatings: (json['no_of_ratings'] as num?)?.toInt(),
      requiredLevel: json['required_level'] == null
          ? null
          : AltrueLevel.fromJson(
              json['required_level'] as Map<String, dynamic>),
      shirtBackImage: json['shirt_back_image'] as String?,
    );

Map<String, dynamic> _$ShirtToJson(Shirt instance) => <String, dynamic>{
      'id': instance.id,
      'points_needed_to_purchase': instance.pointsNeededToPurchase,
      'name': instance.name,
      'shirt_back_image': instance.shirtBackImage,
      'no_of_ratings': instance.noOfRatings,
      'average_rating': instance.averageRating,
      'price': instance.price,
      'shirt_style': instance.shirtStyle,
      'shirt_materials': instance.shirtMaterials,
      'quantity_limited': instance.quantityLimited,
      'total_quantity': instance.totalQuanity,
      'country': instance.country?.toJson(),
      'shirt_image': instance.shirtImage,
      'atrocityList': instance.atrocity?.map((e) => e.toJson()).toList(),
      'slug': instance.slug,
      'original_image': instance.originalImage,
      'category': instance.category?.toJson(),
      'altrue_story': instance.altrueInfo,
      'similar_shirts': instance.otherShirts?.map((e) => e.toJson()).toList(),
      'available_colors':
          instance.availableColors?.map((e) => e.toJson()).toList(),
      'available_sizes': instance.shirtSizes?.map((e) => e.toJson()).toList(),
      'variations': instance.variations?.map((e) => e.toJson()).toList(),
      'required_level': instance.requiredLevel?.toJson(),
      'product_unique_id': instance.productUniqueId,
    };
