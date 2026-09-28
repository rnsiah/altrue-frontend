import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_rewards_bloc/user_rewards_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_reward_model.dart';
import '../../Theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

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
        context
            .read<UserRewardsBloc>()
            .add(FetchRewardsByStatus(status: filter));
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
    final theme = GlassmorphismTheme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
          height: 40,
        ),
        centerTitle: true,
        leading: GlassIconButton(
          icon: Icons.arrow_back,
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.darkGradient,
        ),
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).padding.top + kToolbarHeight),
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
      ),
    );
  }

  Widget _buildWalletHeader() {
    final theme = GlassmorphismTheme.of(context);

    return BlocBuilder<UserRewardsBloc, UserRewardsState>(
      builder: (context, state) {
        final summary = state.walletSummary;
        return GlassCard(
          margin: EdgeInsets.all(theme.spacing.medium),
          padding: EdgeInsets.all(theme.spacing.large),
          child: Column(
            children: [
              Text(
                'Altrue Wallet',
                style: TextStyle(
                  color: theme.goldColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: theme.spacing.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildGlassStatCard(
                    'Points',
                    summary?.pointsBalance.toString() ?? '0',
                    Icons.stars,
                    theme,
                  ),
                  _buildGlassStatCard(
                    'Active',
                    summary?.activeRewardsCount.toString() ?? '0',
                    Icons.card_giftcard,
                    theme,
                  ),
                  _buildGlassStatCard(
                    'New',
                    summary?.newUnlocksCount.toString() ?? '0',
                    Icons.new_releases,
                    theme,
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

  Widget _buildGlassStatCard(
      String label, String value, IconData icon, GlassmorphismTheme theme,
      {bool isHighlighted = false}) {
    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.medium,
        vertical: theme.spacing.small,
      ),
      borderColor: isHighlighted ? theme.goldColor : Colors.transparent,
      borderWidth: isHighlighted ? 2.0 : 0.0,
      child: Column(
        children: [
          Icon(
            icon,
            color: isHighlighted ? theme.goldColor : Colors.white70,
            size: 24,
          ),
          SizedBox(height: theme.spacing.xsmall),
          Text(
            value,
            style: TextStyle(
              color: isHighlighted ? theme.goldColor : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isHighlighted
                  ? theme.goldColor.withOpacity(0.8)
                  : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final theme = GlassmorphismTheme.of(context);

    return GlassCard(
      margin: EdgeInsets.all(theme.spacing.medium),
      padding: EdgeInsets.all(theme.spacing.xsmall),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.goldColor, theme.goldColor.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(10),
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
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                GlassmorphismTheme.of(context).goldColor,
              ),
            ),
          );
        }

        if (state.status == UserRewardsStatus.failure) {
          final theme = GlassmorphismTheme.of(context);
          return Center(
            child: GlassCard(
              margin: EdgeInsets.all(theme.spacing.large),
              padding: EdgeInsets.all(theme.spacing.large),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  SizedBox(height: theme.spacing.medium),
                  Text(
                    state.errorMessage ?? 'Failed to load rewards',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: theme.spacing.medium),
                  GlassButton(
                    onPressed: () {
                      context
                          .read<UserRewardsBloc>()
                          .add(const RefreshRewards());
                    },
                    text: 'Retry',
                  ),
                ],
              ),
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
    final theme = GlassmorphismTheme.of(context);

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
      child: GlassCard(
        margin: EdgeInsets.all(theme.spacing.large),
        padding: EdgeInsets.all(theme.spacing.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: theme.goldColor.withOpacity(0.7), size: 64),
            SizedBox(height: theme.spacing.medium),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
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
    final theme = GlassmorphismTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        margin: EdgeInsets.only(bottom: theme.spacing.medium),
        borderColor: reward.isUnlocked ? theme.goldColor : Colors.transparent,
        borderWidth: reward.isUnlocked ? 2.0 : 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (companyReward.imageUrl != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  companyReward.imageUrl!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(theme.spacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (companyReward.company.logo != null)
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(companyReward.company.logo!),
                          radius: 16,
                          backgroundColor: Colors.white,
                        ),
                      SizedBox(width: theme.spacing.xsmall),
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
                      _buildGlassStatusBadge(theme),
                    ],
                  ),
                  SizedBox(height: theme.spacing.xsmall),
                  Text(
                    companyReward.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: theme.spacing.xsmall / 2),
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
                    SizedBox(height: theme.spacing.small),
                    Row(
                      children: [
                        Icon(Icons.new_releases,
                            color: theme.goldColor, size: 16),
                        SizedBox(width: theme.spacing.xsmall / 2),
                        Text(
                          'Tap to view and claim',
                          style: TextStyle(
                            color: theme.goldColor.withOpacity(0.8),
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

  Widget _buildGlassStatusBadge(GlassmorphismTheme theme) {
    Color bgColor;
    Color textColor;
    String text;

    switch (reward.status) {
      case 'unlocked':
        bgColor = theme.goldColor;
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

    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.xsmall,
        vertical: theme.spacing.xsmall / 2,
      ),
      // color: bgColor.withOpacity(0.8),
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
    final theme = GlassmorphismTheme.of(context);

    return GlassCard(
      margin: EdgeInsets.zero,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
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
                padding: EdgeInsets.all(theme.spacing.large),
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
                    SizedBox(height: theme.spacing.large),
                    Row(
                      children: [
                        if (companyReward.company.logo != null)
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(companyReward.company.logo!),
                            radius: 24,
                            backgroundColor: Colors.white,
                          ),
                        SizedBox(width: theme.spacing.medium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                companyReward.company.name,
                                style: TextStyle(
                                  color: theme.goldColor,
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
                    SizedBox(height: theme.spacing.medium),
                    Text(
                      companyReward.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: theme.spacing.large),
                    _buildGlassDetailSection(theme),
                    SizedBox(height: theme.spacing.large),
                    _buildGlassActionButton(context, theme),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassDetailSection(GlassmorphismTheme theme) {
    if (reward.isClaimed && reward.code != null) {
      return _buildGlassDigitalRewardCode(theme);
    } else if (reward.isClaimed && reward.isPhysical) {
      return _buildGlassPhysicalRewardStatus(theme);
    } else if (reward.isUnlocked || reward.isViewed) {
      return _buildGlassUnlockInfo(theme);
    }
    return const SizedBox.shrink();
  }

  Widget _buildGlassDigitalRewardCode(GlassmorphismTheme theme) {
    return GlassCard(
      borderColor: theme.goldColor,
      borderWidth: 2.0,
      padding: EdgeInsets.all(theme.spacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Reward Code',
            style: TextStyle(
              color: theme.goldColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: theme.spacing.medium),
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.medium,
                    vertical: theme.spacing.small,
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
              SizedBox(width: theme.spacing.medium),
              BlocBuilder<UserRewardsBloc, UserRewardsState>(
                builder: (context, state) {
                  return GlassButton(
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
                    icon: state.copySuccess ? Icons.check : Icons.copy,
                  );
                },
              ),
            ],
          ),
          if (reward.expiresAt != null) ...[
            SizedBox(height: theme.spacing.medium),
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

  Widget _buildGlassPhysicalRewardStatus(GlassmorphismTheme theme) {
    return GlassCard(
      padding: EdgeInsets.all(theme.spacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Status',
            style: TextStyle(
              color: theme.goldColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: theme.spacing.medium),
          Row(
            children: [
              Icon(
                _getShippingIcon(),
                color: _getShippingColor(),
                size: 32,
              ),
              SizedBox(width: theme.spacing.medium),
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
            SizedBox(height: theme.spacing.medium),
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

  Widget _buildGlassUnlockInfo(GlassmorphismTheme theme) {
    return GlassCard(
      borderColor: theme.goldColor.withOpacity(0.5),
      borderWidth: 1.0,
      padding: EdgeInsets.all(theme.spacing.medium),
      child: Row(
        children: [
          Icon(Icons.lock_open, color: theme.goldColor),
          SizedBox(width: theme.spacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reward Unlocked!',
                  style: TextStyle(
                    color: theme.goldColor,
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

  Widget _buildGlassActionButton(
      BuildContext context, GlassmorphismTheme theme) {
    if (reward.isUnlocked || reward.isViewed) {
      return SizedBox(
        width: double.infinity,
        child: GlassButton(
          onPressed: () {
            context
                .read<UserRewardsBloc>()
                .add(ClaimReward(rewardId: reward.id));
            Navigator.pop(context);
          },
          variant: GlassButtonVariant.primary,
          isFullWidth: true,
          text: 'Claim Reward',
        ),
      );
    } else if (reward.isClaimed && !reward.isRedeemed) {
      return SizedBox(
        width: double.infinity,
        child: GlassButton(
          onPressed: () {
            context.read<UserRewardsBloc>().add(
                  MarkRewardRedeemed(rewardId: reward.id),
                );
            Navigator.pop(context);
          },
          backgroundColor: Colors.green,
          text: 'Mark as Used',
          textColor: Colors.white,
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
