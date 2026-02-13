import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class NonProfitRespository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();
  ApiProvider authProvider = ApiProvider();
  final String host =
      'https://92457f366a93.ngrok-free.app';
  final String baseHost = 'http://127.0.0.1:8000';

  Future<List<NonProfit>> fetchNonProfits() async {
    List<NonProfit> nonProfitList = [];

    final response = await _provider.get('api/nonprofits/');
    for (var nonprofits in response) {
      nonProfitList.add(NonProfit.fromJson(nonprofits));
    }
    return nonProfitList;
  }

  Future<NonProfit> fetchNonProfit(int id) async {
    final response = await _provider.get('api/nonprofits/$id/');
    return NonProfit.fromJson(response);
  }

  Future<List<NonProfit>> fetchFeaturedNonProfits() async {
    List<NonProfit> nonProfitList = [];
    final response = await _provider.get('api/featurednonprofits');
    for (var nonprofits in response) {
      nonProfitList.add(NonProfit.fromJson(nonprofits));
    }
    return nonProfitList;
  }

  Future<List<NonProfit>> fetchNonProfitByCategory(Category category) async {
    List<NonProfit> nonprofits = [];
    final response =
        await _provider.get('api/nonprofits/category/?cat=${category.id}');
    for (var nonprofit in response) {
      nonprofits.add(NonProfit.fromJson(nonprofit));
    }
    return nonprofits;
  }

  Future<bool> newNonProfit(
      {required NonProfitCompletion nonprofit, User? user}) async {
    String url = '$host/api/registernp/';

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Token ${user!.key}",
        },
        body: json.encode(nonprofit));
    if (response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      throw Exception('Did not update');
    }
  }
}
    // }  Future<void> createNonProfit(
    //       {required NonProfitCompletion nonProfitCompletion, User? user}) async {
    //     var postUri = Uri.parse('http://localhost:8000/api/nonprofits/');
    //     var request = new http.MultipartRequest('post', postUri);
    //     request.headers['Authorization'] = 'Token ${user!.key}';
    //     final mainImage = nonProfitCompletion.mainImage;
    //     final logo = nonProfitCompletion.logo;
    //     if (mainImage is XFile) {
    //       http.MultipartFile multipartFile =
    //           await http.MultipartFile.fromPath('mainImage', mainImage.path);
    //       request.files.add(multipartFile);
    //     }
    //     if (logo is XFile) {
    //       http.MultipartFile multipartFile2 =
    //           await http.MultipartFile.fromPath('logo', logo.path);
    //       request.files.add(multipartFile2);
    //     }
    //     var response = await request.send();
    //     print(response.stream);
    //     if (response.statusCode == 200) {
    //       final res = await http.Response.fromStream(response);
    //       print(res.body);
    //     } else {
    //       throw Exception('NonProfit Could Not Be Created');
    //     }
    //   }
    // }


