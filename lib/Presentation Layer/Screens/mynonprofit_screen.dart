import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_nonprofit_matching_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

class MyNonProfitHome extends StatefulWidget {
  final Profile profile;
  final NonProfit nonprofit;
  final NonProfitRespository nonProfitRepository = NonProfitRespository();

  MyNonProfitHome({Key? key, required this.profile, required this.nonprofit})
      : super(key: key);

  @override
  MyNonProfitHomeState createState() => MyNonProfitHomeState();
}

class MyNonProfitHomeState extends State<MyNonProfitHome> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
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
          child: ListView(
            padding: const EdgeInsets.all(GlassmorphismTheme.md),
            children: [
              // Header Section
              GlassCard(
                margin: const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                hasGoldBorder: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile.np!.name,
                      style: GlassmorphismTheme.h1Style.copyWith(
                        color: GlassmorphismTheme.gold,
                      ),
                    ),
                    const SizedBox(height: GlassmorphismTheme.xs),
                    Text(
                      'Managing your nonprofit impact',
                      style: GlassmorphismTheme.captionStyle,
                    ),
                  ],
                ),
              ),

              // Stats Section
              GlassCard(
                margin: const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                child: MediterranesnDietView(
                  textColor: GlassmorphismTheme.textPrimary,
                  color: Colors.transparent,
                  isCompanyInfo: false,
                  profile: widget.profile,
                  isProfileInfo: false,
                  nonprofit: widget.nonprofit,
                ),
              ),

              // Action Buttons Grid
              GlassCard(
                margin: const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                child: Column(
                  children: [
                    _buildActionButtonRow([
                      _buildActionButton(
                        context,
                        'Donations',
                        Icons.account_balance_wallet,
                        '/npDonationManagement',
                        widget.nonprofit,
                      ),
                      _buildActionButton(
                        context,
                        'Projects',
                        Icons.work_outline,
                        '/nonprofitProjectList',
                        NonProfitProjectListArguments(
                          nonProfit: widget.nonprofit,
                          profile: widget.profile,
                        ),
                      ),
                    ]),
                    const SizedBox(height: GlassmorphismTheme.md),
                    _buildActionButtonRow([
                      _buildActionButton(
                        context,
                        'Partnerships',
                        Icons.handshake_outlined,
                        '/npMatchinginfo',
                        widget.nonprofit,
                      ),
                      _buildGlassButton(
                        context,
                        'Create Project',
                        Icons.add_circle_outline,
                        () => context.go(
                          '/createProject',
                          extra: CreateProjectArguments(
                            nonprofit: widget.nonprofit,
                            profile: widget.profile,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),

              // Matching Partnerships Section
              if (widget.nonprofit.matchingPartnerships?.isNotEmpty ==
                  true) ...[
                GlassCard(
                  margin: const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                  hasGoldBorder: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Matching Partnerships',
                        style: GlassmorphismTheme.h2Style.copyWith(
                          color: GlassmorphismTheme.gold,
                        ),
                      ),
                      const SizedBox(height: GlassmorphismTheme.md),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.nonprofit.matchingPartnerships!.length,
                          itemBuilder: (context, index) {
                            return _buildCompanyMatchCard(
                              widget.nonprofit.matchingPartnerships![index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtonRow(List<Widget> buttons) {
    return Row(
      children: buttons.map((button) => Expanded(child: button)).toList(),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    String route,
    dynamic extra,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.xs),
      child: GlassButton(
        onPressed: () => context.go(route, extra: extra),
        icon: icon,
        text: title,
        // : false,
      ),
    );
  }

  Widget _buildGlassButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.xs),
      child: GlassButton(
        onPressed: onPressed,
        icon: icon,
        text: title,
      ),
    );
  }

  Widget _buildCompanyMatchCard(CompanyNonProfitMatchRelationship company) {
    return GlassCard(
      margin: const EdgeInsets.only(right: GlassmorphismTheme.md),
      width: 180,
      hasGoldBorder: true,
      child: Stack(
        children: [
          // Company Logo
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusSm),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(company.company.logo),
              ),
            ),
          ),

          // Company Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.company.name,
                  style: GlassmorphismTheme.captionStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: GlassmorphismTheme.gold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: GlassmorphismTheme.xs),
                Text(
                  'Matching ${company.matchLevel}%',
                  style: GlassmorphismTheme.captionStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                Text(
                  '\$${company.totalRaised?.toInt() ?? 0} / \$${company.fundingLimit?.toInt() ?? 0}',
                  style: GlassmorphismTheme.captionStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
