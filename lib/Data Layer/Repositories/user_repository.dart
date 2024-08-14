import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_authentication_api.dart';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Local%20Storage/user_data_access_object.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/authentication_models/userLogin_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/credit_card_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/manage_followers_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_result_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import '../Models/donation_data_model.dart';
import '../Models/nonprofit_project_model.dart';
import '../Models/upvote_model.dart';
import '../Models/user_donation_model.dart';

class UserRepository {
  final userDao = UserDao();
  final _apiProvider = ApiProvider();

  final String host =
      'https://18f3-2601-2c6-500-16f0-794d-405a-f82f-f2ed.ngrok-free.app/';

  Future introDone() async {
    await userDao.introDone();
  }

//  Grabs information from login Bloc and and then acccess the user authetntication
// data service which returns a key. Once key is returned, it creates a User object
// from the Key object which hold hte user email, key, and the altrue id , and gives
// a default 0 as id for the local database storage on device
  Future<User> authenticate({
    required String email,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(email: email, password: password);
    Token key = await getKey(userLogin);
    bool beenloggedInbefore = await hasToken();
    if (beenloggedInbefore) {
      User loggedInUser = (await userDao.getCurrentUser(0))!;
      return loggedInUser;
    }
    User user2 = User(
        id: 0,
        email: key.user.email,
        key: key.token,
        altid: key.user.altid,
        hasProfile: (key.user.profileCreated) ? 1 : 0);
    await persistToken(user: user2);
    return user2;
  }

// Function that checks the local Databse on device to return  the altrue Id
// Function is to obtain that id to call for userprofile and other authenticated
// api requests
  Future<int> getAltId(User user) async {
    user = (await userDao.getCurrentUser(0))!;
    int altid = user.altid!;
    return altid;
  }

// Function that returns the key of the user that is stored locally to
// access authenticated api requests

  Future<String> getUserkey(User user) async {
    user = (await userDao.getCurrentUser(0))!;
    String key = user.key!;
    return key;
  }

// Function that grabs info from sign up bloc and then access the user registration
// api endpoint which will return a key object . Once key object is returned , User object is
// created and saved to local database.

  Future<User> register({
    required String email,
    required String password1,
    required String password2,
    String? altrueCode,
  }) async {
    UserSignUpLoginIn userSignUpLoginIn = UserSignUpLoginIn(
        email: email, password: password1, password2: password2);
    Token key = await getKeyFromSignUp(userSignUpLoginIn);
    User user = User(
        email: key.user.email,
        id: 0,
        key: key.token,
        altid: key.user.altid,
        hasProfile: (key.user.profileCreated) ? 0 : 1);
    await persistToken(user: user);

    return user;
  }

  Future<User> confirmSignUpWithoutConfirmation({
    required String confirmationCode,
    required String email,
  }) async {
    UserConfirmationModel confirmationModel =
        UserConfirmationModel(confirmationCode: confirmationCode, email: email);
    Token key = await getKeyFromConfirmation(confirmationModel);
    User user = User(
        email: key.user.email,
        key: key.token,
        id: 0,
        altid: key.user.altid,
        hasProfile: 0);

    return user;
  }

  Future<User> getUpdatedUserFromApi(User user) async {
    String key = user.key!;
    int altId = user.altid!;
    String url = 'api/users/$altId';
    dynamic response = await _apiProvider.getUserAuthenticatedData(url, key);
    UserFromAPI updateUser = UserFromAPI.fromJson(response);
    User returnedUser = User(
        email: updateUser.email,
        altid: updateUser.id,
        hasProfile: updateUser.profileCreated ? 1 : 0,
        key: key,
        id: user.id);
    return returnedUser;
  }

  Future<List<DatabaseOrderItem>> getCart() async {
    List<DatabaseOrderItem> cart = await userDao.checkCart();

    return cart;
  }

  Future<void> addToCart(OrderItem item) async {
    await userDao.addToCart(item);
  }

  Future<dynamic> sendCartToAPI() async {
    String site = '${host}api/createOrders/';

    Cart sendingCart = Cart(items: List.empty(growable: true));
    User? user = await userDao.getCurrentUser(0);
    List<DatabaseOrderItem> theCart = await getCart();
    for (var item in theCart) {
      sendingCart.items.add(item);
    }
    for (var love in sendingCart.items) {
      print(sendingCart.toJson());
    }

    if (user != null) {
      var response2 = await http.post(Uri.parse(site),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Token ${user.key}",
          },
          body: json.encode(sendingCart));
      if (response2.statusCode == 201) {
        print(response2.body);
        return response2.body;
      } else {
        throw Exception('Couldnt Process Payment');
      }
    }
  }

