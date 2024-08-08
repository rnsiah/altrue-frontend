import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  List<OrderItem> shirts;

  Order({required this.shirts});

  factory Order.fromJson(Map<String, dynamic> data) => _$OrderFromJson(data);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
