import 'package:flutter/material.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'dart:ui';

/// GlassCard - A glassmorphism container with blur effect and border
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;
  final Color? color;
  final double blur;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(GlassmorphismTheme.md),
    this.margin = EdgeInsets.zero,
    dynamic borderRadius = GlassmorphismTheme.radiusLg,
    this.color,
    this.blur = GlassmorphismTheme.blurMedium,
    this.border,
    this.boxShadow,
    this.gradient,
  }) : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow ?? GlassmorphismTheme.glassShadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ??
                  (isDark
                      ? GlassmorphismTheme.glassWhite
                      : GlassmorphismTheme.glassBlack),
              borderRadius: borderRadius,
              border: border ??
                  Border.all(
                    color: isDark
                        ? GlassmorphismTheme.glassBorder
                        : GlassmorphismTheme.glassBorderLight,
                    width: 1,
                  ),
              gradient: gradient ??
                  (isDark
                      ? GlassmorphismTheme.glassGradient
                      : GlassmorphismTheme.glassGradientLight),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// GlassButton - A glassmorphism button with gradient background
class GlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry borderRadius;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;
  final double height;
  final double? width;
  final bool isGold;
  final bool isOutlined;

  GlassButton({
    super.key,
    required this.child,
    this.onPressed,
    dynamic borderRadius = GlassmorphismTheme.radiusLg,
    this.gradient,
    this.padding = const EdgeInsets.symmetric(
      horizontal: GlassmorphismTheme.lg,
      vertical: GlassmorphismTheme.sm,
    ),
    this.height = 48,
    this.width,
    this.isGold = false,
    this.isOutlined = false,
  }) : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          gradient: isGold ? GlassmorphismTheme.goldGradient : gradient,
          borderRadius: borderRadius,
          border: isOutlined
              ? Border.all(
                  color: GlassmorphismTheme.gold.withOpacity(0.5),
                  width: 2,
                )
              : null,
          boxShadow: isGold ? GlassmorphismTheme.goldShadow : [],
        ),
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              color: isGold || (gradient != null && !isOutlined)
                  ? (isDark
                      ? GlassmorphismTheme.darkPrimary
                      : GlassmorphismTheme.lightPrimary)
                  : GlassmorphismTheme.gold,
              fontSize: GlassmorphismTheme.bodySize,
              fontWeight: FontWeight.w600,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// GlassTextField - A glassmorphism text input field
class GlassTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadiusGeometry borderRadius;
  final Color? fillColor;
  final Color? borderColor;

  GlassTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.contentPadding,
    dynamic borderRadius = GlassmorphismTheme.radiusLg,
    this.fillColor,
    this.borderColor,
  }) : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: EdgeInsets.zero,
      borderRadius: borderRadius,
      color: fillColor,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        style: TextStyle(
          color: isDark
              ? GlassmorphismTheme.textPrimary
              : GlassmorphismTheme.textPrimaryLight,
          fontSize: GlassmorphismTheme.bodySize,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark
                ? GlassmorphismTheme.textTertiary
                : GlassmorphismTheme.textTertiaryLight,
            fontSize: GlassmorphismTheme.bodySize,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              contentPadding ?? const EdgeInsets.all(GlassmorphismTheme.md),
        ),
      ),
    );
  }
}

/// GoldBadge - A gold-accented badge for match percentages
class GoldBadge extends StatelessWidget {
  final String text;
  final IconData? icon;
  final BorderRadiusGeometry borderRadius;
  final bool isCampaign;

  GoldBadge({
    super.key,
    required this.text,
    this.icon,
    dynamic borderRadius = GlassmorphismTheme.radiusSm,
    this.isCampaign = false,
  }) : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GlassmorphismTheme.sm,
        vertical: GlassmorphismTheme.xs,
      ),
      decoration: BoxDecoration(
        gradient: isCampaign
            ? LinearGradient(
                colors: [
                  Colors.purple.shade700,
                  Colors.purple.shade900,
                ],
              )
            : LinearGradient(
                colors: [
                  GlassmorphismTheme.gold,
                  GlassmorphismTheme.goldDark,
                ],
              ),
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: GlassmorphismTheme.gold.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: Colors.white,
              size: 12,
            ),
            const SizedBox(width: GlassmorphismTheme.xs),
          ],
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: GlassmorphismTheme.captionSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// GlassChip - A glassmorphism filter chip
class GlassChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final BorderRadiusGeometry borderRadius;

  GlassChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    dynamic borderRadius = GlassmorphismTheme.radiusSm,
  }) : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(
          horizontal: GlassmorphismTheme.sm,
          vertical: GlassmorphismTheme.xs,
        ),
        borderRadius: borderRadius,
        color: isSelected
            ? GlassmorphismTheme.gold.withOpacity(0.2)
            : (isDark
                ? GlassmorphismTheme.glassWhiteSubtle
                : GlassmorphismTheme.glassBlackSubtle),
        border: Border.all(
          color: isSelected
              ? GlassmorphismTheme.gold
              : (isDark
                      ? GlassmorphismTheme.glassBorder
                      : GlassmorphismTheme.glassBorderLight)
                  .withOpacity(0.5),
          width: 1,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? GlassmorphismTheme.gold
                : (isDark
                    ? GlassmorphismTheme.textPrimary
                    : GlassmorphismTheme.textPrimaryLight),
            fontSize: GlassmorphismTheme.bodySize,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

/// GlassAppBar - A glassmorphism app bar
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final double elevation;
  final BorderRadiusGeometry borderRadius;
  final Color? backgroundColor;

  GlassAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.elevation = 0,
    dynamic borderRadius = BorderRadius.zero,
    this.backgroundColor,
  }) : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      margin: EdgeInsets.zero,
      borderRadius: borderRadius,
      color: backgroundColor ??
          (isDark
              ? GlassmorphismTheme.glassWhite
              : GlassmorphismTheme.glassBlack),
      child: AppBar(
        title: title,
        actions: actions,
        leading: leading,
        elevation: elevation,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark
            ? GlassmorphismTheme.textPrimary
            : GlassmorphismTheme.textPrimaryLight,
      ),
    );
  }
}
