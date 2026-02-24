part of 'user_rewards_bloc.dart';

enum UserRewardsStatus { initial, loading, success, failure }
enum ClaimStatus { initial, loading, success, failure }

class UserRewardsState extends Equatable {
  final List<UserReward> rewards;
  final UserRewardsStatus status;
  final String? errorMessage;
  final WalletSummary? walletSummary;
  final UserReward? selectedReward;
  final String? currentFilter;
  final ClaimStatus claimStatus;
  final String? copiedCode;
  final bool copySuccess;

  const UserRewardsState({
    this.rewards = const [],
    this.status = UserRewardsStatus.initial,
    this.errorMessage,
    this.walletSummary,
    this.selectedReward,
    this.currentFilter,
    this.claimStatus = ClaimStatus.initial,
    this.copiedCode,
    this.copySuccess = false,
  });

  UserRewardsState copyWith({
    List<UserReward>? rewards,
    UserRewardsStatus? status,
    String? errorMessage,
    WalletSummary? walletSummary,
    UserReward? selectedReward,
    String? currentFilter,
    ClaimStatus? claimStatus,
    String? copiedCode,
    bool? copySuccess,
  }) {
    return UserRewardsState(
      rewards: rewards ?? this.rewards,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      walletSummary: walletSummary ?? this.walletSummary,
      selectedReward: selectedReward ?? this.selectedReward,
      currentFilter: currentFilter ?? this.currentFilter,
      claimStatus: claimStatus ?? this.claimStatus,
      copiedCode: copiedCode ?? this.copiedCode,
      copySuccess: copySuccess ?? this.copySuccess,
    );
  }

  @override
  List<Object?> get props => [
        rewards,
        status,
        errorMessage,
        walletSummary,
        selectedReward,
        currentFilter,
        claimStatus,
        copiedCode,
        copySuccess,
      ];

  List<UserReward> get newRewards => 
      rewards.where((r) => r.status == 'unlocked').toList();
  
  List<UserReward> get readyRewards => 
      rewards.where((r) => r.status == 'viewed').toList();
  
  List<UserReward> get claimedRewards => 
      rewards.where((r) => r.status == 'claimed').toList();
  
  List<UserReward> get redeemedRewards => 
      rewards.where((r) => r.status == 'redeemed' || r.status == 'expired').toList();
}
