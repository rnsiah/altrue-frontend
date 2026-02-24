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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.amber),
            onPressed: () {
              context.read<CompanyImpactBloc>().add(const RefreshImpactData());
            },
          ),
        ],
      ),
      body: BlocBuilder<CompanyImpactBloc, CompanyImpactState>(
        builder: (context, state) {
          if (state.status == CompanyImpactStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          }

          if (state.status == CompanyImpactStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? 'Failed to load dashboard',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CompanyImpactBloc>().add(
                        FetchCompanyDashboard(company: widget.company),
                      );
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

          final dashboard = state.companyDashboard;
          if (dashboard == null) {
            return const Center(
              child: Text(
                'No dashboard data available',
                style: TextStyle(color: Colors.white70),
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
    );
  }

  Widget _buildViewOnlyBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.amber,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.visibility, color: Colors.black, size: 16),
          SizedBox(width: 8),
          Text(
            'VIEW-ONLY MODE',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (widget.company.logo != null)
            CircleAvatar(
              backgroundImage: NetworkImage(widget.company.logo!),
              radius: 40,
              backgroundColor: Colors.white,
            ),
          const SizedBox(height: 12),
          Text(
            widget.company.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber),
            ),
            child: const Text(
              'Your Company',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(CompanyDashboard dashboard) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'This Month',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildStatCard(
                'Matched',
                '\$${_formatCurrency(dashboard.matchedThisMonth)}',
                Icons.favorite,
                Colors.red,
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
            const SizedBox(height: 16),
            _buildProgressBar(dashboard),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(CompanyDashboard dashboard) {
    final percentage = dashboard.monthlyProgress / 100;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Monthly Budget Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${dashboard.monthlyProgress.toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[700],
              valueColor: AlwaysStoppedAnimation<Color>(
                dashboard.isNearBudgetLimit ? Colors.orange : Colors.green,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_formatCurrency(dashboard.matchedThisMonth)} of \$${_formatCurrency(dashboard.monthlyBudget)}',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCampaigns(CompanyDashboard dashboard) {
    if (dashboard.activeCampaigns.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active Campaigns',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...dashboard.activeCampaigns.map((campaign) => _CampaignCard(campaign: campaign)),
        ],
      ),
    );
  }

  Widget _buildWalletCard(CompanyDashboard dashboard) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade700, Colors.amber.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wallet Balance',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (dashboard.autoRefillEnabled)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sync, color: Colors.black87, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Auto-refill ON',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$${_formatCurrency(dashboard.walletBalance)}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Available for matching donations',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentMatches(CompanyDashboard dashboard) {
    if (dashboard.recentMatches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Matches',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to full matches history
                },
                child: const Text(
                  'See All',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...dashboard.recentMatches.take(5).map((match) => _RecentMatchCard(match: match)),
        ],
      ),
    );
  }

  Widget _buildFixedFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'To create campaigns or manage settings,',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final url = Uri.parse('https://dashboard.altrue.global');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.open_in_new, color: Colors.black),
                label: const Text(
                  'Manage on Web',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  campaign.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${campaign.matchMultiplier}x Match',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (campaign.description != null) ...[
            const SizedBox(height: 4),
            Text(
              campaign.description!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[700],
              valueColor: AlwaysStoppedAnimation<Color>(
                campaign.isFullyMatched ? Colors.orange : Colors.green,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_formatCurrency(campaign.amountMatched)} of \$${_formatCurrency(campaign.budgetCap)}',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              if (campaign.daysRemaining != null)
                Text(
                  '${campaign.daysRemaining} days left',
                  style: TextStyle(
                    color: campaign.daysRemaining! < 7 ? Colors.orange : Colors.green,
                    fontSize: 12,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.amber.withOpacity(0.2),
            child: const Icon(Icons.favorite, color: Colors.amber, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.donorName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  match.nonprofitName ?? match.causeName ?? 'Donation',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+\$${_formatCurrency(match.matchAmount)}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _formatTimeAgo(match.createdAt),
                style: TextStyle(
                  color: Colors.white70,
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
