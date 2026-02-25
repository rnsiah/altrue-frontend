import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';

part 'user_reward_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserReward {
  final int id;
  final CompanyReward reward;
  final String status;

  @JsonKey(name: 'unlocked_at')
  final DateTime unlockedAt;

  @JsonKey(name: 'viewed_at')
  final DateTime? viewedAt;

  @JsonKey(name: 'claimed_at')
  final DateTime? claimedAt;

  @JsonKey(name: 'redeemed_at')
  final DateTime? redeemedAt;

  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  final String? code;

  @JsonKey(name: 'shipping_status')
  final String? shippingStatus;

  @JsonKey(name: 'tracking_number')
  final String? trackingNumber;

  @JsonKey(name: 'shipping_address')
  final String? shippingAddress;

  UserReward({
    required this.id,
    required this.reward,
    required this.status,
    required this.unlockedAt,
    this.viewedAt,
    this.claimedAt,
    this.redeemedAt,
    this.expiresAt,
    this.code,
    this.shippingStatus,
    this.trackingNumber,
    this.shippingAddress,
  });

  factory UserReward.fromJson(Map<String, dynamic> json) =>
      _$UserRewardFromJson(json);

  Map<String, dynamic> toJson() => _$UserRewardToJson(this);

  bool get isLocked => status == 'locked';
  bool get isUnlocked => status == 'unlocked';
  bool get isViewed => status == 'viewed' || viewedAt != null;
  bool get isClaimed => status == 'claimed' || claimedAt != null;
  bool get isRedeemed => status == 'redeemed' || redeemedAt != null;
  bool get isExpired =>
      status == 'expired' ||
      (expiresAt != null && expiresAt!.isBefore(DateTime.now()));

  bool get isDigital => reward.rewardType == 'digital';
  bool get isPhysical => reward.rewardType == 'physical';
  bool get isExperience => reward.rewardType == 'experience';

  String get statusDisplay {
    switch (status) {
      case 'locked':
        return 'Locked';
      case 'unlocked':
        return 'New!';
      case 'viewed':
        return 'Ready to Claim';
      case 'claimed':
        return isPhysical ? 'Processing' : 'Active';
      case 'redeemed':
        return 'Used';
      case 'expired':
        return 'Expired';
      default:
        return status;
    }
  }

  Color get statusColor {
    switch (status) {
      case 'locked':
        return Colors.grey;
      case 'unlocked':
        return Colors.amber;
      case 'viewed':
        return Colors.orange;
      case 'claimed':
        return Colors.green;
      case 'redeemed':
        return Colors.blue;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

@JsonSerializable(explicitToJson: true)
class CompanyReward {
  final int id;
  final ForProfitCompany company;
  final String name;
  final String description;

  @JsonKey(name: 'reward_type')
  final String rewardType;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'min_donation_amount')
  final double? minDonationAmount;

  @JsonKey(name: 'min_altrue_level')
  final int? minAltrueLevel;

  @JsonKey(name: 'is_available')
  final bool isAvailable;

  @JsonKey(name: 'total_quantity')
  final int? totalQuantity;

  @JsonKey(name: 'claimed_count')
  final int? claimedCount;

  @JsonKey(name: 'expiration_days')
  final int? expirationDays;

  @JsonKey(name: 'terms_conditions')
  final String? termsConditions;

  CompanyReward({
    required this.id,
    required this.company,
    required this.name,
    required this.description,
    required this.rewardType,
    this.imageUrl,
    this.minDonationAmount,
    this.minAltrueLevel,
    required this.isAvailable,
    this.totalQuantity,
    this.claimedCount,
    this.expirationDays,
    this.termsConditions,
  });

  factory CompanyReward.fromJson(Map<String, dynamic> json) =>
      _$CompanyRewardFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyRewardToJson(this);

  bool get hasLimitedQuantity => totalQuantity != null && totalQuantity! > 0;

  int? get remainingQuantity {
    if (totalQuantity == null || claimedCount == null) return null;
    return totalQuantity! - claimedCount!;
  }

  bool get isOutOfStock => remainingQuantity != null && remainingQuantity! <= 0;

  String get formattedValue {
    if (name.toLowerCase().contains('%')) {
      return name;
    }
    if (name.toLowerCase().contains('\$')) {
      return name;
    }
    return name;
  }
}

@JsonSerializable(explicitToJson: true)
class WalletSummary {
  @JsonKey(name: 'points_balance')
  final int pointsBalance;

  @JsonKey(name: 'active_rewards_count')
  final int activeRewardsCount;

  @JsonKey(name: 'new_unlocks_count')
  final int newUnlocksCount;

  @JsonKey(name: 'total_rewards_earned')
  final int totalRewardsEarned;

  @JsonKey(name: 'total_rewards_redeemed')
  final int totalRewardsRedeemed;

  WalletSummary({
    required this.pointsBalance,
    required this.activeRewardsCount,
    required this.newUnlocksCount,
    required this.totalRewardsEarned,
    required this.totalRewardsRedeemed,
  });

  factory WalletSummary.fromJson(Map<String, dynamic> json) =>
      _$WalletSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$WalletSummaryToJson(this);
}
