import 'package:flutter/material.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';
import '../Widgets/address_form.dart';
import '../Widgets/credit_card_form.dart';
import 'login_form.dart';

/// Demo page showcasing all glassmorphism forms
/// This demonstrates how to use the redesigned forms together
class FormsDemoPage extends StatefulWidget {
  const FormsDemoPage({super.key});

  @override
  State<FormsDemoPage> createState() => _FormsDemoPageState();
}

class _FormsDemoPageState extends State<FormsDemoPage> {
  int _selectedForm = 0;

  final List<String> _formTitles = [
    'Login Form',
    'Address Form',
    'Credit Card Form',
  ];

  final List<Widget> _formWidgets = [
    const LoginForm(),
    // AddressForm(profile: Profile()), // You'll need to provide a proper Profile instance
    const CreditCardForm(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary,
                    const Color(0xFF0d0d0d),
                  ]
                : [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary,
                    GlassmorphismTheme.darkTertiary,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                child: Column(
                  children: [
                    Text(
                      'Glassmorphism Forms',
                      style: GlassmorphismTheme.heroStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: GlassmorphismTheme.sm),
                    Text(
                      'Beautiful forms with glass morphism design',
                      style: GlassmorphismTheme.bodyStyle.copyWith(
                        color: GlassmorphismTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Form Selector
              GlassCard(
                margin: const EdgeInsets.symmetric(
                    horizontal: GlassmorphismTheme.lg),
                child: Row(
                  children: List.generate(_formTitles.length, (index) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedForm = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: GlassmorphismTheme.md,
                            horizontal: GlassmorphismTheme.sm,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedForm == index
                                ? GlassmorphismTheme.gold.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                                GlassmorphismTheme.radiusMd),
                          ),
                          child: Text(
                            _formTitles[index],
                            textAlign: TextAlign.center,
                            style: GlassmorphismTheme.bodyStyle.copyWith(
                              color: _selectedForm == index
                                  ? GlassmorphismTheme.gold
                                  : GlassmorphismTheme.textSecondary,
                              fontWeight: _selectedForm == index
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: GlassmorphismTheme.lg),

              // Selected Form
              // Expanded(
              //   child: SingleChildScrollView(
              //     padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.lg),
              //     child: _selectedForm == 1
              //         // ? AddressForm(profile: Profile()) // Need proper Profile instance
              //         : _selectedForm == 2
              //             ? const CreditCardForm()
              //             : const LoginForm(),
              //   ),
              // ),

              const SizedBox(height: GlassmorphismTheme.xl),
            ],
          ),
        ),
      ),
    );
  }
}

// Temporary Profile class for demo - replace with your actual Profile model
class Profile {
  String address = '';
  String city = '';
  String zip = '';
}
