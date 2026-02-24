import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_reward_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/wallet_repository.dart';

part 'user_rewards_event.dart';
part 'user_rewards_state.dart';

class UserRewardsBloc extends Bloc<UserRewardsEvent, UserRewardsState> {
  final WalletRepository _repository = WalletRepository();

  UserRewardsBloc() : super(const UserRewardsState()) {
    on<FetchWalletSummary>(_onFetchWalletSummary);
    on<FetchUserRewards>(_onFetchUserRewards);
    on<FetchRewardsByStatus>(_onFetchRewardsByStatus);
    on<ViewReward>(_onViewReward);
    on<ClaimReward>(_onClaimReward);
    on<MarkRewardRedeemed>(_onMarkRewardRedeemed);
    on<CopyRewardCode>(_onCopyRewardCode);
    on<RefreshRewards>(_onRefreshRewards);
  }

  Future<void> _onFetchWalletSummary(
    FetchWalletSummary event,
    Emitter<UserRewardsState> emit,
  ) async {
    emit(state.copyWith(status: UserRewardsStatus.loading));
    
    try {
      final summary = await _repository.getWalletSummary();
      
      emit(state.copyWith(
        status: UserRewardsStatus.success,
        walletSummary: summary,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserRewardsStatus.failure,
        errorMessage: 'Failed to load wallet: $e',
      ));
    }
  }

  Future<void> _onFetchUserRewards(
    FetchUserRewards event,
    Emitter<UserRewardsState> emit,
  ) async {
    emit(state.copyWith(status: UserRewardsStatus.loading));
    
    try {
      final rewards = await _repository.getUserRewards();
      final summary = await _repository.getWalletSummary();
      
      emit(state.copyWith(
        status: UserRewardsStatus.success,
        rewards: rewards,
        walletSummary: summary,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserRewardsStatus.failure,
        errorMessage: 'Failed to load rewards: $e',
      ));
    }
  }

  Future<void> _onFetchRewardsByStatus(
    FetchRewardsByStatus event,
    Emitter<UserRewardsState> emit,
  ) async {
    emit(state.copyWith(status: UserRewardsStatus.loading));
    
    try {
      final rewards = await _repository.getUserRewards(status: event.status);
      
      emit(state.copyWith(
        status: UserRewardsStatus.success,
        rewards: rewards,
        currentFilter: event.status,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserRewardsStatus.failure,
        errorMessage: 'Failed to load rewards: $e',
      ));
    }
  }

  Future<void> _onViewReward(
    ViewReward event,
    Emitter<UserRewardsState> emit,
  ) async {
    try {
      await _repository.markRewardAsViewed(event.rewardId);
      
      final updatedRewards = state.rewards.map((reward) {
        if (reward.id == event.rewardId) {
          return UserReward(
            id: reward.id,
            reward: reward.reward,
            status: 'viewed',
            unlockedAt: reward.unlockedAt,
            viewedAt: DateTime.now(),
            claimedAt: reward.claimedAt,
            redeemedAt: reward.redeemedAt,
            expiresAt: reward.expiresAt,
            code: reward.code,
            shippingStatus: reward.shippingStatus,
            trackingNumber: reward.trackingNumber,
            shippingAddress: reward.shippingAddress,
          );
        }
        return reward;
      }).toList();
      
      emit(state.copyWith(
        rewards: updatedRewards,
        selectedReward: event.reward,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to view reward: $e',
      ));
    }
  }

  Future<void> _onClaimReward(
    ClaimReward event,
    Emitter<UserRewardsState> emit,
  ) async {
    emit(state.copyWith(claimStatus: ClaimStatus.loading));
    
    try {
      final claimedReward = await _repository.claimReward(event.rewardId);
      
      final updatedRewards = state.rewards.map((reward) {
        if (reward.id == event.rewardId) {
          return claimedReward;
        }
        return reward;
      }).toList();
      
      emit(state.copyWith(
        rewards: updatedRewards,
        claimStatus: ClaimStatus.success,
        selectedReward: claimedReward,
      ));
    } catch (e) {
      emit(state.copyWith(
        claimStatus: ClaimStatus.failure,
        errorMessage: 'Failed to claim reward: $e',
      ));
    }
  }

  Future<void> _onMarkRewardRedeemed(
    MarkRewardRedeemed event,
    Emitter<UserRewardsState> emit,
  ) async {
    try {
      await _repository.markRewardAsRedeemed(event.rewardId);
      
      final updatedRewards = state.rewards.map((reward) {
        if (reward.id == event.rewardId) {
          return UserReward(
            id: reward.id,
            reward: reward.reward,
            status: 'redeemed',
            unlockedAt: reward.unlockedAt,
            viewedAt: reward.viewedAt,
            claimedAt: reward.claimedAt,
            redeemedAt: DateTime.now(),
            expiresAt: reward.expiresAt,
            code: reward.code,
            shippingStatus: reward.shippingStatus,
            trackingNumber: reward.trackingNumber,
            shippingAddress: reward.shippingAddress,
          );
        }
        return reward;
      }).toList();
      
      emit(state.copyWith(rewards: updatedRewards));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to mark reward as redeemed: $e',
      ));
    }
  }

  void _onCopyRewardCode(
    CopyRewardCode event,
    Emitter<UserRewardsState> emit,
  ) {
    emit(state.copyWith(
      copiedCode: event.code,
      copySuccess: true,
    ));
    
    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(copySuccess: false));
    });
  }

  Future<void> _onRefreshRewards(
    RefreshRewards event,
    Emitter<UserRewardsState> emit,
  ) async {
    add(const FetchUserRewards());
  }
}
