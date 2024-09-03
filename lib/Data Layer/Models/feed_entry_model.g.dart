// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItem _$FeedItemFromJson(Map<String, dynamic> json) => FeedItem(
      username: json['username'] as String?,
      receiverUsername: json['receiver_username'] as String?,
      requirement: json['requirement'] as String?,
        pointAmount: json['amount'] != null
          ? int.tryParse(json['amount'].toString())
          : null,
      description: json['description'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      isPromotion: json['is_promotion'] as bool?,
           donationAmount: json['donation_amount'] != null
          ? double.tryParse(json['donation_amount'].toString())
          : null,

    );

Map<String, dynamic> _$FeedItemToJson(FeedItem instance) => <String, dynamic>{
      'username': instance.username,
      'requirement': instance.requirement,
      'amount': instance.pointAmount,
      'receiver_username': instance.receiverUsername,
      'description': instance.description,
      'timestamp': instance.timestamp?.toIso8601String(),
      'is_promotion': instance.isPromotion,
      'donation_amount': instance.donationAmount,
    };
