import 'dart:ui';

import 'package:flutter/material.dart';

// Glassmorphism Theme Constants
class GlassTheme {
  // Colors
  static const Color primaryDark = Color(0xFF0A0A0A);
  static const Color secondaryDark = Color(0xFF1A1A1A);
  static const Color accentGold = Color(0xFFFFD700);
  static const Color accentGoldLight = Color(0xFFFFE55C);
  static const Color glassWhite = Colors.white24;
  static const Color glassDark = Colors.black26;

  // Gradients
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A0A0A),
      Color(0xFF1A1A1A),
      Color(0xFF2A2A2A),
    ],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD700),
      Color(0xFFFFE55C),
      Color(0xFFFFED4E),
    ],
  );

  // Spacing Tokens
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 16.0;
  static const double radiusLG = 24.0;
  static const double radiusXL = 32.0;

  // Blur Values
  static const double blurSM = 5.0;
  static const double blurMD = 10.0;
  static const double blurLG = 15.0;

  // Text Styles
  static const TextStyle textGold = TextStyle(
    color: accentGold,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle textWhiteBold = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

// Glassmorphism Card Widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color borderColor;
  final double borderWidth;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = GlassTheme.radiusMD,
    this.blur = GlassTheme.blurMD,
    this.borderColor = GlassTheme.accentGold,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GlassTheme.glassWhite.withOpacity(0.1),
            GlassTheme.glassWhite.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: borderColor.withOpacity(0.3),
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: blur,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(GlassTheme.spacingMD),
            decoration: BoxDecoration(
              color: (isDarkMode ? GlassTheme.glassDark : GlassTheme.glassWhite)
                  .withOpacity(0.1),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Glassmorphism Button Widget
class GlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;

  const GlassButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius = GlassTheme.radiusMD,
    this.blur = GlassTheme.blurSM,
    this.backgroundColor = GlassTheme.accentGold,
    this.borderColor = GlassTheme.accentGold,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor.withOpacity(0.8),
              backgroundColor.withOpacity(0.6),
            ],
          ),
          border: Border.all(
            color: borderColor.withOpacity(0.8),
            width: borderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              blurRadius: blur,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.2),
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

// Glassmorphism App Bar
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;
  final double blur;
  final Color backgroundColor;

  const GlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.blur = GlassTheme.blurMD,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      leading: leading,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: GlassTheme.darkGradient,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              color: backgroundColor.withOpacity(0.1),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
