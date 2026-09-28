import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_coupons_info.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_finance_data.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_matching_info.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

class ComapnyDetailTabs extends StatefulWidget {
  final ForProfitCompany company;
  const ComapnyDetailTabs({Key? key, required this.company}) : super(key: key);

  @override
  State<ComapnyDetailTabs> createState() => _ComapnyDetailTabsState();
}

class _ComapnyDetailTabsState extends State<ComapnyDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Detect current theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<Tab> tabs = [
      Tab(
        child: GlassCard(
          padding: const EdgeInsets.symmetric(
            horizontal: GlassmorphismTheme.md,
            vertical: GlassmorphismTheme.sm,
          ),
          borderRadius: GlassmorphismTheme.radiusXl,
          opacity: 0.15,
          child: Text(
            'Altrue Info',
            style: TextStyle(
              color: isDark
                  ? GlassmorphismTheme.textPrimary
                  : GlassmorphismTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      Tab(
        child: GlassCard(
          padding: const EdgeInsets.symmetric(
            horizontal: GlassmorphismTheme.md,
            vertical: GlassmorphismTheme.sm,
          ),
          borderRadius: GlassmorphismTheme.radiusXl,
          opacity: 0.15,
          child: Text(
            'Company Matching',
            style: TextStyle(
              color: isDark
                  ? GlassmorphismTheme.textPrimary
                  : GlassmorphismTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      Tab(
        child: GlassCard(
          padding: const EdgeInsets.symmetric(
            horizontal: GlassmorphismTheme.md,
            vertical: GlassmorphismTheme.sm,
          ),
          borderRadius: GlassmorphismTheme.radiusXl,
          opacity: 0.15,
          child: Text(
            'Altrue Deals',
            style: TextStyle(
              color: isDark
                  ? GlassmorphismTheme.textPrimary
                  : GlassmorphismTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ];

    List<Widget> pages = [
      CompanyFInanceData(company: widget.company),
      CompanyMatchingInfo(company: widget.company),
      CompanyCouponInfo(company: widget.company),
    ];

    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  GlassmorphismTheme.darkPrimary,
                  GlassmorphismTheme.darkSecondary,
                  Color(0xFF0a0a0a),
                ]
              : [
                  GlassmorphismTheme.darkPrimary,
                  GlassmorphismTheme.darkSecondary,
                  Color(0xFFfafafa),
                ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(GlassmorphismTheme.sm),
        child: Column(
          children: [
            GlassCard(
              margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
              borderRadius: GlassmorphismTheme.radius2Xl,
              opacity: 0.1,
              child: TabBar(
                isScrollable: true,
                labelColor: GlassmorphismTheme.gold,
                unselectedLabelColor: isDark
                    ? GlassmorphismTheme.textSecondary
                    : GlassmorphismTheme.textSecondary,
                controller: tabController,
                tabs: tabs,
                indicator: BoxDecoration(
                  gradient: GlassmorphismTheme.goldGradient,
                  borderRadius:
                      BorderRadius.circular(GlassmorphismTheme.radiusXl),
                  boxShadow: GlassmorphismTheme.goldShadow,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.all(2),
              ),
            ),
            Expanded(
              child: GlassCard(
                borderRadius: GlassmorphismTheme.radius2Xl,
                opacity: 0.08,
                child: TabBarView(
                  controller: tabController,
                  children: pages,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
