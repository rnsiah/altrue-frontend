import 'dart:convert';

import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';

import '../Models/send_company_nonprofitMatch_model.dart';
import '../Models/user_model.dart';
import 'package:http/http.dart' as http;

class CompanyMatchRepository {
  final ApiProvider authProvider = ApiProvider();
  final String host =
      'https://6910-2601-2c6-500-16f0-7479-21c3-6187-5833.ngrok-free.app';

  Future<dynamic> createMatchRelationship(
      {required User? user,
      required SendCompanyNonProfitRelationShip relationship}) async {
    String url = '$host/api/createCompanyNPMatch/';
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Token ${user!.key}",
        },
        body: json.encode(relationship));
    if (response.statusCode == 201) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Did not create');
    }
  }
}
