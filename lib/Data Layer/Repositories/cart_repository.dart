import 'package:lovelovelove/Data%20Layer/Local%20Storage/user_data_access_object.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_size_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';

class CartRepository {
  ShirtRepository shirtRepository = ShirtRepository();
  UserDao userDao = UserDao();

  Future<List<OrderItem>> ordersIntoCart(
      List<DatabaseOrderItem> theCart) async {
    List<OrderItem> cart = [];

    for (var item in theCart) {
      Shirt love = await shirtRepository.fetchShirt(item.shirtId);
      OrderItem orderItem = OrderItem(
          id: item.id,
          quantity: item.quantity,
          shirt: love,
          color: ShirtColor(color: item.color, id: 0, hex: ''),
          size: ShirtSize(size: item.size, id: 0));
      cart.add(orderItem);
    }
    return cart;
  }

  Future<int> editItemInCart(OrderItem item) async {
    int love = await userDao.editOrderItem(item);
    return love;
  }

  

}
