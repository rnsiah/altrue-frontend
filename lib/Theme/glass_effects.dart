import 'package:flutter/material.dart';
import 'glassmorphism_theme.dart';

/// Glass Effect Presets for Altrue Flutter App
/// 
/// This file provides reusable decoration presets for consistent
/// glassmorphism styling throughout the app.

/// Standard glass container decoration
/// 
/// Usage:
/// ```dart
/// Container(
///   decoration: glassDecoration(),
///   child: MyWidget(),
/// )
/// ```
BoxDecoration glassDecoration({
  double borderRadius = GlassmorphismTheme.radiusLg,
  double opacity = 0.1,
  Color? backgroundColor,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        (backgroundColor ?? Colors.white).withOpacity(opacity),
        (backgroundColor ?? Colors.white).withOpacity(opacity * 0.5),
      ],
    ),
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1,
    ),
  );
}

/// Glass border style
Border glassBorder({double width = 1}) {
  return Border.all(
    color: Colors.white.withOpacity(0.2),
    width: width,
  );
}

/// Gold gradient for accents and buttons
const LinearGradient goldGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    GlassmorphismTheme.gold,
    GlassmorphismTheme.goldDark,
  ],
);

/// Dark gradient for backgrounds
const LinearGradient darkGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    GlassmorphismTheme.darkPrimary,
    GlassmorphismTheme.darkSecondary,
  ],
);

/// Glass shadow
List<BoxShadow> glassShadow({double opacity = 0.2}) {
  return [
    BoxShadow(
      color: Colors.black.withOpacity(opacity),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}

/// Gold glow shadow
List<BoxShadow> goldGlowShadow({double opacity = 0.3}) {
  return [
    BoxShadow(
      color: GlassmorphismTheme.gold.withOpacity(opacity),
      blurRadius: 12,
      spreadRadius: 2,
    ),
  ];
}
