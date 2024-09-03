import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_level_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/donor_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_actions_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_donation_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

import 'atrocity_model.dart';
import 'company_representation_model.dart';
import 'non_profit_model.dart';
import 'nonprofit_project_model.dart';
import 'order_model.dart';
import 'profile_picture_model.dart';
import 'shirt_model.dart';

part 'user_model.g.dart';

abstract class UUser {}

@JsonSerializable(explicitToJson: true)
class UserFromAPI {
  String url;
  String email;
  @JsonKey(includeIfNull: true, name: "first_name")
  String firstname;
  @JsonKey(name: "last_name")
  String lastName;
  @JsonKey(name: "username")
  String userName;
  int id;
  String profile;
  @JsonKey(name: "profile_created")
  bool profileCreated;

  UserFromAPI(
      {required this.email,
      required this.url,
      required this.firstname,
      required this.id,
      required this.lastName,
      required this.profile,
      required this.profileCreated,
      required this.userName});

  factory UserFromAPI.fromJson(Map<String, dynamic> data) =>
      _$UserFromAPIFromJson(data);

  Map<String, dynamic> toJson() => _$UserFromAPIToJson(this);
}

// http://10.0.0.238:8000/media/profiles/IMG_1851.jpg
// http://10.0.0.238:8000/media/qr_codes/qr-rnsiah_3ddguw0.png

@JsonSerializable(explicitToJson: true)
class User extends UUser {
  int id;
  String? email;
  String? key;
  int? altid;
  int? hasProfile;

  User(
      {required this.id,
      required this.key,
      required this.email,
      required this.altid,
      required this.hasProfile});

  int getUserId(User user) {
    return user.altid!;
  }

  factory User.fromDatabaseJson(Map<String, dynamic> data) =>
      _$UserFromJson(data);

  Map<String, dynamic> toDatabaseJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Profile {
  Profile(this.user, this.hasCompany, this.hasNonProfit,
      this.isCompanyContributor, this.isNonProfitContributor,
      [this.title,
      this.projectsFollowing,
      this.stripeCustomerId,
      this.amountFollowing,
      this.following,
      this.userdonations,
      this.dob,
      this.altruePoints,
      this.address,
      this.country,
      this.city,
      this.zip,
      this.qrCode,
      this.atrocityList,
      this.balance,
      this.donor,
      this.nonProfitList,
      this.orders,
      this.profilePicture,
      this.shirtList,
      this.donationTotal,
      this.description,
      this.np,
      this.comp,
      this.userActions,
      this.username]);
  int? user;
  String? username;
  @JsonKey(includeIfNull: false)
  String? title;
  String? description;
  String? dob;
  @JsonKey(name: 'stripe_customer_id')
  String? stripeCustomerId;
  @JsonKey(includeIfNull: false)
  String? address;
  @JsonKey(includeIfNull: false)
  String? country;
  @JsonKey(includeIfNull: false)
  String? city;
  @JsonKey(includeIfNull: false)
  String? zip;
  @JsonKey(includeIfNull: false, name: "qr_code_img")
  String? qrCode;
  @JsonKey(includeIfNull: false, name: 'shirt_list')
  List<Shirt>? shirtList;
  @JsonKey(name: 'atrocity_list')
  List<Atrocity>? atrocityList;
  @JsonKey(includeIfNull: false, name: 'nonProfit_list')
  List<NonProfit>? nonProfitList;
  double? balance;
  List<Donor>? donor;
  List<Order>? orders;
  @JsonKey(name: 'profile_picture')
  ProfilePicture? profilePicture;
  List<UserDonation>? userdonations;
  @JsonKey(name: 'has_nonprofit')
  bool? hasNonProfit;
  @JsonKey(name: 'has_company')
  bool? hasCompany;
  @JsonKey(name: 'is_companyContributor')
  bool? isCompanyContributor;
  @JsonKey(name: 'is_nonprofitContributor')
  bool? isNonProfitContributor;
  List<AltrueAction>? requirementsForNextLevel;
  @JsonKey(name: 'altrue_level')
  AltrueLevel? altrueLevel;
  @JsonKey(name: 'altruepoints')
  int? altruePoints;
  @JsonKey(name: 'amount_following')
  int? amountFollowing;
  @JsonKey(name: 'profiles_following')
  List<ProfileRepresentation>? following;
  NonProfitRep? np;
  CompanyRep? comp;
  double? donationTotal;
  @JsonKey(name: 'userActions')
  List<UserActions>? userActions;
  @JsonKey(name: 'projects_following')
  List<NonProfitProjectRep>? projectsFollowing;

  factory Profile.fromJson(Map<String, dynamic> data) =>
      _$ProfileFromJson(data);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileCompletion {
  String username;
  String? title;
  String? altrueDonorCode;
  String dob;
  String address;
  String city;
  String country;
  String zip;
  @JsonKey(name: 'profile_picture')
  String? profilePicture;

  ProfileCompletion(
      {required this.username,
      this.title,
      required this.dob,
      required this.address,
      required this.city,
      this.altrueDonorCode,
      required this.country,
      required this.zip});

  factory ProfileCompletion.fromJSon(Map<String, dynamic> data) =>
      _$ProfileCompletionFromJson(data);

  Map<String, dynamic> toJson() => _$ProfileCompletionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileRepresentation {
  int id;
  String? username;
  @JsonKey(name: 'profile_picture')
  ProfilePicture? profilePicture;

  ProfileRepresentation({
    this.username,
    required this.id,
    this.profilePicture,
  });

  factory ProfileRepresentation.fromJson(Map<String, dynamic> data) =>
      _$ProfileRepresentationFromJson(data);

  Map<String, dynamic> toJson() => _$ProfileRepresentationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileFollow {
  int id;
  FollowAction action;

  ProfileFollow({required this.id, required this.action});

  factory ProfileFollow.fromJson(Map<String, dynamic> data) =>
      _$ProfileFollowFromJson(data);

  Map<String, dynamic> toJson() => _$ProfileFollowToJson(this);
}
