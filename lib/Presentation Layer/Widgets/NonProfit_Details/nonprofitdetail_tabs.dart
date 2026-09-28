import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_atrocity_showcase.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_shirt_showcase.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_volunteer_showcase.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Theme/glass_widgets.dart';

class NonProfitDetailTabs extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NonProfitDetailTabs(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  _NonProfitDetailTabsState createState() => _NonProfitDetailTabsState();
}

class _NonProfitDetailTabsState extends State<NonProfitDetailTabs>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'Shirts',
      ),
      const Tab(
        text: 'Atrocities',
      ),
      const Tab(
        text: 'Volunteer Opportunities',
      )
    ];
    List<Widget> pages = [
      NonProfitShirtCase(
        nonProfit: widget.nonProfit,
        profile: widget.profile,
      ),
      NonprofitAtrocityShowcase(
        nonprofit: widget.nonProfit,
        profile: widget.profile,
      ),
      NonProfitVolunteerShowcase(nonProfit: widget.nonProfit)
    ];

    TabController controller = TabController(length: tabs.length, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(GlassmorphismTheme.xs),
      child: Column(
        children: [
          GlassCard(
            padding: const EdgeInsets.all(GlassmorphismTheme.sm),
            borderRadius: GlassmorphismTheme.radiusLg,
            opacity: 0.1,
            child: TabBar(
              controller: controller,
              tabs: tabs,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    GlassmorphismTheme.gold.withOpacity(0.3),
                    GlassmorphismTheme.gold.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusMd),
                border: Border.all(
                  color: GlassmorphismTheme.gold.withOpacity(0.5),
                  width: 1,
                ),
              ),
              indicatorColor: GlassmorphismTheme.gold,
              unselectedLabelColor: GlassmorphismTheme.textSecondary,
              labelColor: GlassmorphismTheme.gold,
              labelStyle: GlassmorphismTheme.captionStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GlassmorphismTheme.captionStyle,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          GlassCard(
            padding: const EdgeInsets.all(GlassmorphismTheme.md),
            borderRadius: GlassmorphismTheme.radiusXl,
            opacity: 0.05,
            child: SizedBox.fromSize(
              size: const Size.fromHeight(300.0),
              child: TabBarView(
                controller: controller,
                children: pages,
              ),
            ),
          )
        ],
      ),
    );
  }
}
