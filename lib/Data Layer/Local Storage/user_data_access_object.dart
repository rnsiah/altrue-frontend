import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import 'user_db.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db!.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> updateUserAfterProfileCreated(User user) async {
    final db = await dbProvider.database;
    var result = await db!.update(userTable, user.toDatabaseJson(),
        where: "id =?", whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db!.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<User?> getCurrentUser(int id) async {
    final db = await dbProvider.database;
    var result = await db!.query(userTable, where: "id=?", whereArgs: [id]);
    if (result.isNotEmpty) {
      return User.fromDatabaseJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> introDone() async {
    final db = await dbProvider.database;
    await (db!.rawUpdate('''
    UPDATE userExperiences
    SET doneIntro = ?
    WHERE id = 0
    ''', [1, 0]));
  }

  Future<void> updateUser(User user) async {
    if (user.hasProfile == 1) {
      final db = await dbProvider.database;
      await (db!.rawUpdate('''
      UPDATE userTable
      SET hasProfile = ?
      WHERE id = ?
    ''', [1, 0]));
    }
  }

// Cart Actions in Local DB Below //

  Future<int> addToCart(OrderItem item) async {
    final db = await dbProvider.database;
    final DatabaseOrderItem theItem = DatabaseOrderItem(
        color: item.color.color,
        shirtId: item.shirt.id!,
        size_id: item.size.id,
        id: item.id!,
        price: item.shirt.price.toString(),
        quantity: item.quantity,
        shirt: item.shirt.name!,
        size: item.size.size);
    var result = await db!.insert(orderItems, theItem.toJson());
    return result;
  }

  Future<int> deleteFromCart(int id) async {
    final db = await dbProvider.database;
    List<Map> res = await db!.query(orderItems);
    int orderCount = res.length;
    await db.delete(orderItems, where: 'id = ?', whereArgs: [id]);

    List<Map> newres = await db.query(orderItems);
    if (newres.length != orderCount) {
      return 1;
    }
    return 0;
  }

  Future<List<DatabaseOrderItem>> checkCart() async {
    final db = await dbProvider.database;
    List<DatabaseOrderItem> cart = [];
    List<Map> res = await db!.query(orderItems);
    if (res.isNotEmpty) {
      for (var re in res) {
        DatabaseOrderItem love = DatabaseOrderItem.fromMap(re);
        cart.add(love);
      }
      return cart;
    }
    return cart;
  }

  clearCart() async {
    final db = await dbProvider.database;
    return await db!.rawDelete("DELETE FROM $orderItems");
  }

  Future<int> editOrderItem(OrderItem item) async {
    final db = await dbProvider.database;
    var result = await db!
        .update(orderItems, item.toMap(), where: "id=?", whereArgs: [item.id]);
    return result;
  }

  Future<int> checkIfProfileComplete(int altid) async {
    final db = await dbProvider.database;
    var res =
        await db!.query(userTable, where: 'altid = ?', whereArgs: [altid]);
    if (res.isNotEmpty) {
      User user = User.fromDatabaseJson(res.first);
      if (user.hasProfile == 1) {
        return 1;
      }
      return 0;
    } else {
      return 0;
    }
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db!.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}
