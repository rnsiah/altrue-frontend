import 'package:flutter/material.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Theme/glass_widgets.dart';
import 'package:lovelovelove/Theme/glass_effects.dart';

class ConfirmationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ConfirmationScreen({super.key});
  
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
          title: const Image(
            image: AssetImage('images/Altrue Logo White.png'),
            height: 40,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(GlassmorphismTheme.lg),
            child: GlassCard(
              padding: const EdgeInsets.all(GlassmorphismTheme.xl),
              borderRadius: GlassmorphismTheme.radius2Xl,
              opacity: 0.15,
              child: _confirmationForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmationForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Text(
            'Confirm Your Account',
            style: GlassmorphismTheme.h1Style.copyWith(
              color: GlassmorphismTheme.gold,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          
          // Subtitle
          Text(
            'Enter your email and the confirmation code sent to your inbox',
            style: GlassmorphismTheme.bodyStyle.copyWith(
              color: GlassmorphismTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: GlassmorphismTheme.xl),
          
          // Email Field
          GlassInput(
            hintText: 'Email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: GlassmorphismTheme.md),
          
          // Confirmation Code Field
          GlassInput(
            hintText: 'Confirmation Code',
            prefixIcon: Icons.confirmation_number_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: GlassmorphismTheme.xl),
          
          // Confirm Button
          GlassButton(
            text: 'Confirm Now',
            isAccent: true,
            isFullWidth: true,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle confirmation logic
              }
            },
          ),
          
          const SizedBox(height: GlassmorphismTheme.md),
          
          // Resend Code Link
          TextButton(
            onPressed: () {
              // Handle resend code
            },
            child: Text(
              'Didn\'t receive the code? Resend',
              style: GlassmorphismTheme.captionStyle.copyWith(
                color: GlassmorphismTheme.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}