import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

class WalletChoiceScreen extends StatefulWidget {
  const WalletChoiceScreen({super.key});

  @override
  State<WalletChoiceScreen> createState() => _WalletChoiceScreenState();
}

class _WalletChoiceScreenState extends State<WalletChoiceScreen> {
  String? _selectedOption; // 'create' or 'connect'

  void _onContinue() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a wallet option')),
      );
      return;
    }

    if (_selectedOption == 'create') {
      // Navigate to Create Wallet flow
      context.go('/userprofile/createWallet');
    } else if (_selectedOption == 'connect') {
      // Navigate to Connect Wallet flow
      context.go('/userprofile/connectWallet');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Choose Wallet Option'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GlassmorphismTheme.h2Style.copyWith(
          color: GlassmorphismTheme.gold,
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
          child: Padding(
            padding: const EdgeInsets.all(GlassmorphismTheme.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassCard(
                  margin: const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How would you like to use blockchain features?',
                        style: GlassmorphismTheme.h2Style,
                      ),
                      const SizedBox(height: GlassmorphismTheme.sm),
                      Text(
                        'Choose your preferred wallet option to get started',
                        style: GlassmorphismTheme.captionStyle,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: GlassmorphismTheme.md),

                // Create Wallet option
                GlassCard(
                  margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
                  hasGoldBorder: _selectedOption == 'create',
                  onTap: () {
                    setState(() {
                      _selectedOption =
                          _selectedOption == 'create' ? null : 'create';
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(GlassmorphismTheme.md),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _selectedOption == 'create'
                                ? [
                                    GlassmorphismTheme.gold,
                                    GlassmorphismTheme.goldDark
                                  ]
                                : [
                                    GlassmorphismTheme.glassWhite,
                                    GlassmorphismTheme.glassWhiteSubtle
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(
                              GlassmorphismTheme.radiusMd),
                        ),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: _selectedOption == 'create'
                              ? GlassmorphismTheme.darkPrimary
                              : GlassmorphismTheme.gold,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: GlassmorphismTheme.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create a New Wallet',
                              style: GlassmorphismTheme.h3Style,
                            ),
                            const SizedBox(height: GlassmorphismTheme.xs),
                            Text(
                              'We will generate a secure wallet for you inside the app',
                              style: GlassmorphismTheme.captionStyle,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedOption == 'create'
                                ? GlassmorphismTheme.gold
                                : GlassmorphismTheme.textTertiary,
                            width: 2,
                          ),
                        ),
                        child: _selectedOption == 'create'
                            ? Container(
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GlassmorphismTheme.gold,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),

                // Connect Wallet option
                GlassCard(
                  margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
                  hasGoldBorder: _selectedOption == 'connect',
                  onTap: () {
                    setState(() {
                      _selectedOption =
                          _selectedOption == 'connect' ? null : 'connect';
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(GlassmorphismTheme.md),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _selectedOption == 'connect'
                                ? [
                                    GlassmorphismTheme.gold,
                                    GlassmorphismTheme.goldDark
                                  ]
                                : [
                                    GlassmorphismTheme.glassWhite,
                                    GlassmorphismTheme.glassWhiteSubtle
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(
                              GlassmorphismTheme.radiusMd),
                        ),
                        child: Icon(
                          Icons.link,
                          color: _selectedOption == 'connect'
                              ? GlassmorphismTheme.darkPrimary
                              : GlassmorphismTheme.gold,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: GlassmorphismTheme.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Connect Existing Wallet',
                              style: GlassmorphismTheme.h3Style,
                            ),
                            const SizedBox(height: GlassmorphismTheme.xs),
                            Text(
                              'Use WalletConnect to link your current wallet (MetaMask, Trust, etc.)',
                              style: GlassmorphismTheme.captionStyle,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedOption == 'connect'
                                ? GlassmorphismTheme.gold
                                : GlassmorphismTheme.textTertiary,
                            width: 2,
                          ),
                        ),
                        child: _selectedOption == 'connect'
                            ? Container(
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GlassmorphismTheme.gold,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Continue button
                GlassButton(
                  text: 'Continue',
                  variant: GlassButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: _onContinue,
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
