import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_statistics_model.dart';
import '../../theme/glassmorphism_theme.dart';

class CumulativeStatsHeroCard extends StatelessWidget {
  final AltrueStatistics statistics;

  const CumulativeStatsHeroCard({
    required this.statistics,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GlassmorphismTheme.darkSecondary,
            GlassmorphismTheme.darkPrimary,
          ],
        ),
        borderRadius: BorderRadius.circular(GlassmorphismTheme.radius2Xl),
        border: Border.all(
          color: GlassmorphismTheme.gold.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: GlassmorphismTheme.goldShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(GlassmorphismTheme.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(GlassmorphismTheme.md),
                  decoration: BoxDecoration(
                    color: GlassmorphismTheme.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusMd),
                  ),
                  child: Icon(
                    Icons.analytics_outlined,
                    color: GlassmorphismTheme.gold,
                    size: 24,
                  ),
                ),
                const SizedBox(width: GlassmorphismTheme.md),
                Text(
                  'Platform Impact',
                  style: GlassmorphismTheme.h2Style.copyWith(
                    color: GlassmorphismTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: GlassmorphismTheme.lg),
            // Stats Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: GlassmorphismTheme.md,
              crossAxisSpacing: GlassmorphismTheme.md,
              childAspectRatio: 1.6,
              children: [
                _buildStatCard(
                  icon: Icons.attach_money,
                  label: 'Total Donated',
                  value: '\${statistics.totalDonated.toStringAsFixed(0)}',
                  gradient: [GlassmorphismTheme.gold, GlassmorphismTheme.goldDark],
                ),
                _buildStatCard(
                  icon: Icons.people_outline,
                  label: 'Total Users',
                  value: statistics.totalUsers.toString(),
                  color: Colors.blue,
                ),
                _buildStatCard(
                  icon: Icons.favorite_border,
                  label: 'Nonprofits',
                  value: statistics.totalNonprofits.toString(),
                  color: Colors.red,
                ),
                _buildStatCard(
                  icon: Icons.business_outlined,
                  label: 'Companies',
                  value: statistics.totalCompanies.toString(),
                  color: Colors.green,
                ),
                _buildStatCard(
                  icon: Icons.star_outline,
                  label: 'Points Earned',
                  value: statistics.totalPointsAccumulated.toString(),
                  color: Colors.purple,
                ),
                _buildStatCard(
                  icon: Icons.volunteer_activism_outlined,
                  label: 'Total Donors',
                  value: statistics.totalDonors.toString(),
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    List<Color>? gradient,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.all(GlassmorphismTheme.md),
      decoration: BoxDecoration(
        gradient: gradient != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              )
            : null,
        color: gradient == null ? GlassmorphismTheme.darkTertiary : null,
        borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
        border: gradient == null
            ? Border.all(
                color: color!.withOpacity(0.3),
                width: 1,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: gradient != null ? GlassmorphismTheme.darkPrimary.withOpacity(0.7) : color,
            size: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GlassmorphismTheme.h3Style.copyWith(
                  color: gradient != null ? GlassmorphismTheme.darkPrimary : GlassmorphismTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: GlassmorphismTheme.xs),
              Text(
                label,
                style: GlassmorphismTheme.captionStyle.copyWith(
                  color: gradient != null
                      ? GlassmorphismTheme.darkPrimary.withOpacity(0.7)
                      : GlassmorphismTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
