import 'package:lovelovelove/Data%20Layer/Local%20Storage/user_data_access_object.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';

class ShirtOrderRepository {
  final userDao = UserDao();

  Future<int> sendOrderToDatabase(OrderItem order) async {
    int orderItem = await userDao.addToCart(order);
    return orderItem;
  }
  
}