  Future<bool> deleteFromCart(int databaseId) async {
    int result = await userDao.deleteFromCart(databaseId);
    if (result == 1) {
      return true;
    }
    return false;
  }

  Future<void> emptyCart() async {
    await userDao.clearCart();
  }

  Future<void> confirmSignUpWithConfirmation({
    required String email,
    required String passsword,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> persistToken({required User user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> deleteToken({required int localid}) async {
    await userDao.deleteUser(localid);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);

    return result;
  }

  Future<bool> checkIfUserHasProfile(User user) async {
    int check = await userDao.checkIfProfileComplete(user.altid!);
    if (check == 1) {
      return true;
    }
    return false;
  }

  Future<void> updateProfile(
      {required User user,
      ProfileCompletion? profile,
      String? paymentMethodId}) async {
    // ignore: unused_local_variable
    String keyOfUser = user.key!;
    int altId = user.altid!;

    var postUri = Uri.parse('${host}api/userprofile/$altId/update_profile/');
    final data = <String, dynamic>{};

    // Only add non-null values to the data map
    if (profile != null) {
      if (profile.username.isNotEmpty) {
        data['username'] = profile.username;
      }

      if (profile.country != null && profile.country.isNotEmpty) {
        data['country'] = profile.country;
      }
      if (profile.city != null && profile.city.isNotEmpty) {
        data['city'] = profile.city;
      }
      if (profile.zip != null && profile.zip.isNotEmpty) {
        data['zip'] = profile.zip;
      }
      if (profile.dob != null) data['dob'] = profile.dob;
      if (profile.address != null && profile.address.isNotEmpty) {
        data['address'] = profile.address;
      }
      if (profile.altrueDonorCode != null &&
          profile.altrueDonorCode!.isNotEmpty) {
        data['donor_code'] = profile.altrueDonorCode;
      }
    }

    if (paymentMethodId != null && paymentMethodId.isNotEmpty) {
      data['payment_method_id'] = paymentMethodId;
    }

    print('Data being sent: $data'); // Log the data being sent

    final response = await http.patch(postUri,
        headers: {
          'Authorization': 'Token ${user.key}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<bool> checkProfileComplete(User user) async {
    final url = Uri.parse('${host}api/checkprofile/${user.altid}');
    final headers = {
      'Authorization': 'Token ${user.key}',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['profile_created'] == true) {
          return true;
        }
        return false;
      } else {
        // Handle error (e.g., print message, throw exception)
        print('Error checking profile completeness: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle network or other errors
      print('Error checking profile completeness: $error');
      return false;
    }
  }

  Future<void> changeProfilePicture({required XFile profilePic}) async {
    User? user = await userDao.getCurrentUser(0);
    if (user != null) {
      const String local = 'localhost:8000';
      var postUri =
          Uri.parse('$host/api/userprofile/${user.altid}/add_profilePic/');
      var request = http.MultipartRequest('patch', postUri);
      request.headers['Authorization'] = 'Token ${user.key}';
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('profile_picture', profilePic.path);
      request.files.add(multipartFile);
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

  Future<void> addNonProfitToProfileList({required NonProfit nonprofit}) async {
    User? user = await userDao.getCurrentUser(0);
    if (user != null) {
      // ignore: unused_local_variable
      const String local = 'localhost:8000';

      final response = await http.patch(
          Uri.parse('${host}api/userprofile/${user.altid}/add_nonprofit/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: "Token ${user.key}"
          },
          body: jsonEncode(nonprofit.toJson()));
      if (response.statusCode == 200) {
        print('added nonprofit to profile list');
      } else {
        throw Exception('Did not update');
      }
    }
  }

  Future<void> addAtrocityToProfileList({required Atrocity atrocity}) async {
    User? user = await userDao.getCurrentUser(0);
    if (user != null) {
      const String local = 'localhost:8000';

      final response = await http.patch(
          Uri.parse('${host}api/userprofile/${user.altid}/add_atrocity/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: "Token ${user.key}"
          },
          body: jsonEncode(atrocity.toJson()));
      if (response.statusCode == 200) {
        print('updated the atrocity');
      } else {
        throw Exception('Did not update');
      }
    }
  }

  Future<CreditCardDetails> fetchPaymentMethod() async {
    User? user = await userDao.getCurrentUser(0);
    dynamic response = await _apiProvider.getUserAuthenticatedData(
        'api/fetchPaymentMethod/', user!.key!);
    final responseData = response as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    print({'1': data});
    return CreditCardDetails.fromJson(data);
  }

  Future<String?> createPaymentMethod(
      {required String cardNumber,
      required int expMonth,
      required int expYear,
      required String cardholderName,
      required String cvv}) async {
    await Stripe.instance.dangerouslyUpdateCardDetails(
      CardDetails(
        number: cardNumber.replaceAll(' ', ''),
        expirationMonth: expMonth,
        expirationYear: expYear,
        cvc: cvv,
      ),
    );

    final PaymentMethodParams paymentMethodParams = PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(name: cardholderName)));

    final dynamic paymentMethod =
        await Stripe.instance.createPaymentMethod(params: paymentMethodParams);
    return paymentMethod.id;
  }

  Future<String> getSetupIntentClientSecret() async {
    final response = await http.get(Uri.parse('${host}api/getsetupintent'));
    print(response.toString());
    if (response.statusCode != 200) {
      throw Exception('Failed to create SetupIntent');
    }
    return json.decode(response.body)['client_secret']['client_secret'];
  }

  Future<void> confirmSetupIntent(String paymentMethodId, String clientSecret,
      String cardHolderName) async {
    print([
      {'paymentMethodId': paymentMethodId},
      {'clientSecret': clientSecret},
    ]);
    final setupIntent = await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: clientSecret,
        params: PaymentMethodParams.cardFromMethodId(
            paymentMethodData: PaymentMethodDataCardFromMethod(
                paymentMethodId: paymentMethodId)));

    print({setupIntent.status: setupIntent.id});
    if (setupIntent.status != 'Succeeded') {
      throw Exception('SetupIntent confirmation failed');
    }
    if (setupIntent.id != null) {
      print('got it finally');
      User? user = await userDao.getCurrentUser(0);
      updateProfile(user: user!, paymentMethodId: paymentMethodId);
      print(setupIntent.id);
    }
  }

  Future<void> addShirtToProfileList({required Shirt shirt}) async {
    User? user = await userDao.getCurrentUser(0);
    if (user != null) {
      const String local = 'localhost:8000';

      final response = await http.patch(
          Uri.parse('${host}api/userprofile/${user.altid}/add_shirt/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: "Token ${user.key}"
          },
          body: jsonEncode(shirt.toJson()));
      if (response.statusCode == 200) {
        print('Updated');
      } else {
        throw Exception('Did not update');
      }
    }
  }

  Future<String> upvoteAtrocity({required Atrocity atrocity}) async {
    User? user = await userDao.getCurrentUser(0);
    String url = '${host}api/upvote/';
    Upvote upvote = Upvote(atrocity: atrocity.id!);
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Token ${user!.key}",
        },
        body: json.encode(upvote));
    if (response.statusCode == 201) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Did Not Rate');
    }
  }

  Future<Map<String, dynamic>> creatPaymentIntentForDonation({
    required DonationData donationData,
  }) async {
    User? user = await userDao.getCurrentUser(0);

    Future<dynamic> theresponse(http.Response response) async {
      switch (response.statusCode) {
        case 200:
          var responseJson = json.decode(utf8.decode(response.bodyBytes));
          if (kDebugMode) {
            print(responseJson);
          }
          return responseJson;
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException(
              'Error occurred while communicating with the server. StatusCode: ${response.statusCode}');
      }
    }

    try {
      Uri endpoint;
      switch (donationData.donationType) {
        case 'nonprofit':
          endpoint = Uri.parse(
              '${host}api/userprofile/${user!.altid}/addUserDonationToNonProfit/');
          break;
        case 'atrocity':
          endpoint = Uri.parse(
              '${host}api/userprofile/${user!.altid}/addUserDonationToAtrocity/');
          break;
        case 'project':
          endpoint = Uri.parse(
              '${host}api/userprofile/${user!.altid}/addUserDonationToProject/');
          break;
        default:
          throw Exception('Invalid donation type');
      }

      final response = await http.post(
        endpoint,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${user.key}',
        },
        body: jsonEncode(donationData.toJson()),
      );

      final dynamic responseData = await theresponse(response);
      if (responseData is Map<String, dynamic>) {
        return responseData;
      } else {
        throw Exception('Failed to make donation');
      }
    } catch (e) {
      print(e);
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> initPaymentSheet(Map<String, dynamic> stripeResponse) async {
    try {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: false,
        paymentIntentClientSecret: stripeResponse['client_secret'],
        customerId: stripeResponse['customer'],
        customerEphemeralKeySecret: stripeResponse['ephemeral_key'],
        merchantDisplayName: 'Altrue Global',
      ));
    } catch (e) {
      print('Error $e');
    }
  }

