import 'dart:convert';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class CompanyCampaignRepository {
  final ApiProvider _apiProvider = ApiProvider();
  final UserRepository _userRepository = UserRepository();

  Future<List<CompanyCampaign>> getCompanyCampaigns({
    required int companyId,
    bool isActive = true,
  }) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      'api/companies/$companyId/campaigns/?is_active=$isActive',
      user.key!,
    );

    if (response is List) {
      return response.map((json) => CompanyCampaign.fromJson(json)).toList();
    }
    return [];
  }

  Future<CompanyCampaign> getCampaignDetail(int campaignId) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      'api/campaigns/$campaignId/',
      user.key!,
    );

    return CompanyCampaign.fromJson(response);
  }

  Future<List<CompanyCampaign>> getActiveCampaigns() async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      'api/campaigns/active/',
      user.key!,
    );

    if (response is List) {
      return response.map((json) => CompanyCampaign.fromJson(json)).toList();
    }
    return [];
  }
}
