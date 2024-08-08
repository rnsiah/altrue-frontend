import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';

import '../Models/shirt_group_model.dart';

class ShirtGroupRepository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();

  Future<List<ShirtGroup>> getShirtGroups() async {
    List<ShirtGroup> groups = [];
    final response = await _provider.get('api/shirtgroups');
    for (var res in response) {
      groups.add(ShirtGroup.fromJson(res));
    }
    return groups;
  }
}
