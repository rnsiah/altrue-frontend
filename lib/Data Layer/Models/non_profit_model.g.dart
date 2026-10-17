// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'non_profit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonProfit _$NonProfitFromJson(Map<String, dynamic> json) =>
    NonProfit(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String,
        logo: json['logo'] as String,
        description: json['description'] as String?,
        facebook: json['facebook'] as String?,
        yearStarted: (json['year_started'] as num?)?.toInt(),
        missionStatement: json['mission_statement'] as String?,
        video: json['video'] as String?,
        projects: (json['projects'] as List<dynamic>?)
            ?.map((e) => NonProfitProject.fromJson(e as Map<String, dynamic>))
            .toList(),
        visionStatement: json['vision_statement'] as String?,
        websiteUrl: json['website_url'] as String?,
        category: (json['category'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        slug: json['slug'] as String?,
        atrocity: (json['atrocity_List'] as List<dynamic>?)
            ?.map((e) => Atrocity.fromJson(e as Map<String, dynamic>))
            .toList(),
        shirtList: (json['shirtList'] as List<dynamic>?)
            ?.map((e) => Shirt.fromJson(e as Map<String, dynamic>))
            .toList(),
        avgDonation: (json['avgDonation'] as num?)?.toDouble(),
        mainImage: json['main_image'] as String?,
        balance: (json['total_balance'] as num?)?.toDouble(),
        companiesSupporting: (json['companiesSupporting'] as List<dynamic>?)
            ?.map(
              (e) => CompaniesSupporting.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        contributors: (json['contributors'] as List<dynamic>?)
            ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
            .toList(),
        owner: json['owner'] == null
            ? null
            : Profile.fromJson(json['owner'] as Map<String, dynamic>),
        matchingPartnerships: (json['matchingPartnerships'] as List<dynamic>?)
            ?.map(
              (e) => CompanyNonProfitMatchRelationship.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
        links: (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
        averageRating: (json['average_rating'] as num?)?.toDouble(),
        noOfRatings: (json['no_of_ratings'] as num?)?.toInt(),
      )
      ..recentDonors = (json['recentDonors'] as List<dynamic>?)
          ?.map(
            (e) => ProfileRepresentation.fromJson(e as Map<String, dynamic>),
          )
          .toList();

Map<String, dynamic> _$NonProfitToJson(NonProfit instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logo': instance.logo,
  'video': instance.video,
  'description': instance.description,
  'year_started': instance.yearStarted,
  'mission_statement': instance.missionStatement,
  'vision_statement': instance.visionStatement,
  'website_url': instance.websiteUrl,
  'category': instance.category?.map((e) => e.toJson()).toList(),
  'slug': instance.slug,
  'atrocity_List': instance.atrocity?.map((e) => e.toJson()).toList(),
  'shirtList': instance.shirtList?.map((e) => e.toJson()).toList(),
  'main_image': instance.mainImage,
  'total_balance': instance.balance,
  'companiesSupporting': instance.companiesSupporting
      ?.map((e) => e.toJson())
      .toList(),
  'contributors': instance.contributors?.map((e) => e.toJson()).toList(),
  'owner': instance.owner?.toJson(),
  'links': instance.links?.map((e) => e.toJson()).toList(),
  'projects': instance.projects?.map((e) => e.toJson()).toList(),
  'avgDonation': instance.avgDonation,
  'recentDonors': instance.recentDonors?.map((e) => e.toJson()).toList(),
  'matchingPartnerships': instance.matchingPartnerships
      ?.map((e) => e.toJson())
      .toList(),
  'facebook': instance.facebook,
  'no_of_ratings': instance.noOfRatings,
  'average_rating': instance.averageRating,
};

NonProfitCompletion _$NonProfitCompletionFromJson(Map<String, dynamic> json) =>
    NonProfitCompletion(
      website: json['website_url'] as String?,
      instagram: json['instagram'] as String?,
      video: json['video'] as String?,
      profile: Profile.fromJson(json['owner'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String,
      facebook: json['facebook'] as String?,
      missionStatement: json['mission_statement'] as String,
      visionStatement: json['vision_statement'] as String,
      yearStarted: (json['year_started'] as num).toInt(),
    );

Map<String, dynamic> _$NonProfitCompletionToJson(
  NonProfitCompletion instance,
) => <String, dynamic>{
  'owner': instance.profile.toJson(),
  'year_started': instance.yearStarted,
  'name': instance.name,
  'mission_statement': instance.missionStatement,
  'vision_statement': instance.visionStatement,
  'facebook': instance.facebook,
  'website_url': instance.website,
  'instagram': instance.instagram,
  'description': instance.description,
  'video': instance.video,
};

NonProfitRep _$NonProfitRepFromJson(Map<String, dynamic> json) => NonProfitRep(
  id: (json['id'] as num).toInt(),
  logo: json['logo'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$NonProfitRepToJson(NonProfitRep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
