import 'dart:convert';

import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';

import '../Models/rating_model.dart';
import '../Models/user_model.dart';
import 'package:http/http.dart' as http;

class RatingsRepository {
  final ApiProvider authProvider = ApiProvider();
  final String host =
      'https://6910-2601-2c6-500-16f0-7479-21c3-6187-5833.ngrok-free.app';

  Future<dynamic> rateSomething(
      {required User? user, required Rating rating}) async {
    String url = '$host/api/rateItem/';

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
