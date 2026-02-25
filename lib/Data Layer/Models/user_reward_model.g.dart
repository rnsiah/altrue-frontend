// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReward _$UserRewardFromJson(Map<String, dynamic> json) => UserReward(
      id: (json['id'] as num).toInt(),
      reward: CompanyReward.fromJson(json['reward'] as Map<String, dynamic>),
      status: json['status'] as String,
      unlockedAt: DateTime.parse(json['unlocked_at'] as String),
      viewedAt: json['viewed_at'] == null
          ? null
          : DateTime.parse(json['viewed_at'] as String),
      claimedAt: json['claimed_at'] == null
          ? null
          : DateTime.parse(json['claimed_at'] as String),
      redeemedAt: json['redeemed_at'] == null
          ? null
          : DateTime.parse(json['redeemed_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      code: json['code'] as String?,
      shippingStatus: json['shipping_status'] as String?,
      trackingNumber: json['tracking_number'] as String?,
      shippingAddress: json['shipping_address'] as String?,
    );

Map<String, dynamic> _$UserRewardToJson(UserReward instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reward': instance.reward.toJson(),
      'status': instance.status,
      'unlocked_at': instance.unlockedAt.toIso8601String(),
      'viewed_at': instance.viewedAt?.toIso8601String(),
      'claimed_at': instance.claimedAt?.toIso8601String(),
      'redeemed_at': instance.redeemedAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'code': instance.code,
      'shipping_status': instance.shippingStatus,
      'tracking_number': instance.trackingNumber,
      'shipping_address': instance.shippingAddress,
    };

CompanyReward _$CompanyRewardFromJson(Map<String, dynamic> json) =>
    CompanyReward(
      id: (json['id'] as num).toInt(),
      company:
          ForProfitCompany.fromJson(json['company'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String,
      rewardType: json['reward_type'] as String,
      imageUrl: json['image_url'] as String?,
      minDonationAmount: (json['min_donation_amount'] as num?)?.toDouble(),
      minAltrueLevel: (json['min_altrue_level'] as num?)?.toInt(),
      isAvailable: json['is_available'] as bool,
      totalQuantity: (json['total_quantity'] as num?)?.toInt(),
      claimedCount: (json['claimed_count'] as num?)?.toInt(),
      expirationDays: (json['expiration_days'] as num?)?.toInt(),
      termsConditions: json['terms_conditions'] as String?,
    );

Map<String, dynamic> _$CompanyRewardToJson(CompanyReward instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company.toJson(),
      'name': instance.name,
      'description': instance.description,
      'reward_type': instance.rewardType,
      'image_url': instance.imageUrl,
      'min_donation_amount': instance.minDonationAmount,
      'min_altrue_level': instance.minAltrueLevel,
      'is_available': instance.isAvailable,
      'total_quantity': instance.totalQuantity,
      'claimed_count': instance.claimedCount,
      'expiration_days': instance.expirationDays,
      'terms_conditions': instance.termsConditions,
    };

WalletSummary _$WalletSummaryFromJson(Map<String, dynamic> json) =>
    WalletSummary(
      pointsBalance: (json['points_balance'] as num).toInt(),
      activeRewardsCount: (json['active_rewards_count'] as num).toInt(),
      newUnlocksCount: (json['new_unlocks_count'] as num).toInt(),
      totalRewardsEarned: (json['total_rewards_earned'] as num).toInt(),
      totalRewardsRedeemed: (json['total_rewards_redeemed'] as num).toInt(),
    );

Map<String, dynamic> _$WalletSummaryToJson(WalletSummary instance) =>
    <String, dynamic>{
      'points_balance': instance.pointsBalance,
      'active_rewards_count': instance.activeRewardsCount,
      'new_unlocks_count': instance.newUnlocksCount,
      'total_rewards_earned': instance.totalRewardsEarned,
      'total_rewards_redeemed': instance.totalRewardsRedeemed,
    };
