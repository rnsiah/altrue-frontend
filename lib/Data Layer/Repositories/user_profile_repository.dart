// import 'dart:convert';
// import 'dart:io';

// import 'package:mobile/Data_Layer/Data_Providers/user_profile_api.dart';
// import 'package:mobile/Data_Layer/Models/user_model.dart';
// import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';
// import 'package:http/http.dart' as http;
// import 'package:mobile/Presentation/Screens/userProfile_fillScreen.dart';

// class UserProfileRepository {
  
//   ApiProvider _apiProvider = ApiProvider();

  

//   Future<bool> checkIfUserHasProfile() async {
//     bool hasProfile = await userRepository.userDao.checkIfProfileComplete();
//     var result = hasProfile ? true : false;
//     return result;
//   }

//   Future<bool> updateProfile({
//     required ProfileCompletion profile,
//   }) async {
//     String body = json.encode(profile);
//     User? user = await userRepository.userDao.getCurrentUser(0);
//     String keyOfUser = user!.key;
//     int altId = user.altid;

//     final response = await http.put(
//       Uri.parse('http://localhost:8000/api/userprofiles/{$altId}:'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         HttpHeaders.authorizationHeader: keyOfUser
//       },
//       body: body,
//     );

//     if (response.statusCode == 204) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return true;
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Did not work');
//     }
//   }

//   Future<Profile> getProfileFromApi({
//     required int userAltId,
//     required String key,
//   }) async {
//     String endpoint = '/userprofiles/{$userAltId}/';
//     User user = (await userRepository.userDao.getCurrentUser(0))!;
//     key = user.key;
//     userAltId = user.altid;
//     dynamic response =
//         await _apiProvider.getUserAuthenticatedData(endpoint, key, userAltId);
//     Profile profile = Profile.fromJson(response);
//     return profile;
//   }

//   Future<bool> updateProfileToApi({
//     required int userAltId,
//     required String key,
//     required Profile profile,
//   }) async {
//     User user = (await userRepository.userDao.getCurrentUser(0))!;
//     print(user);
//     final key = user.key;
//     final userAltId = user.altid;
//     String endpoint = '/userprofiles/{$userAltId}/';
//     dynamic response = await _apiProvider.sendAuthenticatedData(
//         endpoint, key, userAltId, profile);
//     print(response);
//     if (response == true) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
