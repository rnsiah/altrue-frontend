// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFromAPI _$UserFromAPIFromJson(Map<String, dynamic> json) => UserFromAPI(
      email: json['email'] as String,
      url: json['url'] as String,
      firstname: json['first_name'] as String,
      id: (json['id'] as num).toInt(),
      lastName: json['last_name'] as String,
      profile: json['profile'] as String,
      profileCreated: json['profile_created'] as bool,
      userName: json['username'] as String,
    );

Map<String, dynamic> _$UserFromAPIToJson(UserFromAPI instance) =>
    <String, dynamic>{
      'url': instance.url,
      'email': instance.email,
      'first_name': instance.firstname,
      'last_name': instance.lastName,
      'username': instance.userName,
      'id': instance.id,
      'profile': instance.profile,
      'profile_created': instance.profileCreated,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      key: json['key'] as String?,
      email: json['email'] as String?,
      altid: (json['altid'] as num?)?.toInt(),
      hasProfile: (json['hasProfile'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'key': instance.key,
      'altid': instance.altid,
      'hasProfile': instance.hasProfile,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      (json['user'] as num?)?.toInt(),
      json['has_company'] as bool?,
      json['has_nonprofit'] as bool?,
      json['is_companyContributor'] as bool?,
      json['is_nonprofitContributor'] as bool?,
      json['title'] as String?,
      (json['projects_following'] as List<dynamic>?)
          ?.map((e) => NonProfitProjectRep.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['stripe_customer_id'] as String?,
      (json['amount_following'] as num?)?.toInt(),
      (json['profiles_following'] as List<dynamic>?)
          ?.map(
              (e) => ProfileRepresentation.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['userdonations'] as List<dynamic>?)
          ?.map((e) => UserDonation.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['dob'] as String?,
      (json['altruepoints'] as num?)?.toInt(),
      json['address'] as String?,
      json['country'] as String?,
      json['state'] as String?,
      json['city'] as String?,
      json['zip'] as String?,
      json['qr_code_img'] as String?,
      (json['atrocity_list'] as List<dynamic>?)
          ?.map((e) => Atrocity.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['balance'] as num?)?.toDouble(),
      (json['donor'] as List<dynamic>?)
          ?.map((e) => Donor.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['nonProfit_list'] as List<dynamic>?)
          ?.map((e) => NonProfit.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['profile_picture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profile_picture'] as Map<String, dynamic>),
      (json['shirt_list'] as List<dynamic>?)
          ?.map((e) => Shirt.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['donationTotal'] as num?)?.toDouble(),
      json['description'] as String?,
      json['np'] == null
          ? null
          : NonProfitRep.fromJson(json['np'] as Map<String, dynamic>),
      json['comp'] == null
          ? null
          : CompanyRep.fromJson(json['comp'] as Map<String, dynamic>),
      (json['userActions'] as List<dynamic>?)
          ?.map((e) => UserActions.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['username'] as String?,
    )
      ..requirementsForNextLevel =
          (json['requirementsForNextLevel'] as List<dynamic>?)
              ?.map((e) => AltrueAction.fromJson(e as Map<String, dynamic>))
              .toList()
      ..altrueLevel = json['altrue_level'] == null
          ? null
          : AltrueLevel.fromJson(json['altrue_level'] as Map<String, dynamic>);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'username': instance.username,
      if (instance.title case final value?) 'title': value,
      'description': instance.description,
      'dob': instance.dob,
      'stripe_customer_id': instance.stripeCustomerId,
      'address': instance.address,
      'country': instance.country,
      'city': instance.city,
      'zip': instance.zip,
      'state': instance.state,
      if (instance.qrCode case final value?) 'qr_code_img': value,
      'shirt_list': instance.shirtList?.map((e) => e.toJson()).toList(),
      'atrocity_list': instance.atrocityList?.map((e) => e.toJson()).toList(),
      'nonProfit_list': instance.nonProfitList?.map((e) => e.toJson()).toList(),
      'balance': instance.balance,
      'donor': instance.donor?.map((e) => e.toJson()).toList(),
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
      'profile_picture': instance.profilePicture?.toJson(),
      'userdonations': instance.userdonations?.map((e) => e.toJson()).toList(),
      'has_nonprofit': instance.hasNonProfit,
      'has_company': instance.hasCompany,
      'is_companyContributor': instance.isCompanyContributor,
      'is_nonprofitContributor': instance.isNonProfitContributor,
      'requirementsForNextLevel':
          instance.requirementsForNextLevel?.map((e) => e.toJson()).toList(),
      'altrue_level': instance.altrueLevel?.toJson(),
      'altruepoints': instance.altruePoints,
      'amount_following': instance.amountFollowing,
      'profiles_following': instance.following?.map((e) => e.toJson()).toList(),
      'np': instance.np?.toJson(),
      'comp': instance.comp?.toJson(),
      'donationTotal': instance.donationTotal,
      'userActions': instance.userActions?.map((e) => e.toJson()).toList(),
      'projects_following':
          instance.projectsFollowing?.map((e) => e.toJson()).toList(),
    };

ProfileCompletion _$ProfileCompletionFromJson(Map<String, dynamic> json) =>
    ProfileCompletion(
      username: json['username'] as String,
      title: json['title'] as String?,
      state: json['state'] as String,
      dob: json['dob'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      altrueDonorCode: json['altrueDonorCode'] as String?,
      country: json['country'] as String,
      zip: json['zip'] as String,
    )..profilePicture = json['profile_picture'] as String?;

Map<String, dynamic> _$ProfileCompletionToJson(ProfileCompletion instance) =>
    <String, dynamic>{
      'username': instance.username,
      'title': instance.title,
      'altrueDonorCode': instance.altrueDonorCode,
      'dob': instance.dob,
      'state': instance.state,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'zip': instance.zip,
      'profile_picture': instance.profilePicture,
    };

ProfileRepresentation _$ProfileRepresentationFromJson(
        Map<String, dynamic> json) =>
    ProfileRepresentation(
      username: json['username'] as String?,
      id: (json['id'] as num).toInt(),
      profilePicture: json['profile_picture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profile_picture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileRepresentationToJson(
        ProfileRepresentation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profile_picture': instance.profilePicture?.toJson(),
    };

ProfileFollow _$ProfileFollowFromJson(Map<String, dynamic> json) =>
    ProfileFollow(
      id: (json['id'] as num).toInt(),
      action: $enumDecode(_$FollowActionEnumMap, json['action']),
    );

Map<String, dynamic> _$ProfileFollowToJson(ProfileFollow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': _$FollowActionEnumMap[instance.action]!,
    };

const _$FollowActionEnumMap = {
  FollowAction.follow: 'follow',
  FollowAction.unfollow: 'unfollow',
};