  Future<dynamic> submitQuizScore(QuizResult quizResult)async{
    User? user = await userDao.getCurrentUser(0);
     String key = user!.key!;
    int altId = user.altid!;
    String url = 'api/submitquizscores/';
    dynamic response = await _apiProvider.postAuthenticatedData(url:url , key:key, altId: altId, data: quizResult);
    return response;
  }

  Future<String> fetchPaymentSheet() async {
    // Make an HTTP GET request to your Django backend
    // Replace 'your_backend_url' with the actual URL of your endpoint
    String url = '${host}api/create_payment_intent/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server returns a success response, parse the JSON response
      // and extract the client secret
      return json.decode(response.body)['client_secret'];
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load client secret from backend');
    }
  }

  Future<String?> getOrderStatus(String stripeId) async {
    User? profile = await userDao.getCurrentUser(0);
    final url = Uri.parse(
        'https://18f3-2601-2c6-500-16f0-794d-405a-f82f-f2ed.ngrok-free.app/api/order_status/');

    try {
      final response = await http.post(
        url,
        body: jsonEncode({'stripe_id': stripeId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Token ${profile!.key}"
        },
      );
      print(response);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print({'the data': data['status']});
        if (data['status'] == true) {
          return 'true';
        }
        return 'false';
      } else {
        // Handle error response
        return null;
      }
    } catch (e) {
      // Handle network or other errors
      return null;
    }
  }

  Future<Map<String, dynamic>> createPaymentIntentForPurchase(
    int amount,
    List<OrderItem>? shirts,
  ) async {
    User? profile = await userDao.getCurrentUser(0);
    print(profile!.key);
    final url = Uri.parse(
        'https://18f3-2601-2c6-500-16f0-794d-405a-f82f-f2ed.ngrok-free.app/api/create_payment_intent/');
    List shirtss = [];
    try {
      for (var shirt in shirts!) {
        var love = shirt.toMap();
        shirtss.add(love);
      }
      var data = {
        'amount': amount,
        'shirt': shirtss,
        'user_id': profile.altid,
        'payment_type': "card"
      };
      print("Token ${profile.key}");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Token ${profile.key}"
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // Extract the client secret from the response
        final data = jsonDecode(response.body);
        // final clientSecret = data['clientSecret'];
        return data;
      } else {
        // Handle the case when the request fails
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      // Handle any errors
      throw Exception('Failed to create payment intent: $e');
    }
  }

  Future<bool> checkDonationStatusByStripeId(String paymentIntentId) async {
    User? profile = await userDao.getCurrentUser(0);

    final response = await _apiProvider.getUserAuthenticatedData(
        'api/donations/status/$paymentIntentId/', profile!.key!);

    print(response);
    return response['paid_for'] == 'true';
  }

  Future<Map<String, dynamic>> createPaymentWithAltrueFunds(
      double amount,
      NonProfit? nonprofit,
      Atrocity? atrocity,
      NonProfitProject? project) async {
    User? profile = await userDao.getCurrentUser(0);
    print(profile!.key);
    final url = Uri.parse(
        'https://18f3-2601-2c6-500-16f0-794d-405a-f82f-f2ed.ngrok-free.app/api/donate/');
    print(url);
    var data = {
      "user_id": profile.altid,
      "nonprofit": nonprofit?.id,
      "atrocity": atrocity?.id,
      "project": project?.id,
      "amount": amount,
    };
    try {
      print(data);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Token ${profile.key}"
        },
        body: json.encode(data),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        throw Exception('Failed to make payment');
      }
    } catch (e) {
      throw Exception('Failed to make payment $e');
    }
  }

  Future<Map<String, dynamic>> createPaymentWithPoints(
      List<OrderItem>? shirts, int orderId) async {
    User? profile = await userDao.getCurrentUser(0);
    final url = Uri.parse(
        'https://18f3-2601-2c6-500-16f0-794d-405a-f82f-f2ed.ngrok-free.app/api/point_payment/');
    List shirtss = [];
    try {
      for (var shirt in shirts!) {
        var love = shirt.toMap();
        shirtss.add(love);
      }
      var data = {
        'shirt': shirtss,
        "order_id": orderId,
        'user_id': profile!.altid,
        "payment_type": 'points'
      };
      print(data);
      print("Token ${profile.key}");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Token ${profile.key}"
        },
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        throw Exception('Failed to make payment');
      }
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }

  Future<Map<String, dynamic>> createHybridPayment(
      List<OrderItem>? shirts, int orderId, int pointPayment) async {
    User? profile = await userDao.getCurrentUser(0);
    final url = Uri.parse(
        'https://18f3-2601-2c6-500-16f0-794d-405a-f82f-f2ed.ngrok-free.app/api/hybrid_payment/');
    List shirtss = [];
    try {
      for (var shirt in shirts!) {
        var love = shirt.toMap();
        shirtss.add(love);
      }
      var data = {
        'shirt': shirtss,
        "order_id": orderId,
        "user_id": profile!.altid,
        "payment_type": 'hybrid',
        "point_payment": pointPayment
      };
      print(data);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: "Token ${profile.key}"
          },
          body: json.encode(data));
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to make payment');
      }
    } catch (e) {
      throw Exception('Failed to make payment intent  $e');
    }
  }

  Future<void> initPaymentSheetForPurchase(Map<String, dynamic> data) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Altrue',
          paymentIntentClientSecret: data['clientSecret']['client_secret'],
          // customerEphemeralKeySecret: data['ephemeralKey'],
          // customerId: data['customer'],
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          // googlePay: const PaymentSheetGooglePay(
          //   merchantCountryCode: 'US',
          //   testEnv: true,
          // ),
          style: ThemeMode.dark,
        ),
      );
      // setState(() {
      //   _paymentSheetInitialized = true;
      // });
    } catch (e) {
      // Handle initialization errors
      print('Error initializing payment sheet: $e');
    }
  }

  Future<void> addCompanyToProfileList(
      {required ForProfitCompany comapny}) async {
    User? user = await userDao.getCurrentUser(0);
    if (user != null) {
      final response = await http.patch(
          Uri.parse('$host/api/userprofile/${user.altid}/add_company/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: "Token ${user.key}"
          },
          body: jsonEncode(comapny.toJson()));
      if (response.statusCode == 200) {
      } else {
        throw Exception('Did not update');
      }
    }
  }

  Future<void> manageFollowers({
    ManageFollower? manageFollower,
  }) async {
    Map data = {
      'id': manageFollower!.id,
      "following": manageFollower.follow.toString()
    };
    User? user = await userDao.getCurrentUser(0);
    print(data);
    if (user != null) {
      final response = await http.post(
          Uri.parse('$host/api/userprofile/${user.altid}/manageUserFollowers/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: 'Token ${user.key}'
          },
          body: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
      }
      throw Exception('Did Not Update');
    }
  }

  Future<Profile> fetchProfile({required int id}) async {
    User? user = await userDao.getCurrentUser(0);
    dynamic response = await _apiProvider.getUserAuthenticatedData(
        'api/userprofile/$id/', user!.key!);
    Profile profile = Profile.fromJson(response);
    return profile;
  }

  Future<Profile> getProfileFromApi({required User user}) async {
    int id = user.altid!;
    String endpoint = 'api/userprofile/$id/';

    dynamic response =
        await _apiProvider.getUserAuthenticatedData(endpoint, user.key!);
    // print(response);
    Profile profile = Profile.fromJson(response);

    return profile;
  }
}

// Future<bool>

class UserConfirmationModel {
  String confirmationCode;
  String email;

  UserConfirmationModel({required this.confirmationCode, required this.email});

  Map<String, dynamic> toDatabaseJson() =>
      {"email": email, "confirmationCode": confirmationCode};
}

enum FollowAction { follow, unfollow }
