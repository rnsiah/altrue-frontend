import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_atrocity_matching_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_coupon_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_donation_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_location_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_nonprofit_matching_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_nonprofit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/link_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import 'company_atrocity_model.dart';

part 'company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ForProfitCompany {
  int id;
  String name;
  String? logo;

  @JsonKey(name: 'year_started', disallowNullValue: false)
  String yearStarted;
  String? mission;
  @JsonKey(name: 'website_address')
  String websiteAddress;
  String slug;
  List<Category>? categories;
  List<CompanyNonProfit>? nonprofits;
  List<CompanyAtrocity>? atrocities;
  Profile? owner;
  List<Profile>? contributors;
  String? description;
  String? headquarters;
  List<CompanyStore>? locations;
  String? image;
  List<Link>? links;
  double? totalDonated;
  List<CompanyCoupon>? coupons;
  @JsonKey(name: 'atrocityRelationships')
  List<CompanyAtrocityMatchRelationShip>? atrocityMatchRelationships;
  @JsonKey(name: 'nonprofitRelationships')
  List<CompanyNonProfitMatchRelationship>? nonprofitMatchRelationships;
  int? totalDonationCount;
  AllCompanyDonations? donationsMade;
  ForProfitCompany(
      this.image,
      this.totalDonationCount,
      this.links,
      this.id,
      this.logo,
      this.donationsMade,
      this.mission,
      this.yearStarted,
      this.name,
      this.description,
      this.headquarters,
      this.owner,
      this.totalDonated,
      this.slug,
      this.websiteAddress,
      this.coupons,
      [this.atrocities,
      this.atrocityMatchRelationships,
      this.nonprofitMatchRelationships,
      this.categories,
      this.locations,
      this.nonprofits,
      this.contributors]);

  factory ForProfitCompany.fromJson(Map<String, dynamic> data) =>
      _$ForProfitCompanyFromJson(data);

  Map<String, dynamic> toJson() => _$ForProfitCompanyToJson(this);
}
