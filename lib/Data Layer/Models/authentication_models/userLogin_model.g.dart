// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userLogin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) => UserLogin(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

UserSignUpLoginIn _$UserSignUpLoginInFromJson(Map<String, dynamic> json) =>
    UserSignUpLoginIn(
      email: json['email'] as String,
      password: json['password'] as String,
      password2: json['password2'] as String?,
      altrueCode: json['donor_code'] as String?,
    );

Map<String, dynamic> _$UserSignUpLoginInToJson(UserSignUpLoginIn instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'password2': instance.password2,
      'donor_code': instance.altrueCode,
    };

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      token: json['key'] as String,
      user: UserInfoFromKey.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'key': instance.token,
      'user': instance.user.toJson(),
    };

UserInfoFromKey _$UserInfoFromKeyFromJson(Map<String, dynamic> json) =>
    UserInfoFromKey(
      profileCreated: json['profile_created'] as bool,
      altid: (json['id'] as num).toInt(),
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserInfoFromKeyToJson(UserInfoFromKey instance) =>
    <String, dynamic>{
      'id': instance.altid,
      'email': instance.email,
      'profile_created': instance.profileCreated,
    };
