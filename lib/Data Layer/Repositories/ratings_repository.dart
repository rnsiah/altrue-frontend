import 'dart:convert';

import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';

import '../Models/rating_model.dart';
import '../Models/user_model.dart';
import 'package:http/http.dart' as http;

class RatingsRepository {
  final ApiProvider authProvider = ApiProvider();
  final String host =
      'https://92457f366a93.ngrok-free.app';
  final String baseHost = 'http://127.0.0.1:8000';

  Future<dynamic> rateSomething(
      {required User? user, required Rating rating}) async {
    String url = '$baseHost/api/rateItem/';

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Token ${user!.key}",
        },
        body: json.encode(rating));
    if (response.statusCode == 201) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Did Not Rate');
    }
  }
}
