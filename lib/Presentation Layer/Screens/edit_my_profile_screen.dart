import 'package:flutter/material.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';

import '../../Data Layer/Models/user_model.dart';

class ProfileEditScreen extends StatefulWidget {
  final Profile profile;

  const ProfileEditScreen({super.key, required this.profile});

  
  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _aboutMeController = TextEditingController();
  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the initial values from the provided Profile
    _aboutMeController.text = widget.profile.description!;
    _streetAddressController.text = widget.profile.address!;
    _cityController.text = widget.profile.city!;
    _zipCodeController.text = widget.profile.zip!;
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? GlassmorphismTheme.darkPrimary : GlassmorphismTheme.lightPrimary,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: (isDark ? GlassmorphismTheme.h2Style : GlassmorphismTheme.h2StyleLight).copyWith(
            color: GlassmorphismTheme.gold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: GlassmorphismTheme.gold),
      ),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(GlassmorphismTheme.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GlassCard(
                  hasGoldBorder: true,
                  child: Padding(
                    padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Your Profile',
                          style: (isDark ? GlassmorphismTheme.h1Style : GlassmorphismTheme.h1StyleLight).copyWith(
                            color: GlassmorphismTheme.gold,
                          ),
                        ),
                        const SizedBox(height: GlassmorphismTheme.lg),
                        _buildGlassTextField(
                          controller: _aboutMeController,
                          labelText: 'About Me',
                          hintText: 'Tell us about yourself',
                          maxLines: 3,
                          isDark: isDark,
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),
                        _buildGlassTextField(
                          controller: _streetAddressController,
                          labelText: 'Street Address',
                          hintText: '123 Main St',
                          isDark: isDark,
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),
                        _buildGlassTextField(
                          controller: _cityController,
                          labelText: 'City',
                          hintText: 'New York',
                          isDark: isDark,
                        ),
                        const SizedBox(height: GlassmorphismTheme.md),
                        _buildGlassTextField(
                          controller: _zipCodeController,
                          labelText: 'ZIP Code',
                          hintText: '12345',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: GlassmorphismTheme.lg),
                GlassButton(
                  text: 'Change Profile Picture',
                  variant: GlassButtonVariant.secondary,
                  isFullWidth: true,
                  onPressed: () {
                    // Implement logic to change profile picture
                  },
                ),
                const SizedBox(height: GlassmorphismTheme.md),
                GlassButton(
                  text: 'Update Profile',
                  variant: GlassButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: () {
                    // Implement logic to update profile with new information
                  },
                ),
                const SizedBox(height: GlassmorphismTheme.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool isDark,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: (isDark ? GlassmorphismTheme.bodyStyle : GlassmorphismTheme.bodyStyleLight).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: GlassmorphismTheme.xs),
        GlassCard(
          opacity: 0.05,
          borderRadius: GlassmorphismTheme.radiusMd,
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: isDark ? GlassmorphismTheme.bodyStyle : GlassmorphismTheme.bodyStyleLight,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDark 
                    ? GlassmorphismTheme.textTertiary 
                    : GlassmorphismTheme.textTertiaryLight,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(GlassmorphismTheme.md),
            ),
          ),
        ),
      ],
    );
  }
}