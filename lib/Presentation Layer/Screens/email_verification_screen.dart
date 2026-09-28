import 'package:flutter/material.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Theme/glass_widgets.dart';
import 'package:lovelovelove/Theme/glass_effects.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: darkGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: GlassmorphismTheme.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Email Verification',
            style: GlassmorphismTheme.h2Style.copyWith(
              color: GlassmorphismTheme.gold,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(GlassmorphismTheme.lg),
            child: GlassCard(
              padding: const EdgeInsets.all(GlassmorphismTheme.xl),
              borderRadius: GlassmorphismTheme.radius2Xl,
              opacity: 0.15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success Icon
                  Container(
                    padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                    decoration: BoxDecoration(
                      gradient: goldGradient,
                      shape: BoxShape.circle,
                      boxShadow: goldGlowShadow(),
                    ),
                    child: const Icon(
                      Icons.email,
                      size: 80,
                      color: GlassmorphismTheme.darkPrimary,
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.lg),
                  
                  // Success Title
                  Text(
                    'Email Verified!',
                    style: GlassmorphismTheme.h1Style.copyWith(
                      color: GlassmorphismTheme.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.md),
                  
                  // Success Message
                  Text(
                    'Your email address has been successfully verified. You can now access all features of the app.',
                    style: GlassmorphismTheme.bodyStyle.copyWith(
                      color: GlassmorphismTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: GlassmorphismTheme.xl),
                  
                  // Continue Button
                  GlassButton(
                    text: 'Continue',
                    isAccent: true,
                    isFullWidth: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  
                  const SizedBox(height: GlassmorphismTheme.md),
                  
                  // Go Back Button
                  GlassButton(
                    text: 'Go Back',
                    isAccent: false,
                    isFullWidth: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}