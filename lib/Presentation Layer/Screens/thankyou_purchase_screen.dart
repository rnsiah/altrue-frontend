import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';

import '../../Data Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';

class ThankYouPurchaseScreen extends StatefulWidget {
  final bool? isNonProfit;
  final bool? isPurchase;
  final bool? isAtrocity;
  final bool? isProject;

  const ThankYouPurchaseScreen(
      {super.key,
      this.isAtrocity,
      this.isNonProfit,
      this.isPurchase,
      this.isProject});

  @override
  State<ThankYouPurchaseScreen> createState() => _ThankYouPurchaseScreenState();
}

class _ThankYouPurchaseScreenState extends State<ThankYouPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? GlassmorphismTheme.darkPrimary
          : GlassmorphismTheme.lightPrimary,
      appBar: AppBar(
        title: Text(
          'Thank You',
          style: (isDark
                  ? GlassmorphismTheme.h2Style
                  : GlassmorphismTheme.h2StyleLight)
              .copyWith(
            color: GlassmorphismTheme.gold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: GlassmorphismTheme.gold),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final userProfile = state.profile!;
          final donation = userProfile.userdonations!.last;
          // final imageUrl = donation.nonprofit?? donation.nonprofit!.logo ??
          //     ''
          // //         ''; // Assuming imageUrl is part of the donation object
          // final title = donation.nonprofit!.name ??
          'Donation'; // Assuming title is part of the donation object
          final userName = userProfile.username ?? 'User';
          final currentBalance = userProfile.balance ?? 0.0;
          final altruePoints = userProfile.altruePoints ?? 0;
          final userLevel = userProfile.altrueLevel!.levelNumber ?? 1;
          final nextLevelPoints = userProfile.altrueLevel!.minimumPoints ?? 0;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        GlassmorphismTheme.darkPrimary,
                        GlassmorphismTheme.darkSecondary,
                        GlassmorphismTheme.darkTertiary,
                      ]
                    : [
                        GlassmorphismTheme.lightPrimary,
                        GlassmorphismTheme.lightSecondary,
                      ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(GlassmorphismTheme.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: GlassmorphismTheme.xl),
                    GlassCard(
                      hasGoldBorder: true,
                      child: Padding(
                        padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                        child: Text(
                          'Thank You!',
                          style: (isDark
                                  ? GlassmorphismTheme.heroStyle
                                  : GlassmorphismTheme.heroStyleLight)
                              .copyWith(
                            color: GlassmorphismTheme.gold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: GlassmorphismTheme.md),
                    GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.all(GlassmorphismTheme.md),
                        child: Text(
                          widget.isAtrocity != null
                              ? 'Your support helps address atrocities.'
                              : widget.isNonProfit != null
                                  ? 'Thank you for supporting a nonprofit.'
                                  : 'Thank you for your purchase.',
                          style: isDark
                              ? GlassmorphismTheme.bodyStyle
                              : GlassmorphismTheme.bodyStyleLight,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: GlassmorphismTheme.lg),
                    GlassCard(
                      hasGoldBorder: true,
                      child: Padding(
                        padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: GlassmorphismTheme.gold
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(
                                        GlassmorphismTheme.radiusXl),
                                    border: Border.all(
                                      color: GlassmorphismTheme.gold
                                          .withOpacity(0.5),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      userName[0].toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: GlassmorphismTheme.gold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: GlassmorphismTheme.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'User: $userName',
                                        style: isDark
                                            ? GlassmorphismTheme.h3Style
                                            : GlassmorphismTheme.h3StyleLight,
                                      ),
                                      Text(
                                        'Level: $userLevel',
                                        style: (isDark
                                                ? GlassmorphismTheme.bodyStyle
                                                : GlassmorphismTheme
                                                    .bodyStyleLight)
                                            .copyWith(
                                          color: GlassmorphismTheme.gold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: GlassmorphismTheme.lg),
                            _buildInfoRow(
                              'Current Balance',
                              '\$${currentBalance.toStringAsFixed(2)}',
                              isDark,
                            ),
                            const SizedBox(height: GlassmorphismTheme.md),
                            _buildInfoRow(
                              'Altrue Points',
                              '$altruePoints',
                              isDark,
                              valueColor: GlassmorphismTheme.gold,
                            ),
                            const SizedBox(height: GlassmorphismTheme.md),
                            nextLevelPoints > 0
                                ? _buildInfoRow(
                                    'Points to next level',
                                    '${nextLevelPoints - altruePoints}',
                                    isDark,
                                  )
                                : _buildInfoRow(
                                    'Status',
                                    'Top Level Achieved!',
                                    isDark,
                                    valueColor: GlassmorphismTheme.gold,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: GlassmorphismTheme.xl),
                    GlassButton(
                      text: 'Continue',
                      variant: GlassButtonVariant.primary,
                      isFullWidth: true,
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('/home',
                            arguments: HomeArguments(
                                profile:
                                    context.read<ProfileBloc>().state.profile!,
                                user: context.read<ProfileBloc>().state.user!,
                                cartBloc: context.read<CartBloc>()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark,
      {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: isDark
              ? GlassmorphismTheme.bodyStyle
              : GlassmorphismTheme.bodyStyleLight,
        ),
        Text(
          value,
          style: (isDark
                  ? GlassmorphismTheme.bodyStyle
                  : GlassmorphismTheme.bodyStyleLight)
              .copyWith(
            color: valueColor ??
                (isDark
                    ? GlassmorphismTheme.textPrimary
                    : GlassmorphismTheme.textPrimaryLight),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
