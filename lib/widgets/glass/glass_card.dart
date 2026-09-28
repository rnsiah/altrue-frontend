import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';

/// A reusable glass card widget with frosted glass effect
///
/// Features:
/// - BackdropFilter blur (sigmaX/Y: 10)
/// - Gradient background (white 0.1 to 0.05 opacity)
/// - Subtle white border (0.2 opacity)
/// - Configurable border radius, padding, and shadow
/// - Optional gold accent border
///
/// Usage:
/// ```dart
/// GlassCard(
///   child: Text('Hello World'),
///   borderRadius: 20,
///   hasGoldBorder: true,
/// )
/// ```
class GlassCard extends StatelessWidget {
  /// The content inside the card
  final Widget child;

  /// Internal padding (default: 16)
  final EdgeInsetsGeometry? padding;

  /// External margin
  final EdgeInsetsGeometry? margin;

  /// Border radius (default: 16)
  final BorderRadiusGeometry borderRadius;

  /// Blur amount (default: 10)
  final double blur;

  /// Background opacity (default: 0.1)
  final double opacity;

  /// Whether to show shadow (default: true)
  final bool hasShadow;

  /// Whether to show gold accent border (default: false)
  final bool hasGoldBorder;

  /// Tap callback
  final VoidCallback? onTap;

  /// Card height
  final double? height;

  /// Card width
  final double? width;

  /// Background gradient (overrides opacity)
  final Gradient? gradient;

  /// Border color (overrides default)
  final Color? borderColor;

  /// Border width (default: 1)
  final double borderWidth;

  GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(GlassmorphismTheme.md),
    this.margin,
    dynamic borderRadius = GlassmorphismTheme.radiusLg,
    this.blur = GlassmorphismTheme.blurMedium,
    this.opacity = 0.1,
    this.hasShadow = true,
    this.hasGoldBorder = false,
    this.onTap,
    this.height,
    this.width,
    this.gradient,
    this.borderColor,
    this.borderWidth = 1.0,
  }) : borderRadius = (borderRadius is num)
            ? BorderRadius.circular(borderRadius.toDouble())
            : (borderRadius is BorderRadiusGeometry
                ? borderRadius
                : BorderRadius.zero); // Fallback to avoid cast errors

  @override
  Widget build(BuildContext context) {
    // Detect current theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Build the glass card content
    Widget cardContent = ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            gradient: gradient ?? _getGlassGradient(isDark, opacity),
            borderRadius: borderRadius,
            border: Border.all(
              color: borderColor ?? _getBorderColor(isDark),
              width: hasGoldBorder ? 1.5 : borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );

    // Add shadow if enabled
    if (hasShadow) {
      cardContent = Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: GlassmorphismTheme.glassShadow,
        ),
        child: cardContent,
      );
    }

    // Add margin if specified
    if (margin != null) {
      cardContent = Padding(padding: margin!, child: cardContent);
    }

    // Add tap handler if specified
    if (onTap != null) {
      cardContent = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: cardContent,
      );
    }

    return cardContent;
  }

  Color _getBorderColor(bool isDark) {
    if (hasGoldBorder) {
      return GlassmorphismTheme.gold.withOpacity(0.5);
    }
    return isDark
        ? Colors.white.withOpacity(0.2)
        : Colors.black.withOpacity(0.1);
  }

  LinearGradient _getGlassGradient(bool isDark, double opacity) {
    if (isDark) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(opacity),
          Colors.white.withOpacity(opacity * 0.5),
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.black.withOpacity(opacity * 0.8),
          Colors.black.withOpacity(opacity * 0.4),
        ],
      );
    }
  }
}

/// A pre-styled glass card for list items
class GlassListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final bool hasGoldBorder;

  const GlassListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.margin,
    this.hasGoldBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: margin,
      hasGoldBorder: hasGoldBorder,
      onTap: onTap,
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: GlassmorphismTheme.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (subtitle != null) ...[
                  const SizedBox(height: GlassmorphismTheme.xs),
                  subtitle!,
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: GlassmorphismTheme.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
