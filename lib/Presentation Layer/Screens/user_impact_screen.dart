import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/company_impact_bloc/company_impact_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_company_impact_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class UserImpactScreen extends StatefulWidget {
  final Profile profile;

  const UserImpactScreen({super.key, required this.profile});

  @override
  State<UserImpactScreen> createState() => _UserImpactScreenState();
}

class _UserImpactScreenState extends State<UserImpactScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyImpactBloc>().add(const FetchUserImpactStats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Your Company Impact',
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.amber),
            onPressed: () => _shareImpact(context),
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
                    state.errorMessage ?? 'Failed to load impact data',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CompanyImpactBloc>().add(
                        const FetchUserImpactStats(),
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

          final impact = state.userImpact;
          if (impact == null) {
            return const Center(
              child: Text(
                'No impact data available',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildTotalImpactCard(impact),
              ),
              if (impact.recentMatches != null && impact.recentMatches!.isNotEmpty)
                SliverToBoxAdapter(
                  child: _buildRecentMatches(impact.recentMatches!),
                ),
              SliverToBoxAdapter(
                child: _buildCompanyBreakdown(impact.byCompany),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTotalImpactCard(UserCompanyImpact impact) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade700, Colors.amber.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Companies Matched For You',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_formatCurrency(impact.totalMatched)}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem(
                'Donations',
                impact.totalDonations.toString(),
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.black26,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              _buildStatItem(
                'Companies',
                impact.byCompany.length.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentMatches(List<RecentMatch> matches) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Matches',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...matches.take(3).map((match) => _RecentMatchCard(match: match)),
        ],
      ),
    );
  }

  Widget _buildCompanyBreakdown(List<CompanyMatchSummary> byCompany) {
    if (byCompany.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'By Company',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => _shareImpact(context),
                child: const Row(
                  children: [
                    Icon(Icons.share, size: 16, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('Share', style: TextStyle(color: Colors.amber)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...byCompany.map((summary) => _CompanyImpactCard(summary: summary)),
        ],
      ),
    );
  }

  void _shareImpact(BuildContext context) {
    final state = context.read<CompanyImpactBloc>().state;
    final impact = state.userImpact;
    
    if (impact == null) return;

    String shareText = '🎉 My Impact on Altrue!\n\n';
    shareText += 'Companies have matched \$${_formatCurrency(impact.totalMatched)} for my donations!\n\n';
    
    if (impact.byCompany.isNotEmpty) {
      shareText += 'Top matches:\n';
      for (final summary in impact.byCompany.take(3)) {
        shareText += '• ${summary.company.name}: \$${_formatCurrency(summary.totalMatched)}\n';
      }
    }
    
    shareText += '\nJoin me on Altrue and double your impact! 🌍';
    
    Share.share(shareText, subject: 'My Altrue Impact');
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.trending_up,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.impactStatement,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  match.nonprofitName ?? match.causeName ?? 'Donation',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTimeAgo(match.createdAt),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
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

class _CompanyImpactCard extends StatelessWidget {
  final CompanyMatchSummary summary;

  const _CompanyImpactCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          if (summary.company.logo != null)
            CircleAvatar(
              backgroundImage: NetworkImage(summary.company.logo!),
              radius: 28,
              backgroundColor: Colors.white,
            )
          else
            CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 28,
              child: Text(
                summary.company.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary.company.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${summary.donationCount} donations matched',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                if (summary.topCause != null)
                  Text(
                    'Top cause: ${summary.topCause}',
                    style: TextStyle(
                      color: Colors.amber.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${_formatCurrency(summary.totalMatched)}',
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'matched',
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
}

// Widget that can be embedded in the profile screen
class UserImpactSummaryCard extends StatelessWidget {
  final Profile profile;

  const UserImpactSummaryCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyImpactBloc, CompanyImpactState>(
      builder: (context, state) {
        if (state.status == CompanyImpactStatus.loading || state.userImpact == null) {
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            ),
          );
        }

        final impact = state.userImpact!;

        return GestureDetector(
          onTap: () {
            context.go('/userImpact', extra: profile);
          },
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade800, Colors.amber.shade900],
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
                    const Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Your Company Impact',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Companies matched \$${_formatCurrency(impact.totalMatched)} for you',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                if (impact.byCompany.isNotEmpty)
                  ...impact.byCompany.take(2).map((summary) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        if (summary.company.logo != null)
                          CircleAvatar(
                            backgroundImage: NetworkImage(summary.company.logo!),
                            radius: 12,
                            backgroundColor: Colors.white,
                          )
                        else
                          const Icon(Icons.business, color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            summary.company.name,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          '\$${_formatCurrency(summary.totalMatched)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _shareImpact(context, impact),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.amber.shade900,
                  ),
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('Share Your Impact'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(value);
  }

  void _shareImpact(BuildContext context, UserCompanyImpact impact) {
    String shareText = '🎉 My Impact on Altrue!\n\n';
    shareText += 'Companies have matched \$${_formatCurrency(impact.totalMatched)} for my donations!\n\n';
    
    if (impact.byCompany.isNotEmpty) {
      shareText += 'Thanks to:\n';
      for (final summary in impact.byCompany.take(3)) {
        shareText += '• ${summary.company.name}\n';
      }
    }
    
    shareText += '\nJoin me on Altrue and double your impact! 🌍';
    
    Share.share(shareText, subject: 'My Altrue Impact');
  }
}
