import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lovelovelove/Data%20Layer/Models/authentication_models/userLogin_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

const _mobileBaseUrl =
    "https://6ebc-2601-2c6-500-16f0-f98e-16e3-2b1-5ab6.ngrok-free.app";
const _base = "http://127.0.0.1:8000";
const _loginKeyEndpoint = "/auth/login/";
const _registerKeyEndpoint = "/auth/registration/";

final Uri _signinKeyURL = Uri.parse(_mobileBaseUrl + _loginKeyEndpoint);
final Uri _registrationKeyURL =
    Uri.parse(_mobileBaseUrl + _registerKeyEndpoint);

Future<Token> getKey(UserLogin userLogin) async {
  if (kDebugMode) {
    print(jsonEncode(userLogin.toDatabaseJson()));
  }
  if (kDebugMode) {
    print(_signinKeyURL);
  }
  final http.Response response = await http.post(
    _signinKeyURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    if (kDebugMode) {
      // print(json.decode(response.body).toString());
    }
    throw Exception(json.decode(response.body));
  }
}

Future<Token> getKeyFromSignUp(UserSignUpLoginIn userSignUpLoginIn) async {
  if (kDebugMode) {
    print(_registrationKeyURL);
  }
  final http.Response response = await http.post(
    _registrationKeyURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userSignUpLoginIn.toJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Token> getKeyFromConfirmation(
    UserConfirmationModel userConfirmationModel) async {
  if (kDebugMode) {
    print(_registrationKeyURL);
  }
  final http.Response response = await http.post(
    _registrationKeyURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userConfirmationModel.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    if (kDebugMode) {
      print(json.decode(response.body).toString());
    }
    throw Exception(json.decode(response.body));
  }
}
