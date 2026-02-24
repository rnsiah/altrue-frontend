import 'dart:convert';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_dashboard_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_company_impact_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class CompanyImpactRepository {
  final ApiProvider _apiProvider = ApiProvider();
  final UserRepository _userRepository = UserRepository();

  Future<UserCompanyImpact> getUserImpactStats() async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      'api/user/company-impact-stats/',
      user.key!,
    );

    return UserCompanyImpact.fromJson(response);
  }

  Future<CompanyDashboard> getCompanyDashboard(int companyId) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      'api/companies/$companyId/dashboard/',
      user.key!,
    );

    return CompanyDashboard.fromJson(response);
  }
}
