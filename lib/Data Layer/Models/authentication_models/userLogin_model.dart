import 'package:json_annotation/json_annotation.dart';

part 'userLogin_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  Map<String, dynamic> toDatabaseJson() => _$UserLoginToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserSignUpLoginIn {
  String email;
  String password;
  String? password2;
  @JsonKey(name: 'donor_code')
  String? altrueCode;

  UserSignUpLoginIn(
      {required this.email,
      required this.password,
      this.password2,
      this.altrueCode});

  Map<String, dynamic> toJson() => _$UserSignUpLoginInToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Token {
  @JsonKey(name: 'key')
  String token;
  UserInfoFromKey? user;

  Token({required this.token, this.user});

  factory Token.fromJson(Map<String, dynamic> data) => _$TokenFromJson(data);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserInfoFromKey {
  @JsonKey(name: 'id')
  int altid;
  String email;
  @JsonKey(name: "profile_created")
  bool profileCreated;

  UserInfoFromKey(
      {required this.profileCreated, required this.altid, required this.email});

  factory UserInfoFromKey.fromJson(Map<String, dynamic> data) =>
      _$UserInfoFromKeyFromJson(data);

  Map<String, dynamic> toJson() => _$UserInfoFromKeyToJson(this);
}
