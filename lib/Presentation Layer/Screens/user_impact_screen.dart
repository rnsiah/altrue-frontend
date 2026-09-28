import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/company_impact_bloc/company_impact_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_company_impact_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Your Company Impact',
          style: GlassmorphismTheme.h2Style.copyWith(
            color: GlassmorphismTheme.gold,
          ),
        ),
        centerTitle: true,
        leading: GlassIconButton(
          icon: Icons.arrow_back,
          onPressed: () => context.pop(),
          variant: GlassButtonVariant.glass,
        ),
        actions: [
          GlassIconButton(
            icon: Icons.share,
            onPressed: () => _shareImpact(context),
            variant: GlassButtonVariant.glass,
          ),
          const SizedBox(width: GlassmorphismTheme.sm),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ]
                : [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<CompanyImpactBloc, CompanyImpactState>(
            builder: (context, state) {
              if (state.status == CompanyImpactStatus.loading) {
                return Center(
                  child: GlassCard(
                    child: const CircularProgressIndicator(
                      color: GlassmorphismTheme.gold,
                    ),
                  ),
                );
              }

              if (state.status == CompanyImpactStatus.failure) {
                return Center(
                  child: GlassCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),
                        Text(
                          state.errorMessage ?? 'Failed to load impact data',
                          style: GlassmorphismTheme.bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: GlassmorphismTheme.lg),
                        GlassButton(
                          text: 'Retry',
                          variant: GlassButtonVariant.primary,
                          onPressed: () {
                            context.read<CompanyImpactBloc>().add(
                                  const FetchUserImpactStats(),
                                );
                          },
                          icon: Icons.refresh,
                        ),
                      ],
                    ),
                  ),
                );
              }

              final impact = state.userImpact;
              if (impact == null) {
                return Center(
                  child: GlassCard(
                    child: Text(
                      'No impact data available',
                      style: GlassmorphismTheme.bodyStyle,
                    ),
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildTotalImpactCard(impact),
                  ),
                  if (impact.recentMatches != null &&
                      impact.recentMatches!.isNotEmpty)
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
        ),
      ),
    );
  }

  Widget _buildTotalImpactCard(UserCompanyImpact impact) {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      gradient: GlassmorphismTheme.goldGradient,
      hasShadow: true,
      child: Column(
        children: [
          const Icon(
            Icons.favorite,
            color: GlassmorphismTheme.darkPrimary,
            size: 48,
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          Text(
            'Companies Matched For You',
            style: GlassmorphismTheme.bodyStyle.copyWith(
              color: GlassmorphismTheme.darkPrimary.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          Text(
            '\$${_formatCurrency(impact.totalMatched)}',
            style: TextStyle(
              color: GlassmorphismTheme.darkPrimary,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.lg),
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
                color: GlassmorphismTheme.darkPrimary.withOpacity(0.3),
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
          style: TextStyle(
            color: GlassmorphismTheme.darkPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: GlassmorphismTheme.darkPrimary.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentMatches(List<RecentMatch> matches) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
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
                text: 'View All',
                variant: GlassButtonVariant.secondary,
                onPressed: () {},
                horizontalPadding: GlassmorphismTheme.md,
                verticalPadding: GlassmorphismTheme.sm,
              ),
            ],
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          ...matches.take(3).map((match) => _RecentMatchCard(match: match)),
        ],
      ),
    );
  }

  Widget _buildCompanyBreakdown(List<CompanyMatchSummary> byCompany) {
    if (byCompany.isEmpty) {
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
                'By Company',
                style: GlassmorphismTheme.h2Style.copyWith(
                  color: GlassmorphismTheme.gold,
                ),
              ),
              GlassButton(
                text: 'Share',
                variant: GlassButtonVariant.secondary,
                onPressed: () => _shareImpact(context),
                icon: Icons.share,
                horizontalPadding: GlassmorphismTheme.md,
                verticalPadding: GlassmorphismTheme.sm,
              ),
            ],
          ),
          const SizedBox(height: GlassmorphismTheme.md),
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
    shareText +=
        'Companies have matched \$${_formatCurrency(impact.totalMatched)} for my donations!\n\n';

    if (impact.byCompany.isNotEmpty) {
      shareText += 'Top matches:\n';
      for (final summary in impact.byCompany.take(3)) {
        shareText +=
            '• ${summary.company.name}: \$${_formatCurrency(summary.totalMatched)}\n';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: GlassmorphismTheme.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(GlassmorphismTheme.md),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  GlassmorphismTheme.gold.withOpacity(0.2),
                  GlassmorphismTheme.gold.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusMd),
            ),
            child: const Icon(
              Icons.trending_up,
              color: GlassmorphismTheme.gold,
            ),
          ),
          const SizedBox(width: GlassmorphismTheme.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.impactStatement,
                  style: GlassmorphismTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: GlassmorphismTheme.xs),
                Text(
                  match.nonprofitName ?? match.causeName ?? 'Donation',
                  style: GlassmorphismTheme.captionStyle,
                ),
              ],
            ),
          ),
          Text(
            _formatTimeAgo(match.createdAt),
            style: GlassmorphismTheme.captionStyle.copyWith(
              color: GlassmorphismTheme.textTertiary,
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
    return GlassCard(
      margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
      child: Row(
        children: [
          if (summary.company.logo != null)
            CircleAvatar(
              backgroundImage: NetworkImage(summary.company.logo!),
              radius: 28,
              backgroundColor: GlassmorphismTheme.darkPrimary,
            )
          else
            CircleAvatar(
              backgroundColor: GlassmorphismTheme.gold,
              radius: 28,
              child: Text(
                summary.company.name[0].toUpperCase(),
                style: const TextStyle(
                  color: GlassmorphismTheme.darkPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          const SizedBox(width: GlassmorphismTheme.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary.company.name,
                  style: GlassmorphismTheme.h3Style.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: GlassmorphismTheme.xs),
                Text(
                  '${summary.donationCount} donations matched',
                  style: GlassmorphismTheme.captionStyle,
                ),
                if (summary.topCause != null)
                  Text(
                    'Top cause: ${summary.topCause}',
                    style: GlassmorphismTheme.captionStyle.copyWith(
                      color: GlassmorphismTheme.gold.withOpacity(0.8),
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
                  color: GlassmorphismTheme.gold,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'matched',
                style: GlassmorphismTheme.captionStyle.copyWith(
                  color: GlassmorphismTheme.textTertiary,
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
        if (state.status == CompanyImpactStatus.loading ||
            state.userImpact == null) {
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
                                backgroundImage:
                                    NetworkImage(summary.company.logo!),
                                radius: 12,
                                backgroundColor: Colors.white,
                              )
                            else
                              const Icon(Icons.business,
                                  color: Colors.white70, size: 20),
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
    shareText +=
        'Companies have matched \$${_formatCurrency(impact.totalMatched)} for my donations!\n\n';

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
