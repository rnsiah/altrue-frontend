import 'dart:convert';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class MatchingRepository {
  final ApiProvider _apiProvider = ApiProvider();
  final UserRepository _userRepository = UserRepository();

  Future<AvailableMatchesResponse> getAvailableMatches({
    required double amount,
    required int causeId,
    int? nonprofitId,
  }) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    String url = 'api/matches/available/?amount=$amount&cause=$causeId';
    if (nonprofitId != null) {
      url += '&nonprofit=$nonprofitId';
    }

    final response = await _apiProvider.getUserAuthenticatedData(
      url,
      user.key!,
    );

    return AvailableMatchesResponse.fromJson(response);
  }

  Future<bool> applyMatchToDonation({
    required int donationId,
    required int matchOfferId,
  }) async {
    final user = await _userRepository.userDao.getCurrentUser(0);
    if (user == null || user.key == null) {
      throw Exception('User not authenticated');
    }

    final response = await _apiProvider.postAuthenticatedData(
      url: 'api/donations/$donationId/match/',
      key: user.key!,
      altId: user.altid!,
      data: {'match_offer_id': matchOfferId},
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
