import 'package:flutter/material.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Theme/glass_widgets.dart';
import 'package:lovelovelove/Theme/glass_effects.dart';

/// Test widget to verify glassmorphism components are working correctly
class GlassmorphismTestWidget extends StatelessWidget {
  const GlassmorphismTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlassmorphismTheme.darkPrimary,
      body: Container(
        decoration: const BoxDecoration(
          gradient: darkGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Test GlassCard
              GlassCard(
                padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                borderRadius: GlassmorphismTheme.radiusXl,
                opacity: 0.1,
                child: Text(
                  'GlassCard Test',
                  style: GlassmorphismTheme.h2Style,
                ),
              ),
              
              const SizedBox(height: GlassmorphismTheme.lg),
              
              // Test GlassButton (accent)
              GlassButton(
                text: 'Donate Now',
                isAccent: true,
                onPressed: () {},
              ),
              
              const SizedBox(height: GlassmorphismTheme.md),
              
              // Test GlassButton (non-accent)
              GlassButton(
                text: 'Learn More',
                isAccent: false,
                onPressed: () {},
              ),
              
              const SizedBox(height: GlassmorphismTheme.lg),
              
              // Test gold accent text
              Text(
                '\$1,234 Raised',
                style: GlassmorphismTheme.h2Style.copyWith(
                  color: GlassmorphismTheme.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}