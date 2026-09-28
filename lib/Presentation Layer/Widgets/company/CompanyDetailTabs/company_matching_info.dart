import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/Company_Matching_Details/company_matching_tabs.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

class CompanyMatchingInfo extends StatefulWidget {
  final ForProfitCompany company;
  const CompanyMatchingInfo({Key? key, required this.company})
      : super(key: key);

  @override
  State<CompanyMatchingInfo> createState() => _CompanyMatchingInfoState();
}

class _CompanyMatchingInfoState extends State<CompanyMatchingInfo> {
  @override
  Widget build(BuildContext context) {
    // Detect current theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculate matching percentages for display
    final atrocityMatches =
        widget.company.atrocityMatchRelationships?.length ?? 0;
    final nonprofitMatches =
        widget.company.nonprofitMatchRelationships?.length ?? 0;
    final totalPotentialMatches = (widget.company.atrocities?.length ?? 0) +
        (widget.company.nonprofits?.length ?? 0);
    final matchPercentage = totalPotentialMatches > 0
        ? ((atrocityMatches + nonprofitMatches) / totalPotentialMatches * 100)
            .round()
        : 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  GlassmorphismTheme.darkPrimary.withOpacity(0.8),
                  GlassmorphismTheme.darkSecondary.withOpacity(0.9),
                  Color(0xFF1a1a1a).withOpacity(0.95),
                ]
              : [
                  GlassmorphismTheme.darkPrimary.withOpacity(0.9),
                  GlassmorphismTheme.darkSecondary.withOpacity(0.95),
                  Color(0xFFf8f8f8).withOpacity(0.98),
                ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(GlassmorphismTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with matching percentage
            GlassCard(
              margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
              borderRadius: GlassmorphismTheme.radius2Xl,
              hasGoldBorder: true,
              opacity: 0.12,
              child: Padding(
                padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(GlassmorphismTheme.md),
                      decoration: BoxDecoration(
                        gradient: GlassmorphismTheme.goldGradient,
                        shape: BoxShape.circle,
                        boxShadow: GlassmorphismTheme.goldShadow,
                      ),
                      child: Icon(
                        Icons.percent,
                        color: GlassmorphismTheme.darkPrimary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: GlassmorphismTheme.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Matching Score',
                            style: (isDark
                                    ? GlassmorphismTheme.h3Style
                                    : GlassmorphismTheme.h3Style)
                                .copyWith(
                              color: isDark
                                  ? GlassmorphismTheme.gold
                                  : GlassmorphismTheme.goldDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: GlassmorphismTheme.xs),
                          Text(
                            '$matchPercentage% Alignment',
                            style: (isDark
                                    ? GlassmorphismTheme.heroStyle
                                    : GlassmorphismTheme.heroStyle)
                                .copyWith(
                              color: GlassmorphismTheme.gold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: GlassmorphismTheme.xs),
                          Text(
                            '$atrocityMatches atrocity matches • $nonprofitMatches nonprofit matches',
                            style: isDark
                                ? GlassmorphismTheme.captionStyle
                                : GlassmorphismTheme.captionStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main content area
            Expanded(
              child: GlassCard(
                borderRadius: GlassmorphismTheme.radius2Xl,
                opacity: 0.08,
                child: CompanyMatchingDetailTabs(
                  company: widget.company,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
