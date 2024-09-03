import 'package:json_annotation/json_annotation.dart';
part 'feed_entry_model.g.dart';


@JsonSerializable()
class FeedItem{
final String? username;
  
  final String? requirement;
  @JsonKey(name:'amount')
  final int? pointAmount;
  @JsonKey(name:'receiver_username')
  final String? receiverUsername;
  final String? description;
  final DateTime? timestamp;
  @JsonKey(name:'is_promotion')
  final bool? isPromotion;
  @JsonKey(name:'donation_amount')
  final double? donationAmount;
  // final String type; // 'point' or 'donation'

  FeedItem({
    this.username,
    this.receiverUsername,
    this.requirement,
    this.pointAmount,
    this.description,
    this.timestamp,
    this.isPromotion,
    this.donationAmount,
    // required this.type,
  });

  factory FeedItem.fromJson(Map<String, dynamic>data)=> _$FeedItemFromJson(data);

  Map<String, dynamic> toJson()=> _$FeedItemToJson(this);
}
