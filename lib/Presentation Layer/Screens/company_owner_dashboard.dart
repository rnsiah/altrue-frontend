import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/company_impact_bloc/company_impact_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_dashboard_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_company_impact_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

class CompanyOwnerDashboard extends StatefulWidget {
  final ForProfitCompany company;
  final Profile profile;

  const CompanyOwnerDashboard({
    super.key,
    required this.company,
    required this.profile,
  });

  @override
  State<CompanyOwnerDashboard> createState() => _CompanyOwnerDashboardState();
}

class _CompanyOwnerDashboardState extends State<CompanyOwnerDashboard> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyImpactBloc>().add(
          FetchCompanyDashboard(company: widget.company),
        );
  }

  @override
  Widget build(BuildContext context) {
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
            variant: GlassButtonVariant.glass,
          ),
          actions: [
            GlassIconButton(
              icon: Icons.refresh,
              onPressed: () {
                context
                    .read<CompanyImpactBloc>()
                    .add(const RefreshImpactData());
              },
              variant: GlassButtonVariant.glass,
            ),
            const SizedBox(width: GlassmorphismTheme.sm),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                GlassmorphismTheme.darkPrimary,
                GlassmorphismTheme.darkSecondary,
              ],
            ),
          ),
          child: BlocBuilder<CompanyImpactBloc, CompanyImpactState>(
            builder: (context, state) {
              if (state.status == CompanyImpactStatus.loading) {
                return Center(
                  child: GlassCard(
                    padding: const EdgeInsets.all(GlassmorphismTheme.xl),
                    child: const CircularProgressIndicator(
                      color: GlassmorphismTheme.gold,
                    ),
                  ),
                );
              }

              if (state.status == CompanyImpactStatus.failure) {
                return Center(
                  child: GlassCard(
                    padding: const EdgeInsets.all(GlassmorphismTheme.xl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),
                        Text(
                          state.errorMessage ?? 'Failed to load dashboard',
                          style: GlassmorphismTheme.bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),
                        GlassButton(
                          text: 'Retry',
                          onPressed: () {
                            context.read<CompanyImpactBloc>().add(
                                  FetchCompanyDashboard(
                                      company: widget.company),
                                );
                          },
                          variant: GlassButtonVariant.primary,
                        ),
                      ],
                    ),
                  ),
                );
              }

              final dashboard = state.companyDashboard;
              if (dashboard == null) {
                return Center(
                  child: GlassCard(
                    padding: const EdgeInsets.all(GlassmorphismTheme.xl),
                    child: Text(
                      'No dashboard data available',
                      style: GlassmorphismTheme.bodyStyle,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  _buildViewOnlyBanner(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildCompanyHeader(),
                        ),
                        SliverToBoxAdapter(
                          child: _buildStatsGrid(dashboard),
                        ),
                        SliverToBoxAdapter(
                          child: _buildActiveCampaigns(dashboard),
                        ),
                        SliverToBoxAdapter(
                          child: _buildWalletCard(dashboard),
                        ),
                        SliverToBoxAdapter(
                          child: _buildRecentMatches(dashboard),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(bottom: 100),
                        ),
                      ],
                    ),
                  ),
                  _buildFixedFooter(),
                ],
              );
            },
          ),
        ));
  }

  Widget _buildViewOnlyBanner() {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      gradient: GlassmorphismTheme.goldGradient,
      borderRadius: GlassmorphismTheme.radiusMd,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.visibility,
              color: GlassmorphismTheme.darkPrimary, size: 16),
          SizedBox(width: GlassmorphismTheme.sm),
          Text(
            'VIEW-ONLY MODE',
            style: TextStyle(
              color: GlassmorphismTheme.darkPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      child: Column(
        children: [
          if (widget.company.logo != null)
            CircleAvatar(
              backgroundImage: NetworkImage(widget.company.logo!),
              radius: 40,
              backgroundColor: GlassmorphismTheme.glassWhite,
            ),
          const SizedBox(height: GlassmorphismTheme.md),
          Text(
            widget.company.name,
            style: GlassmorphismTheme.h1Style,
          ),
          const SizedBox(height: GlassmorphismTheme.xs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: GlassmorphismTheme.goldGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Your Company',
              style: TextStyle(
                color: GlassmorphismTheme.darkPrimary,
                fontSize: GlassmorphismTheme.captionSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(CompanyDashboard dashboard) {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Month',
            style: GlassmorphismTheme.h2Style.copyWith(
              color: GlassmorphismTheme.gold,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: GlassmorphismTheme.md,
            mainAxisSpacing: GlassmorphismTheme.md,
            children: [
              _buildStatCard(
                'Matched',
                '\$${_formatCurrency(dashboard.matchedThisMonth)}',
                Icons.favorite,
                GlassmorphismTheme.gold,
              ),
              _buildStatCard(
                'Remaining',
                '\$${_formatCurrency(dashboard.budgetRemaining)}',
                Icons.account_balance_wallet,
                dashboard.isNearBudgetLimit ? Colors.orange : Colors.green,
              ),
              _buildStatCard(
                'Donors',
                dashboard.uniqueDonors.toString(),
                Icons.people,
                Colors.blue,
              ),
              _buildStatCard(
                'Campaigns',
                dashboard.activeCampaigns.length.toString(),
                Icons.campaign,
                Colors.purple,
              ),
            ],
          ),
          if (dashboard.monthlyBudget > 0) ...[
            const SizedBox(height: GlassmorphismTheme.md),
            _buildProgressBar(dashboard),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(GlassmorphismTheme.md),
      hasGoldBorder: color == GlassmorphismTheme.gold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const Spacer(),
          Text(
            value,
            style: GlassmorphismTheme.h2Style.copyWith(
              color: GlassmorphismTheme.textPrimary,
            ),
          ),
          Text(
            label,
            style: GlassmorphismTheme.captionStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(CompanyDashboard dashboard) {
    final percentage = dashboard.monthlyProgress / 100;

    return GlassCard(
      padding: const EdgeInsets.all(GlassmorphismTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Budget Progress',
                style: GlassmorphismTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${dashboard.monthlyProgress.toStringAsFixed(1)}%',
                style: GlassmorphismTheme.bodyStyle.copyWith(
                  color: GlassmorphismTheme.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: GlassmorphismTheme.darkTertiary,
              valueColor: AlwaysStoppedAnimation<Color>(
                dashboard.isNearBudgetLimit ? Colors.orange : Colors.green,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          Text(
            '\$${_formatCurrency(dashboard.matchedThisMonth)} of \$${_formatCurrency(dashboard.monthlyBudget)}',
            style: GlassmorphismTheme.captionStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCampaigns(CompanyDashboard dashboard) {
    if (dashboard.activeCampaigns.isEmpty) {
      return const SizedBox.shrink();
    }

    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Campaigns',
            style: GlassmorphismTheme.h2Style.copyWith(
              color: GlassmorphismTheme.gold,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          ...dashboard.activeCampaigns
              .map((campaign) => _CampaignCard(campaign: campaign)),
        ],
      ),
    );
  }

  Widget _buildWalletCard(CompanyDashboard dashboard) {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      gradient: GlassmorphismTheme.goldGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wallet Balance',
                style: GlassmorphismTheme.bodyStyle.copyWith(
                  color: GlassmorphismTheme.darkPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (dashboard.autoRefillEnabled)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: GlassmorphismTheme.darkPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sync,
                          color: GlassmorphismTheme.darkPrimary, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'Auto-refill ON',
                        style: TextStyle(
                          color: GlassmorphismTheme.darkPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          Text(
            '\$${_formatCurrency(dashboard.walletBalance)}',
            style: TextStyle(
              color: GlassmorphismTheme.darkPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          Text(
            'Available for matching donations',
            style: TextStyle(
              color: GlassmorphismTheme.darkPrimary.withOpacity(0.8),
              fontSize: GlassmorphismTheme.captionSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMatches(CompanyDashboard dashboard) {
    if (dashboard.recentMatches.isEmpty) {
      return const SizedBox.shrink();
    }

    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Matches',
                style: GlassmorphismTheme.h2Style.copyWith(
                  color: GlassmorphismTheme.gold,
                ),
              ),
              GlassButton(
                text: 'See All',
                onPressed: () {
                  // Navigate to full matches history
                },
                variant: GlassButtonVariant.secondary,
              ),
            ],
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          ...dashboard.recentMatches
              .take(5)
              .map((match) => _RecentMatchCard(match: match)),
        ],
      ),
    );
  }

  Widget _buildFixedFooter() {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      gradient: GlassmorphismTheme.glassGradientStrong,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'To create campaigns or manage settings,',
              style: GlassmorphismTheme.captionStyle,
            ),
            const SizedBox(height: GlassmorphismTheme.md),
            GlassButton(
              text: 'Manage on Web',
              onPressed: () async {
                final url = Uri.parse('https://dashboard.altrue.global');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              variant: GlassButtonVariant.primary,
              isFullWidth: true,
              trailingIcon: Icons.open_in_new,
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(value);
  }
}

class _CampaignCard extends StatelessWidget {
  final CompanyCampaign campaign;

  const _CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    final progress = campaign.budgetCap > 0
        ? (campaign.amountMatched / campaign.budgetCap).clamp(0.0, 1.0)
        : 0.0;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
      hasGoldBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  campaign.name,
                  style: GlassmorphismTheme.h3Style,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: GlassmorphismTheme.goldGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${campaign.matchMultiplier}x Match',
                  style: TextStyle(
                    color: GlassmorphismTheme.darkPrimary,
                    fontSize: GlassmorphismTheme.captionSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (campaign.description != null) ...[
            const SizedBox(height: GlassmorphismTheme.xs),
            Text(
              campaign.description!,
              style: GlassmorphismTheme.captionStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: GlassmorphismTheme.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: GlassmorphismTheme.darkTertiary,
              valueColor: AlwaysStoppedAnimation<Color>(
                campaign.isFullyMatched ? Colors.orange : Colors.green,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_formatCurrency(campaign.amountMatched)} of \$${_formatCurrency(campaign.budgetCap)}',
                style: GlassmorphismTheme.captionStyle,
              ),
              if (campaign.daysRemaining != null)
                Text(
                  '${campaign.daysRemaining} days left',
                  style: TextStyle(
                    color: campaign.daysRemaining! < 7
                        ? Colors.orange
                        : Colors.green,
                    fontSize: GlassmorphismTheme.captionSize,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(value);
  }
}

class _RecentMatchCard extends StatelessWidget {
  final RecentMatch match;

  const _RecentMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: GlassmorphismTheme.sm),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: GlassmorphismTheme.gold.withOpacity(0.2),
            child: const Icon(Icons.favorite,
                color: GlassmorphismTheme.gold, size: 16),
          ),
          const SizedBox(width: GlassmorphismTheme.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.donorName,
                  style: GlassmorphismTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  match.nonprofitName ?? match.causeName ?? 'Donation',
                  style: GlassmorphismTheme.captionStyle,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+\$${_formatCurrency(match.matchAmount)}',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: GlassmorphismTheme.bodySize,
                ),
              ),
              Text(
                _formatTimeAgo(match.createdAt),
                style: TextStyle(
                  color: GlassmorphismTheme.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(value);
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
