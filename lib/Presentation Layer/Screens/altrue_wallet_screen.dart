import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_rewards_bloc/user_rewards_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_reward_model.dart';

class AltrueWalletScreen extends StatefulWidget {
  final Profile profile;

  const AltrueWalletScreen({super.key, required this.profile});

  @override
  State<AltrueWalletScreen> createState() => _AltrueWalletScreenState();
}

class _AltrueWalletScreenState extends State<AltrueWalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<UserRewardsBloc>().add(const FetchUserRewards());
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      String filter;
      switch (_tabController.index) {
        case 0:
          filter = 'unlocked';
          break;
        case 1:
          filter = 'viewed';
          break;
        case 2:
          filter = 'claimed';
          break;
        case 3:
          filter = 'all';
          break;
        default:
          filter = 'all';
      }
      if (filter != 'all') {
        context.read<UserRewardsBloc>().add(FetchRewardsByStatus(status: filter));
      } else {
        context.read<UserRewardsBloc>().add(const FetchUserRewards());
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
          height: 40,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          _buildWalletHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRewardsList('unlocked'),
                _buildRewardsList('viewed'),
                _buildRewardsList('claimed'),
                _buildRewardsList('all'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletHeader() {
    return BlocBuilder<UserRewardsBloc, UserRewardsState>(
      builder: (context, state) {
        final summary = state.walletSummary;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Altrue Wallet',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard(
                    'Points',
                    summary?.pointsBalance.toString() ?? '0',
                    Icons.stars,
                  ),
                  _buildStatCard(
                    'Active',
                    summary?.activeRewardsCount.toString() ?? '0',
                    Icons.card_giftcard,
                  ),
                  _buildStatCard(
                    'New',
                    summary?.newUnlocksCount.toString() ?? '0',
                    Icons.new_releases,
                    isHighlighted: (summary?.newUnlocksCount ?? 0) > 0,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.amber.withOpacity(0.2) : Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        border: isHighlighted
            ? Border.all(color: Colors.amber, width: 2)
            : null,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isHighlighted ? Colors.amber : Colors.white70,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: isHighlighted ? Colors.amber : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isHighlighted ? Colors.amber.withOpacity(0.8) : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white70,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'New'),
          Tab(text: 'Ready'),
          Tab(text: 'Claimed'),
          Tab(text: 'History'),
        ],
      ),
    );
  }

  Widget _buildRewardsList(String filter) {
    return BlocBuilder<UserRewardsBloc, UserRewardsState>(
      builder: (context, state) {
        if (state.status == UserRewardsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }

        if (state.status == UserRewardsStatus.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Failed to load rewards',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<UserRewardsBloc>().add(const RefreshRewards());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  child: const Text('Retry', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          );
        }

        List<UserReward> rewards;
        switch (filter) {
          case 'unlocked':
            rewards = state.newRewards;
            break;
          case 'viewed':
            rewards = state.readyRewards;
            break;
          case 'claimed':
            rewards = state.claimedRewards;
            break;
          default:
            rewards = state.rewards;
        }

        if (rewards.isEmpty) {
          return _buildEmptyState(filter);
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            return _RewardCard(
              reward: rewards[index],
              onTap: () => _showRewardDetail(context, rewards[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String filter) {
    String message;
    IconData icon;
    
    switch (filter) {
      case 'unlocked':
        message = 'No new rewards yet!\nKeep donating to unlock rewards.';
        icon = Icons.card_giftcard;
        break;
      case 'viewed':
        message = 'No rewards ready to claim.';
        icon = Icons.check_circle_outline;
        break;
      case 'claimed':
        message = 'No active rewards.';
        icon = Icons.local_offer;
        break;
      default:
        message = 'Your reward history is empty.';
        icon = Icons.history;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber.withOpacity(0.5), size: 64),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _showRewardDetail(BuildContext context, UserReward reward) {
    if (reward.isUnlocked) {
      context.read<UserRewardsBloc>().add(ViewReward(
        rewardId: reward.id,
        reward: reward,
      ));
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _RewardDetailSheet(reward: reward),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final UserReward reward;
  final VoidCallback onTap;

  const _RewardCard({required this.reward, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final companyReward = reward.reward;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
          border: reward.isUnlocked
              ? Border.all(color: Colors.amber, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (companyReward.imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  companyReward.imageUrl!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (companyReward.company.logo != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(companyReward.company.logo!),
                          radius: 16,
                          backgroundColor: Colors.white,
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          companyReward.company.name,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildStatusBadge(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    companyReward.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    companyReward.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (reward.isUnlocked) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.new_releases, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Tap to view and claim',
                          style: TextStyle(
                            color: Colors.amber.withOpacity(0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;
    String text;

    switch (reward.status) {
      case 'unlocked':
        bgColor = Colors.amber;
        textColor = Colors.black;
        text = 'NEW';
        break;
      case 'viewed':
        bgColor = Colors.orange;
        textColor = Colors.white;
        text = 'READY';
        break;
      case 'claimed':
        bgColor = Colors.green;
        textColor = Colors.white;
        text = reward.isPhysical ? 'PROCESSING' : 'ACTIVE';
        break;
      case 'redeemed':
        bgColor = Colors.blue;
        textColor = Colors.white;
        text = 'USED';
        break;
      case 'expired':
        bgColor = Colors.red;
        textColor = Colors.white;
        text = 'EXPIRED';
        break;
      default:
        bgColor = Colors.grey;
        textColor = Colors.white;
        text = reward.status.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _RewardDetailSheet extends StatelessWidget {
  final UserReward reward;

  const _RewardDetailSheet({required this.reward});

  @override
  Widget build(BuildContext context) {
    final companyReward = reward.reward;
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (companyReward.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        companyReward.imageUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (companyReward.company.logo != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(companyReward.company.logo!),
                          radius: 24,
                          backgroundColor: Colors.white,
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              companyReward.company.name,
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              companyReward.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    companyReward.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailSection(),
                  const SizedBox(height: 24),
                  _buildActionButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection() {
    if (reward.isClaimed && reward.code != null) {
      return _buildDigitalRewardCode();
    } else if (reward.isClaimed && reward.isPhysical) {
      return _buildPhysicalRewardStatus();
    } else if (reward.isUnlocked || reward.isViewed) {
      return _buildUnlockInfo();
    }
    return const SizedBox.shrink();
  }

  Widget _buildDigitalRewardCode() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Reward Code',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    reward.code!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              BlocBuilder<UserRewardsBloc, UserRewardsState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: reward.code!));
                      context.read<UserRewardsBloc>().add(
                        CopyRewardCode(code: reward.code!),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Code copied to clipboard!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: Icon(
                      state.copySuccess ? Icons.check : Icons.copy,
                      color: state.copySuccess ? Colors.green : Colors.amber,
                    ),
                  );
                },
              ),
            ],
          ),
          if (reward.expiresAt != null) ...[
            const SizedBox(height: 12),
            Text(
              'Expires: ${_formatDate(reward.expiresAt!)}',
              style: TextStyle(
                color: Colors.red[300],
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPhysicalRewardStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Status',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                _getShippingIcon(),
                color: _getShippingColor(),
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reward.shippingStatus?.toUpperCase() ?? 'PROCESSING',
                      style: TextStyle(
                        color: _getShippingColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (reward.trackingNumber != null)
                      Text(
                        'Tracking: ${reward.trackingNumber}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (reward.shippingAddress != null) ...[
            const SizedBox(height: 12),
            Text(
              'Shipping to: ${reward.shippingAddress}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUnlockInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_open, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reward Unlocked!',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Unlocked on ${_formatDate(reward.unlockedAt)}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (reward.isUnlocked || reward.isViewed) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.read<UserRewardsBloc>().add(ClaimReward(rewardId: reward.id));
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Claim Reward',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (reward.isClaimed && !reward.isRedeemed) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.read<UserRewardsBloc>().add(
              MarkRewardRedeemed(rewardId: reward.id),
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Mark as Used',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  IconData _getShippingIcon() {
    switch (reward.shippingStatus?.toLowerCase()) {
      case 'shipped':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      default:
        return Icons.inventory;
    }
  }

  Color _getShippingColor() {
    switch (reward.shippingStatus?.toLowerCase()) {
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
