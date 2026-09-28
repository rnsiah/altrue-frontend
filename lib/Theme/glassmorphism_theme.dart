import 'package:flutter/material.dart';
import 'dart:ui';

/// Glassmorphism Design System for Altrue Flutter App
///
/// A comprehensive design system featuring:
/// - Gold accent color (#D4AF37) for premium branding
/// - Dark theme foundations (#121212, #1e1e1e)
/// - Glass morphism effects with translucent overlays
///
/// Usage:
/// ```dart
/// import 'package:lovelovelove/theme/glassmorphism_theme.dart';
///
/// Container(
///   color: GlassmorphismTheme.darkPrimary,
///   child: Text('Hello', style: GlassmorphismTheme.heroStyle),
/// )
/// ```
class GlassmorphismTheme {
  const GlassmorphismTheme();

  static GlassmorphismTheme of(BuildContext context) {
    return const GlassmorphismTheme();
  }

  // ==================== INSTANCE PROPERTIES ====================

  /// Primary gold color instance getter
  Color get goldColor => gold;

  /// Spacing instance getter
  GlassmorphismSpacing get spacing => const GlassmorphismSpacing();

  /// Dark gradient instance getter
  LinearGradient get darkGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          darkPrimary,
          darkSecondary,
          darkTertiary,
        ],
      );

  // ==================== COLOR CONSTANTS ====================

  /// Primary gold - #D4AF37
  /// Used for primary actions, accents, and highlights
  static const Color gold = Color(0xFFD4AF37);

  /// Light gold variant
  static const Color goldLight = Color(0xFFE5C158);

  /// Dark gold variant
  static const Color goldDark = Color(0xFFB8962E);

  /// Dark primary background - #121212
  static const Color darkPrimary = Color(0xFF121212);

  /// Dark secondary background - #1e1e1e
  static const Color darkSecondary = Color(0xFF1e1e1e);

  /// Dark tertiary background
  static const Color darkTertiary = Color(0xFF2c2c2c);

  /// Glass white - rgba(255,255,255,0.1)
  static const Color glassWhite = Color(0x1AFFFFFF);

  /// Stronger glass white
  static const Color glassWhiteStrong = Color(0x33FFFFFF);

  /// Subtle glass white
  static const Color glassWhiteSubtle = Color(0x0DFFFFFF);

  /// Glass border - white with 0.2 opacity
  static const Color glassBorder = Color(0x33FFFFFF);

  /// Primary text - white
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary text - 70% white
  static const Color textSecondary = Color(0xB3FFFFFF);

  /// Tertiary text - 50% white
  static const Color textTertiary = Color(0x80FFFFFF);

  /// Disabled text - 38% white
  static const Color textDisabled = Color(0x61FFFFFF);

  // ==================== TYPOGRAPHY SCALE ====================

  /// Hero text - 32px
  static const double heroSize = 32.0;

  /// H1 - 24px
  static const double h1Size = 24.0;

  /// H2 - 20px
  static const double h2Size = 20.0;

  /// H3 - 16px
  static const double h3Size = 16.0;

  /// Body - 14px
  static const double bodySize = 14.0;

  /// Caption - 12px
  static const double captionSize = 12.0;

  // ==================== SPACING TOKENS ====================

  /// Extra small - 4px
  static const double xs = 4.0;

  /// Small - 8px
  static const double sm = 8.0;

  /// Medium - 16px
  static const double md = 16.0;

  /// Large - 24px
  static const double lg = 24.0;

  /// Extra large - 32px
  static const double xl = 32.0;

  // ==================== BORDER RADIUS ====================

  /// Small radius - 8px
  static const double radiusSm = 8.0;

  /// Medium radius - 12px
  static const double radiusMd = 12.0;

  /// Large radius - 16px
  static const double radiusLg = 16.0;

  /// Extra large radius - 20px
  static const double radiusXl = 20.0;

  /// Double extra large radius - 24px
  static const double radius2Xl = 24.0;

  // ==================== BLUR VALUES ====================

  /// Light blur
  static const double blurLight = 5.0;

  /// Medium blur - default for glass effects
  static const double blurMedium = 10.0;

  /// Heavy blur
  static const double blurHeavy = 20.0;

  // ======

  static var lightPrimary;

  // ============== SHADOWS ====================

  /// Default glass shadow
  static List<BoxShadow> get glassShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  /// Gold glow shadow
  static List<BoxShadow> get goldShadow => [
        BoxShadow(
          color: gold.withOpacity(0.3),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  // ==================== TEXT STYLES ====================

  /// Hero text style - 32px, bold
  static TextStyle get heroStyle => const TextStyle(
        fontSize: heroSize,
        fontWeight: FontWeight.bold,
        color: textPrimary,
        height: 1.2,
        letterSpacing: -0.5,
      );

  /// H1 text style - 24px, semibold
  static TextStyle get h1Style => const TextStyle(
        fontSize: h1Size,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.3,
        letterSpacing: -0.3,
      );

  /// H2 text style - 20px, medium
  static TextStyle get h2Style => const TextStyle(
        fontSize: h2Size,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        height: 1.4,
        letterSpacing: -0.2,
      );

  /// H3 text style - 16px, medium
  static TextStyle get h3Style => const TextStyle(
        fontSize: h3Size,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        height: 1.4,
      );

  /// Body text style - 14px, regular
  static TextStyle get bodyStyle => const TextStyle(
        fontSize: bodySize,
        fontWeight: FontWeight.normal,
        color: textPrimary,
        height: 1.5,
      );

  /// Caption text style - 12px, regular
  static TextStyle get captionStyle => const TextStyle(
        fontSize: captionSize,
        fontWeight: FontWeight.normal,
        color: textSecondary,
        height: 1.5,
        letterSpacing: 0.2,
      );

  /// Button text style
  static TextStyle get buttonStyle => const TextStyle(
        fontSize: bodySize,
        fontWeight: FontWeight.w600,
        color: darkPrimary,
        height: 1.0,
      );

  /// Hero text style (light mode) - 32px, bold
  static TextStyle get heroStyleLight => TextStyle(
        fontSize: heroSize,
        fontWeight: FontWeight.bold,
        color: textPrimaryLight,
        height: 1.2,
        letterSpacing: -0.5,
      );

  /// H1 text style (light mode) - 24px, semibold
  static TextStyle get h1StyleLight => TextStyle(
        fontSize: h1Size,
        fontWeight: FontWeight.w600,
        color: textPrimaryLight,
        height: 1.3,
        letterSpacing: -0.3,
      );

  /// H2 text style (light mode) - 20px, medium
  static TextStyle get h2StyleLight => TextStyle(
        fontSize: h2Size,
        fontWeight: FontWeight.w500,
        color: textPrimaryLight,
        height: 1.4,
        letterSpacing: -0.2,
      );

  /// H3 text style (light mode) - 16px, medium
  static TextStyle get h3StyleLight => TextStyle(
        fontSize: h3Size,
        fontWeight: FontWeight.w500,
        color: textPrimaryLight,
        height: 1.4,
      );

  /// Body text style (light mode) - 14px, regular
  static TextStyle get bodyStyleLight => TextStyle(
        fontSize: bodySize,
        fontWeight: FontWeight.normal,
        color: textPrimaryLight,
        height: 1.5,
      );

  /// Caption text style (light mode) - 12px, regular
  static TextStyle get captionStyleLight => TextStyle(
        fontSize: captionSize,
        fontWeight: FontWeight.normal,
        color: textSecondaryLight,
        height: 1.5,
        letterSpacing: 0.2,
      );

  /// Button text style (light mode)
  static TextStyle get buttonStyleLight => TextStyle(
        fontSize: bodySize,
        fontWeight: FontWeight.w600,
        color: lightPrimary,
        height: 1.0,
      );

  // ==================== GRADIENTS ====================

  /// Standard glass gradient (white 0.1 to 0.05)
  static LinearGradient get glassGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ],
      );

  /// Stronger glass gradient
  static LinearGradient get glassGradientStrong => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.1),
        ],
      );

  /// Light mode glass gradient (black 0.05 to 0.1)
  static LinearGradient get glassGradientLight => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.black.withOpacity(0.05),
          Colors.black.withOpacity(0.1),
        ],
      );

  /// Stronger light mode glass gradient
  static LinearGradient get glassGradientLightStrong => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.black.withOpacity(0.1),
          Colors.black.withOpacity(0.2),
        ],
      );

  /// Gold gradient for premium elements
  static LinearGradient get goldGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          gold,
          goldDark,
        ],
      );

  // ==================== LIGHT MODE COLORS ====================

  /// Light primary background - #FFFFFF
  // static const Color lightPrimary = Color(0xFFFFFFFF);

  /// Light secondary background - #F5F5F5
  static const Color lightSecondary = Color(0xFFF5F5F5);

  /// Light tertiary background - #E8E8E8
  static const Color lightTertiary = Color(0xFFE8E8E8);

  /// Glass black - rgba(0,0,0,0.1)
  static const Color glassBlack = Color(0x1A000000);

  /// Stronger glass black
  static const Color glassBlackStrong = Color(0x33000000);

  /// Subtle glass black
  static const Color glassBlackSubtle = Color(0x0D000000);

  /// Glass border (light mode) - black with 0.1 opacity
  static const Color glassBorderLight = Color(0x1A000000);

  /// Primary text (light mode) - dark gray for better contrast
  static const Color textPrimaryLight = Color(0xFF212121);

  /// Secondary text (light mode) - 70% black
  static const Color textSecondaryLight = Color(0xB3000000);

  /// Tertiary text (light mode) - 50% black
  static const Color textTertiaryLight = Color(0x80000000);

  /// Disabled text (light mode) - 38% black
  static const Color textDisabledLight = Color(0x61000000);

  // ==================== THEME DATA ====================

  /// Complete dark theme configuration
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: gold,
        scaffoldBackgroundColor: darkPrimary,
        colorScheme: const ColorScheme.dark(
          primary: gold,
          secondary: gold,
          surface: darkSecondary,
          background: darkPrimary,
          onPrimary: darkPrimary,
          onSecondary: darkPrimary,
          onSurface: textPrimary,
          onBackground: textPrimary,
        ),
        textTheme: TextTheme(
          displayLarge: heroStyle,
          headlineLarge: h1Style,
          headlineMedium: h2Style,
          titleLarge: h3Style,
          bodyLarge: bodyStyle,
          bodyMedium: bodyStyle,
          bodySmall: captionStyle,
        ),
        cardTheme: CardThemeData(
          color: darkSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: glassWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLg),
            borderSide: const BorderSide(color: glassBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLg),
            borderSide: const BorderSide(color: glassBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLg),
            borderSide: const BorderSide(color: gold, width: 2),
          ),
          hintStyle: const TextStyle(color: textTertiary),
          contentPadding: const EdgeInsets.all(md),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: darkPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: lg, vertical: sm),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            textStyle: buttonStyle,
          ),
        ),
      );

  /// Complete light theme configuration
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: gold,
        scaffoldBackgroundColor: lightPrimary,
        colorScheme: const ColorScheme.light(
          primary: gold,
          secondary: gold,
          surface: lightSecondary,
          // background: lightPrimary,
          onPrimary: darkPrimary,
          onSecondary: darkPrimary,
          onSurface: textPrimaryLight,
          onBackground: textPrimaryLight,
        ),
        textTheme: TextTheme(
          displayLarge: heroStyleLight,
          headlineLarge: h1StyleLight,
          headlineMedium: h2StyleLight,
          titleLarge: h3StyleLight,
          bodyLarge: bodyStyleLight,
          bodyMedium: bodyStyleLight,
          bodySmall: captionStyleLight,
        ),
        cardTheme: CardThemeData(
          color: lightSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: glassBlackSubtle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLg),
            borderSide: const BorderSide(color: glassBorderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLg),
            borderSide: const BorderSide(color: glassBorderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLg),
            borderSide: const BorderSide(color: gold, width: 2),
          ),
          hintStyle: TextStyle(color: textTertiaryLight),
          contentPadding: const EdgeInsets.all(md),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: lightPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: lg, vertical: sm),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            textStyle: buttonStyleLight,
          ),
        ),
      );
}

/// Helper class for spacing tokens
class GlassmorphismSpacing {
  const GlassmorphismSpacing();

  double get xsmall => GlassmorphismTheme.xs;
  double get small => GlassmorphismTheme.sm;
  double get medium => GlassmorphismTheme.md;
  double get large => GlassmorphismTheme.lg;
  double get xlarge => GlassmorphismTheme.xl;
}
