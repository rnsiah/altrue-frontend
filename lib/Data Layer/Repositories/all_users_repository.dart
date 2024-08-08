import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Local%20Storage/user_data_access_object.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class AllUsersRepository {
  ApiProvider provider = ApiProvider();
  UserDao userDao = UserDao();
  NonAuthenticatedApiProvider nonauthprovider = NonAuthenticatedApiProvider();

  Future<List<ProfileRepresentation>> getAllProfiles() async {
    List<ProfileRepresentation> profileList = [];
    User? user = await userDao.getCurrentUser(0);
    final profiles =
        await provider.getUserAuthenticatedData('api/findusers', user!.key!);
    for (var profile in profiles) {
      profileList.add(ProfileRepresentation.fromJson(profile));
    }
    return profileList;
  }

  Future<Profile> getProfileById(Profile otheruserprofile) async {
    User? user = await userDao.getCurrentUser(0);
    final profile = await provider.getUserAuthenticatedData(
        'api/userprofiles/${otheruserprofile.user}', user!.key!);
    return profile;
  }
}
