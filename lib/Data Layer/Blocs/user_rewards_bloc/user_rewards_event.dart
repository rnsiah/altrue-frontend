part of 'user_rewards_bloc.dart';

abstract class UserRewardsEvent extends Equatable {
  const UserRewardsEvent();

  @override
  List<Object?> get props => [];
}

class FetchWalletSummary extends UserRewardsEvent {
  const FetchWalletSummary();
}

class FetchUserRewards extends UserRewardsEvent {
  const FetchUserRewards();
}

class FetchRewardsByStatus extends UserRewardsEvent {
  final String status;

  const FetchRewardsByStatus({required this.status});

  @override
  List<Object?> get props => [status];
}

class ViewReward extends UserRewardsEvent {
  final int rewardId;
  final UserReward reward;

  const ViewReward({required this.rewardId, required this.reward});

  @override
  List<Object?> get props => [rewardId, reward];
}

class ClaimReward extends UserRewardsEvent {
  final int rewardId;

  const ClaimReward({required this.rewardId});

  @override
  List<Object?> get props => [rewardId];
}

class MarkRewardRedeemed extends UserRewardsEvent {
  final int rewardId;

  const MarkRewardRedeemed({required this.rewardId});

  @override
  List<Object?> get props => [rewardId];
}

class CopyRewardCode extends UserRewardsEvent {
  final String code;

  const CopyRewardCode({required this.code});

  @override
  List<Object?> get props => [code];
}

class RefreshRewards extends UserRewardsEvent {
  const RefreshRewards();
}
