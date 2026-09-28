import 'package:flutter/material.dart';
import 'dart:ui';
import '../../theme/glassmorphism_theme.dart';

/// Glass button variants
enum GlassButtonVariant {
  /// Gold background with dark text
  primary,

  /// Transparent with gold border
  secondary,

  /// Frosted glass background
  glass,
}

/// A reusable glass button with multiple style variants
///
/// Variants:
/// - [GlassButtonVariant.primary]: Gold background (#D4AF37) with dark text
/// - [GlassButtonVariant.secondary]: Transparent with gold border
/// - [GlassButtonVariant.glass]: Frosted glass background
///
/// Usage:
/// ```dart
/// GlassButton(
///   text: 'Click Me',
///   variant: GlassButtonVariant.primary,
///   onPressed: () {},
///   icon: Icons.arrow_forward,
/// )
/// ```
class GlassButton extends StatelessWidget {
  /// Button text
  final String? text;

  /// Leading icon
  final IconData? icon;

  /// Trailing icon (shown after text)
  final IconData? trailingIcon;

  /// Tap callback
  final VoidCallback? onPressed;

  /// Button style variant
  final GlassButtonVariant variant;

  /// Whether button takes full width
  final bool isFullWidth;

  /// Border radius (default: 16)
  final BorderRadiusGeometry borderRadius;

  /// Horizontal padding
  final double? horizontalPadding;

  /// Vertical padding
  final double? verticalPadding;

  /// Button height
  final double? height;

  /// Custom background color (overrides variant)
  final Color? backgroundColor;

  /// Custom text color (overrides variant)
  final Color? textColor;

  /// Whether button is disabled
  final bool isDisabled;

  /// Whether to show loading state
  final bool isLoading;

  /// Loading indicator color
  final Color? loadingColor;

  GlassButton({
    super.key,
    this.text,
    this.icon,
    this.trailingIcon,
    this.onPressed,
    this.variant = GlassButtonVariant.primary,
    this.isFullWidth = false,
    dynamic borderRadius = GlassmorphismTheme.radiusLg,
    this.horizontalPadding,
    this.verticalPadding,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.loadingColor,
  }) : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled || isLoading || onPressed == null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: isFullWidth ? double.infinity : null,
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? GlassmorphismTheme.lg,
          vertical: verticalPadding ?? GlassmorphismTheme.md,
        ),
        decoration: BoxDecoration(
          gradient: _getGradient(),
          color: _getBackgroundColor(),
          borderRadius: borderRadius,
          border: _getBorder(),
          boxShadow: _getShadow(),
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: variant == GlassButtonVariant.glass
                  ? GlassmorphismTheme.blurMedium
                  : 0,
              sigmaY: variant == GlassButtonVariant.glass
                  ? GlassmorphismTheme.blurMedium
                  : 0,
            ),
            child: _buildChild(isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildChild(bool isDark) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            loadingColor ?? _getContentColor(),
          ),
        ),
      );
    }

    final color = _getContentColor();
    final List<Widget> children = [];

    // Leading icon
    if (icon != null) {
      children.add(Icon(icon, color: color, size: 18));
    }

    // Text
    if (text != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: GlassmorphismTheme.sm));
      }
      children.add(
        Text(
          text!,
          style: TextStyle(
            color: textColor ?? color,
            fontSize: GlassmorphismTheme.bodySize,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    // Trailing icon
    if (trailingIcon != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: GlassmorphismTheme.sm));
      }
      children.add(Icon(trailingIcon, color: color, size: 18));
    }

    // Icon-only button
    if (children.isEmpty && icon != null) {
      return Icon(icon, color: color, size: 22);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Gradient? _getGradient() {
    if (backgroundColor != null) return null;

    switch (variant) {
      case GlassButtonVariant.primary:
        return GlassmorphismTheme.goldGradient;
      case GlassButtonVariant.secondary:
      case GlassButtonVariant.glass:
        return null;
    }
  }

  Color? _getBackgroundColor() {
    if (backgroundColor != null) {
      return isDisabled ? backgroundColor!.withOpacity(0.5) : backgroundColor;
    }

    switch (variant) {
      case GlassButtonVariant.primary:
        return null; // Uses gradient
      case GlassButtonVariant.secondary:
        return Colors.transparent;
      case GlassButtonVariant.glass:
        return isDisabled
            ? GlassmorphismTheme.glassWhite.withOpacity(0.05)
            : GlassmorphismTheme.glassWhite;
    }
  }

  Border _getBorder() {
    final color = borderColor ?? _getDefaultBorderColor();
    final width = variant == GlassButtonVariant.secondary ? 1.5 : 1.0;

    return Border.all(
      color: isDisabled ? color.withOpacity(0.3) : color,
      width: width,
    );
  }

  Color _getDefaultBorderColor() {
    switch (variant) {
      case GlassButtonVariant.primary:
        return GlassmorphismTheme.gold.withOpacity(0.5);
      case GlassButtonVariant.secondary:
        return GlassmorphismTheme.gold;
      case GlassButtonVariant.glass:
        return Colors.white.withOpacity(0.2);
    }
  }

  List<BoxShadow>? _getShadow() {
    if (isDisabled) return null;

    switch (variant) {
      case GlassButtonVariant.primary:
        return GlassmorphismTheme.goldShadow;
      case GlassButtonVariant.secondary:
      case GlassButtonVariant.glass:
        return null;
    }
  }

  Color _getContentColor() {
    if (textColor != null) return textColor!;

    switch (variant) {
      case GlassButtonVariant.primary:
        return GlassmorphismTheme.darkPrimary;
      case GlassButtonVariant.secondary:
      case GlassButtonVariant.glass:
        return isDisabled
            ? GlassmorphismTheme.textDisabled
            : GlassmorphismTheme.textPrimary;
    }
  }

  Color? get borderColor => null;
}

/// Icon-only glass button
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final GlassButtonVariant variant;
  final double size;
  final double borderRadius;
  final bool isDisabled;

  const GlassIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = GlassButtonVariant.glass,
    this.size = 44,
    this.borderRadius = GlassmorphismTheme.radiusLg,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: GlassButton(
        icon: icon,
        onPressed: onPressed,
        variant: variant,
        borderRadius: borderRadius,
        isDisabled: isDisabled,
        horizontalPadding: 0,
        verticalPadding: 0,
      ),
    );
  }
}
