import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  List<OrderItem> shirts;
  @JsonKey(name: 'pk')
  int? id;
  @JsonKey(name: 'start_date')
  @JsonKey(name: 'ordered_date')
  String? orderDate;
  String? status;
  String? carrier;
  @JsonKey(name: 'tracking_number')
  String? trackingNumber;


  Order({this.carrier, this.trackingNumber, this.status,
    required this.shirts,
    required this.id,
    required this.orderDate,
  });
  factory Order.fromJson(Map<String, dynamic> data) => _$OrderFromJson(data);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
