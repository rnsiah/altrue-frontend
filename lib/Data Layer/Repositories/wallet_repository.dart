import 'dart:convert';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_reward_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class WalletRepository {
  final ApiProvider _apiProvider = ApiProvider();
  final UserRepository _userRepository = UserRepository();

  Future<WalletSummary> getWalletSummary() async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      'api/wallet/',
      user.key!,
    );

    return WalletSummary.fromJson(response);
  }

  Future<List<UserReward>> getUserRewards({String? status}) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    String url = 'api/wallet/rewards/';
    if (status != null) {
      url += '?status=$status';
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      url,
      user.key!,
    );

    if (response is List) {
      return response.map((json) => UserReward.fromJson(json)).toList();
    }
    return [];
  }

  Future<UserReward> claimReward(int rewardId) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.postAuthenticatedData(
      url: 'api/rewards/$rewardId/claim/',
      key: user.key!,
      altId: user.altid!,
      data: {},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return UserReward.fromJson(responseData);
    }
    throw Exception('Failed to claim reward');
  }

  Future<void> markRewardAsViewed(int rewardId) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    await _apiProvider.postAuthenticatedData(
      url: 'api/wallet/rewards/$rewardId/view/',
      key: user.key!,
      altId: user.altid!,
      data: {},
    );
  }

  Future<void> markRewardAsRedeemed(int rewardId) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    await _apiProvider.postAuthenticatedData(
      url: 'api/wallet/rewards/$rewardId/redeem/',
      key: user.key!,
      altId: user.altid!,
      data: {},
    );
  }

  Future<List<CompanyReward>> getAvailableRewards() async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      'api/rewards/',
      user.key!,
    );

    if (response is List) {
      return response.map((json) => CompanyReward.fromJson(json)).toList();
    }
    return [];
  }
}
