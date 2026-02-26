import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

import '../Models/company_completion_model.dart';

class CompanyRepository {
  ApiProvider provider = ApiProvider();
  NonAuthenticatedApiProvider nonauthprov = NonAuthenticatedApiProvider();
  UserRepository userRepository = UserRepository();
  final String host =
      'http://localhost:8000';
  final String baseHost = "http://127.0.0.1:8000";

  Future<List<ForProfitCompany>> getCompanyList() async {
    List<ForProfitCompany> companies = [];
    final response = await nonauthprov.get('api/companies/');
    for (var responses in response) {
      companies.add(ForProfitCompany.fromJson(responses));
    }
    return companies;
  }

  Future<List<ForProfitCompany>> getCompanyListByCategory(
      {required Category category}) async {
    List<ForProfitCompany> companies = [];
    final response =
        await nonauthprov.get('api/companies/?category=${category.id}');
    for (var responses in response) {
      companies.add(ForProfitCompany.fromJson(responses));
    }
    return companies;
  }

  Future<ForProfitCompany> fetchCompany(ForProfitCompany company) async {
    final response = await nonauthprov.get('api/companies/${company.id}');
    company = ForProfitCompany.fromJson(response);
    return company;
  }

  Future<ForProfitCompany> fetchCompanyById(int id) async {
    final User? user = await userRepository.userDao.getCurrentUser(0);
    final response = await provider.getUserAuthenticatedData(
        'api/companies/$id/', user!.key!);
    return ForProfitCompany.fromJson(response);
  }

  Future<List<ForProfitCompany>> fetchFeaturedCompanies() async {
    List<ForProfitCompany> companyList = [];
    final response = await nonauthprov.get('api/companies/featured');
    for (var company in response) {
      companyList.add(ForProfitCompany.fromJson(company));
    }
    return companyList;
  }

  // Future<bool> createCompany(
  //     {User? user, required CompanyCompletion completedCompany}) async {
  //   var postUri = Uri.parse('http://localhost:8000/api/companies/');
  //   var request = new http.MultipartRequest('post', postUri);
  //   request.headers['Authorization'] = 'Token ${user!.key}';

  //   var response = await request.send();
  //   print(response.stream);
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     throw Exception(
  //         'Something Went Wrong When Creating Your Company Profile');
  //   }
  // }

  Future<bool> newCompany(
      {required CompanyCompletion company, User? user}) async {
    String url = '$baseHost/api/registerCompany/';

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Token ${user!.key}",
        },
        body: json.encode(company));
    if (response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      throw Exception('Did not update');
    }
  }

  Future<void> addCompanyContributors(
      ForProfitCompany company, User user, Profile profile) async {
    try {
      await provider.patchAuthenticatedData(
          'api/companies/${company.id}/manageUserFollowers',
          user.key!,
          user.altid!,
          profile);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> editCompanyDetails(
      User user, ForProfitCompany company, Profile profile) async {
    var postUri = Uri.parse('$baseHost/api/companies/${company.id}/');
    var request = http.MultipartRequest('patch', postUri);
    request.headers['Authorization'] = 'Token ${user.key}';
    request.fields['owner'] = profile.username.toString();
    request.fields['name'] = company.name.toString();
    request.fields['year_started'] = company.yearStarted.toString();
    request.fields['logo'] = company.logo.toString();
    request.fields['mission'] = company.mission.toString();
    request.fields['description'] = company.description.toString();
    request.fields['website_address'] = company.websiteAddress.toString();
    var response = await request.send();
    print(response.stream);
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      print(res.body);
    } else {
      throw Exception('Profile Picture Not Updated');
    }
  }
}

class FollowingAction {
  final Profile profile;
  final String action;

  FollowingAction(this.profile, this.action);
}
