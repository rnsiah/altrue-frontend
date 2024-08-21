// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      shirts: (json['shirts'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['pk'] as num).toInt(),
      orderDate: json['start_date'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'shirts': instance.shirts.map((e) => e.toJson()).toList(),
      'pk': instance.id,
      'start_date': instance.orderDate,
    };
