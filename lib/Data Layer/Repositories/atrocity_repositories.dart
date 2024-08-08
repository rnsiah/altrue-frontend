import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';

class AtrocityRepository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();

  Future<List<Atrocity>> getFeaturedAtrocities() async {
    List<Atrocity> atrocities = [];
    final response = await _provider.get('api/featuredatrocities');
    for (var responses in response) {
      atrocities.add(Atrocity.fromJson(responses));
    }
    return atrocities;
  }

  Future<List<Atrocity>> getAtrocityListByCategory(Category category) async {
    List<Atrocity> atrocities = [];
    final atrocityList =
        await _provider.get('api/atrocities/category/?cat=${category.id}');
    for (var atrocity in atrocityList) {
      atrocities.add(Atrocity.fromJson(atrocity));
    }
    return atrocities;
  }

  Future<Atrocity> getAtrocity(int id) async {
    final response = await _provider.get('api/atrocities/$id/');
    return Atrocity.fromJson(response);
  }

  Future<List<Atrocity>> getAtrocities() async {
    List<Atrocity> atrocities = [];
    final response = await _provider.get('api/atrocities/');
    for (var responses in response) {
      atrocities.add(Atrocity.fromJson(responses));
    }
    return atrocities;
  }
}
