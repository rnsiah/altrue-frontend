import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  List<OrderItem> shirts;
  @JsonKey(name: 'pk')
  int id;
  @JsonKey(name: 'start_date')
  String orderDate;

  Order({required this.shirts, required this.id, required this.orderDate});

  factory Order.fromJson(Map<String, dynamic> data) => _$OrderFromJson(data);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
