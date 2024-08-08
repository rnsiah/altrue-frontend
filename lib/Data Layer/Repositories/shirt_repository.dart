import 'package:lovelovelove/Data%20Layer/Data%20Providers/user_profile_api.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_variation_model.dart';

class ShirtRepository {
  final NonAuthenticatedApiProvider _provider = NonAuthenticatedApiProvider();

  Future<List<Shirt>> fetchShirtList() async {
    List<Shirt> shirts = [];

    final response = await _provider.get('api/shirts/');
    for (var responses in response) {
      shirts.add(Shirt.fromJson(responses));
    }
    return shirts;
  }

  Future<ShirtVariation> shirtVariationImage(
      {required Shirt shirt, required String color}) async {
    final response = await _provider
        .get('api/shirts/${shirt.id}/getVariation/?color=$color');
    print('The RESPONSE is $response');
    ShirtVariation variation = ShirtVariation.fromJson(response);
    print('shirt variation from api is ${variation.color.color} ');
    return variation;
  }

  Future<List<Shirt>> fetchRefugeeShirts() async {
    List<Shirt> shirts = [];

    final response = await _provider.get('api/refugeeshirts/');
    for (var responses in response) {
      shirts.add(Shirt.fromJson(responses));
    }
    return shirts;
  }

  Future<Shirt> fetchShirt(int id) async {
    final response = await _provider.get('api/shirts/$id/');
    return Shirt.fromJson(response);
  }

  Future<List<Shirt>> featuredShirts() async {
    List<Shirt> shirts = [];
    final response = await _provider.get('api/featuredshirts');
    for (var responses in response) {
      shirts.add(Shirt.fromJson(responses));
    }
    return shirts;
  }

  // Future<ShirtSize> fetchSize()async{
  //   final response = await _provider.get()
  // }

  // Future<ShirtColor> fetchShirtColor()async{
  //   final response = await _provider.get()
  // }

  Future<List<Shirt>> fetchShirtByCategory(Category category) async {
    List<Shirt> shirts = [];
    if (category.name == 'All Causes') {
      shirts = await fetchShirtList();
      return shirts;
    }
    final shirtList = await _provider
        .get('api/${category.name!.replaceAll(' ', '').toLowerCase()}shirts');

    for (var shirt in shirtList) {
      shirts.add(Shirt.fromJson(shirt));
    }
    return shirts;
  }

  // Future<String> getShirtColor(ShirtVariation variation)async{

  // }
}
