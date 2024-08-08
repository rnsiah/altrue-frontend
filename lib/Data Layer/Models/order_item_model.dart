import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_size_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {
  @JsonKey(name: 'ordered_shirt')
  Shirt shirt;
  int quantity;
  ShirtSize size;
  ShirtColor color;
  int? id;

  OrderItem(
      {this.id,
      required this.quantity,
      required this.shirt,
      required this.color,
      required this.size});

  factory OrderItem.fromJson(Map<String, dynamic> data) =>
      _$OrderItemFromJson(data);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'shirtId': id,
      'shirt': shirt.name,
      'quantity': quantity,
      'size': size.size,
      'points_needed_to_purchase': shirt.pointsNeededToPurchase,
      'color': color.color,
      'price': shirt.price.toString()
    };
  }

  @override
  String toString() {
    return 'OrderItem(shirt: ${shirt.name}, quantity:$quantity, size:${size.size}, color:${color.color})';
  }
}

@JsonSerializable(explicitToJson: true)
class Cart {
  final List<DatabaseOrderItem> items;

  Cart({required this.items});

  factory Cart.fromDatabaseJson(Map<String, dynamic> data) =>
      _$CartFromJson(data);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  // Map<String, dynamic> toDatabaseJson() => _$CartToJson(this);

  int getLength() => items.length;
}

@JsonSerializable(explicitToJson: true)
class DatabaseOrderItem {
  final int id;
  final int shirtId;
  final int? size_id;
  final String shirt;
  final String color;
  final String size;
  final String price;
  final int quantity;

  DatabaseOrderItem(
      {required this.color,
      required this.shirtId,
      required this.size_id,
      required this.id,
      required this.price,
      required this.quantity,
      required this.shirt,
      required this.size});

  factory DatabaseOrderItem.fromMap(Map<dynamic, dynamic> data) =>
      DatabaseOrderItem(
          color: data["color"].toString(),
          shirtId: data['shirtId'],
          size_id: data['size_id'],
          id: data['id'],
          price: data['price'].toString(),
          quantity: data['quantity'],
          shirt: data['shirt'].toString(),
          size: data['size'].toString());

  Map<String, dynamic> toJson() => _$DatabaseOrderItemToJson(this);

  factory DatabaseOrderItem.fromJson(Map<String, dynamic> data) =>
      _$DatabaseOrderItemFromJson(data);
}
