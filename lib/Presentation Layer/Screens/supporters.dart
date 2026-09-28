import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';

class SupporterPage extends StatelessWidget {
  final Profile profile;

  const SupporterPage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDark
            ? GlassmorphismTheme.darkPrimary
            : GlassmorphismTheme.lightPrimary,
        body: Container(
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
            child: Padding(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        profile.username!,
                        style: isDark
                            ? GlassmorphismTheme.h2Style
                            : GlassmorphismTheme.h2StyleLight,
                      ),
                      GlassCard(
                        hasGoldBorder: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: GlassmorphismTheme.md,
                            vertical: GlassmorphismTheme.sm,
                          ),
                          child: Text(
                            'Balance: \$${profile.balance}',
                            style: (isDark
                                    ? GlassmorphismTheme.bodyStyle
                                    : GlassmorphismTheme.bodyStyleLight)
                                .copyWith(
                              color: GlassmorphismTheme.gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: GlassmorphismTheme.xl),
                  Text(
                    'Recent Donations',
                    style: isDark
                        ? GlassmorphismTheme.h1Style
                        : GlassmorphismTheme.h1StyleLight,
                  ),
                  SizedBox(height: GlassmorphismTheme.md),
                  Expanded(
                    child: ListView.builder(
                      itemCount: profile.donor!.length,
                      itemBuilder: (context, index) {
                        final donor = profile.donor![index];
                        return GlassCard(
                          margin: const EdgeInsets.only(
                              bottom: GlassmorphismTheme.md),
                          hasGoldBorder: true,
                          child: Padding(
                            padding:
                                const EdgeInsets.all(GlassmorphismTheme.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                          GlassmorphismTheme.sm),
                                      decoration: BoxDecoration(
                                        color: GlassmorphismTheme.gold
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(
                                            GlassmorphismTheme.radiusSm),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: GlassmorphismTheme.gold,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                        width: GlassmorphismTheme.md),
                                    Expanded(
                                      child: Text(
                                        "${donor.firstName} ${donor.lastName}",
                                        style: (isDark
                                                ? GlassmorphismTheme.h3Style
                                                : GlassmorphismTheme
                                                    .h3StyleLight)
                                            .copyWith(
                                          color: GlassmorphismTheme.gold,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: GlassmorphismTheme.md),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${donor.amountDonated}",
                                      style: (isDark
                                              ? GlassmorphismTheme.h2Style
                                              : GlassmorphismTheme.h2StyleLight)
                                          .copyWith(
                                        color: GlassmorphismTheme.gold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GlassButton(
                                      text: 'Say Thanks',
                                      variant: GlassButtonVariant.secondary,
                                      onPressed: () {
                                        Email email = Email(
                                          subject:
                                              'Hey ${donor.firstName}, thanks for donating',
                                          body:
                                              'Hey ${donor.firstName}, I want to thank you for donating to my efforts on the Altrue platform!',
                                          recipients: [donor.email],
                                          isHTML: false,
                                        );
                                        FlutterEmailSender.send(email);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
