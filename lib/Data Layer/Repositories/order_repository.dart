import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class OrderRepository {
  final String host =
      'https://18f3-2601-2c6-500-16f0-794d-405a-f82f-f2ed.ngrok-free.app';
  final ApiProvider _apiProvider = ApiProvider();
  // ignore: unused_field
  final NonAuthenticatedApiProvider _nonauthapi = NonAuthenticatedApiProvider();

  Future<List<Order>> getCompletedOrders({required User user}) async {
    List<Order> completedOrders = [];

    final response = await _apiProvider.getUserAuthenticatedData(
        'api/allusercompletedorders/', user.key!);
    for (var responses in response) {
      completedOrders.add(Order.fromJson(responses));
    }
    return completedOrders;
  }

  Future<List<Order>> getAllOrders(User user) async {
    List<Order> allOrders = [];
    final response = await _apiProvider.getUserAuthenticatedData(
        'api/completedorders/', user.key!);
    for (var responses in response) {
      allOrders.add(Order.fromJson(responses));
    }
    return allOrders;
  }

  Future<List<Order>> getUserCompletedOrders(user) async {
    List<Order> completedOrders = [];
    final response =
        await http.get(Uri.parse('$host/api/allusercompletedorders/'),
            // Send authorization headers to the backend.
            headers: {
          HttpHeaders.authorizationHeader: 'Token ${user.key}',
        });
    var responseJson = jsonDecode(response.body);
    List<dynamic> orders = responseJson.map((e) => Order.fromJson(e)).toList();
    for (var order in orders) {
      completedOrders.add(order);
    }
    return completedOrders;
  }
}
