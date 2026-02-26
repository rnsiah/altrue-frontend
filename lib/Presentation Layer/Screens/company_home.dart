import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/company_campaigns_bloc/company_campaigns_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/company_impact_bloc/company_impact_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_campaign_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';
import 'package:intl/intl.dart';

class MyCompanyHome extends StatefulWidget {
  final Profile profile;
  final ForProfitCompany company;

  const MyCompanyHome(
      {super.key, required this.profile, required this.company});

  @override
  State<MyCompanyHome> createState() => _MyCompanyHomeState();
}

class _MyCompanyHomeState extends State<MyCompanyHome> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyCampaignsBloc>().add(
          FetchCompanyCampaigns(company: widget.company, activeOnly: true),
        );
  }

  bool get _isCompanyOwner {
    return widget.profile.username == widget.company.owner?.username ||
        widget.profile.user == widget.company.owner?.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
          ],
        ),
        actions: [
          if (_isCompanyOwner)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, color: Colors.amber, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'Your Company',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // Hero Section
          _buildHeroSection(),

          // Title Section
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TitleView(
              color: Colors.amber,
              company: widget.company,
              titleTxt: widget.company.name,
            ),
          ),

          // Mission & Description Section
          if (widget.company.mission != null ||
              widget.company.description != null)
            _buildMissionSection(),

          // Causes Supported
          if (widget.company.categories != null &&
              widget.company.categories!.isNotEmpty)
            _buildCausesSection(),

          // Active Campaigns Section
          _buildActiveCampaignsSection(),

          // Impact Stats Section
          _buildImpactStatsSection(),

          // Available Rewards Section
          _buildRewardsSection(),

          // Mediterranean Diet View (existing)
          MediterranesnDietView(
            textColor: Colors.white,
            color: Colors.black,
            profile: widget.profile,
            isProfileInfo: false,
            isCompanyInfo: true,
            company: widget.company,
          ),

          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.black,
                                elevation: 12),
                            onPressed: () {
                              context.go('/userProfile/companyDonations',
                                  extra: CompanyHomeArguments(
                                      company: widget.company,
                                      profile: widget.profile));
                            },
                            child: const Text(
                              'Our Donations',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              context.go('/comapnyRewards',
                                  extra: CompanyHomeArguments(
                                      company: widget.company,
                                      profile: widget.profile));
                            },
                            child: const Text(
                              'Our Rewards',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        context.go('/companymatch',
                            extra: CompanyMatchScreenArguments(
                                profile: widget.profile,
                                company: widget.company));
                      },
                      child: const Text(
                        'Partnerships',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ))
                ],
              ),
            ),
          ),

          // View Dashboard Button (for company owners)
          if (_isCompanyOwner) _buildViewDashboardButton(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey[900]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          if (widget.company.logo != null)
            Hero(
              tag: 'company-logo-${widget.company.id}',
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.company.logo!),
                radius: 60,
                backgroundColor: Colors.white,
              ),
            ),
          const SizedBox(height: 16),
          Text(
            widget.company.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (widget.company.yearStarted.isNotEmpty)
            Text(
              'Supporting since ${widget.company.yearStarted}',
              style: TextStyle(
                color: Colors.amber.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          const SizedBox(height: 12),
          _buildMatchingBadge(),
        ],
      ),
    );
  }

  Widget _buildMatchingBadge() {
    final hasMatching =
        widget.company.atrocityMatchRelationships?.isNotEmpty == true ||
            widget.company.nonprofitMatchRelationships?.isNotEmpty == true;

    if (!hasMatching) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite, color: Colors.green, size: 16),
          SizedBox(width: 6),
          Text(
            'Active Matching',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.company.mission != null) ...[
            const Text(
              'Our Mission',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.company.mission!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (widget.company.description != null) ...[
            const Text(
              'About',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.company.description!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
          if (widget.company.headquarters != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.amber, size: 16),
                const SizedBox(width: 6),
                Text(
                  widget.company.headquarters!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCausesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Causes We Support',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.company.categories!.map((category) {
              return Chip(
                backgroundColor: Colors.amber.withOpacity(0.2),
                label: Text(
                  category.name!,
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                  ),
                ),
                side: const BorderSide(color: Colors.amber),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCampaignsSection() {
    return BlocBuilder<CompanyCampaignsBloc, CompanyCampaignsState>(
      builder: (context, state) {
        if (state.status == CompanyCampaignsStatus.loading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(color: Colors.amber),
            ),
          );
        }

        if (state.campaigns.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.campaign, color: Colors.amber),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Active Campaigns',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${state.campaigns.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...state.campaigns
                  .take(2)
                  .map((campaign) => _CampaignCard(campaign: campaign)),
              if (state.campaigns.length > 2)
                TextButton(
                  onPressed: () {
                    // Navigate to all campaigns
                  },
                  child: const Text(
                    'View All Campaigns',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImpactStatsSection() {
    final totalDonated = widget.company.totalDonated ?? 0;
    final totalCount = widget.company.totalDonationCount ?? 0;

    if (totalDonated == 0 && totalCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Impact Stats',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildImpactStat(
                  'Total Matched',
                  '\$${_formatCurrency(totalDonated)}',
                  Icons.favorite,
                  Colors.red,
                ),
              ),
              Expanded(
                child: _buildImpactStat(
                  'Donations',
                  totalCount.toString(),
                  Icons.people,
                  Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (widget.company.nonprofits != null)
            _buildImpactStat(
              'Nonprofits Supported',
              widget.company.nonprofits!.length.toString(),
              Icons.volunteer_activism,
              Colors.green,
            ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsSection() {
    if (widget.company.coupons == null || widget.company.coupons!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.card_giftcard, color: Colors.amber),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Available Rewards',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/comapnyRewards',
                      extra: CompanyHomeArguments(
                          company: widget.company, profile: widget.profile));
                },
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.company.coupons!.length,
              itemBuilder: (context, index) {
                final coupon = widget.company.coupons![index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade700, Colors.amber.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.name ?? 'Reward',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Tap to unlock',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewDashboardButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: () {
          context.go('/companyDashboard', extra: {
            'company': widget.company,
            'profile': widget.profile,
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.dashboard, color: Colors.black),
        label: const Text(
          'View Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
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
                    fontSize: 14,
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
                  '${campaign.matchMultiplier}x',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
                '\$${_formatCurrency(campaign.amountMatched)} / \$${_formatCurrency(campaign.budgetCap)}',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
              if (campaign.daysRemaining != null)
                Text(
                  '${campaign.daysRemaining} days left',
                  style: TextStyle(
                    color: campaign.daysRemaining! < 7
                        ? Colors.orange
                        : Colors.green,
                    fontSize: 11,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,##0');
    return formatter.format(value);
  }
}
