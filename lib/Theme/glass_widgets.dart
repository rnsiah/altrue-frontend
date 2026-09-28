import 'package:flutter/material.dart';
import 'dart:ui';
import 'glassmorphism_theme.dart';

/// Reusable Glassmorphism Widgets for Altrue Flutter App
///
/// Example usage:
/// ```dart
/// GlassCard(
///   child: Text('Hello World'),
/// )
/// ```

/// A card widget with glassmorphism effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry borderRadius;
  final double blur;
  final double opacity;
  final bool hasShadow;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  GlassCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    dynamic borderRadius = GlassmorphismTheme.radiusLg,
    this.blur = GlassmorphismTheme.blurMedium,
    this.opacity = 0.1,
    this.hasShadow = true,
    this.onTap,
    this.height,
    this.width,
  })  : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardContent = ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(opacity),
                Colors.white.withOpacity(opacity * 0.5),
              ],
            ),
            borderRadius: borderRadius,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );

    if (hasShadow) {
      cardContent = Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: cardContent,
      );
    }

    if (margin != null) {
      cardContent = Padding(padding: margin!, child: cardContent);
    }

    if (onTap != null) {
      cardContent = GestureDetector(onTap: onTap, child: cardContent);
    }

    return cardContent;
  }
}

/// A button widget with glassmorphism effect
class GlassButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isAccent;
  final bool isFullWidth;
  final BorderRadiusGeometry borderRadius;

  GlassButton({
    Key? key,
    this.text,
    this.icon,
    this.onPressed,
    this.isAccent = true,
    this.isFullWidth = false,
    dynamic borderRadius = GlassmorphismTheme.radiusLg,
  })  : borderRadius = borderRadius is double
            ? BorderRadius.all(Radius.circular(borderRadius))
            : borderRadius as BorderRadiusGeometry,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(
          horizontal: GlassmorphismTheme.lg,
          vertical: GlassmorphismTheme.md,
        ),
        decoration: BoxDecoration(
          gradient: isAccent
              ? LinearGradient(
                  colors: [
                    GlassmorphismTheme.gold,
                    GlassmorphismTheme.goldDark,
                  ],
                )
              : null,
          color: isAccent ? null : GlassmorphismTheme.glassWhite,
          borderRadius: borderRadius,
          border: Border.all(
            color: isAccent
                ? GlassmorphismTheme.gold.withOpacity(0.5)
                : Colors.white.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: isAccent
              ? [
                  BoxShadow(
                    color: GlassmorphismTheme.gold.withOpacity(0.3),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: GlassmorphismTheme.blurMedium,
              sigmaY: GlassmorphismTheme.blurMedium,
            ),
            child: _buildChild(),
          ),
        ),
      ),
    );
  }

  Widget _buildChild() {
    final color = isAccent
        ? GlassmorphismTheme.darkPrimary
        : GlassmorphismTheme.textPrimary;

    if (icon != null && text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: GlassmorphismTheme.sm),
          Text(
            text!,
            style: TextStyle(
              color: color,
              fontSize: GlassmorphismTheme.bodySize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else if (icon != null) {
      return Icon(icon, color: color, size: 22);
    } else if (text != null) {
      return Text(
        text!,
        style: TextStyle(
          color: color,
          fontSize: GlassmorphismTheme.bodySize,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

/// A text input field with glassmorphism styling
class GlassInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const GlassInput({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  State<GlassInput> createState() => _GlassInputState();
}

class _GlassInputState extends State<GlassInput> {
  bool _isFocused = false;
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: GlassmorphismTheme.captionStyle.copyWith(
              color: _isFocused
                  ? GlassmorphismTheme.gold
                  : GlassmorphismTheme.textSecondary,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.xs),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: GlassmorphismTheme.blurMedium,
              sigmaY: GlassmorphismTheme.blurMedium,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: GlassmorphismTheme.glassWhite,
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusLg),
                border: Border.all(
                  color: _isFocused
                      ? GlassmorphismTheme.gold
                      : Colors.white.withOpacity(0.2),
                  width: _isFocused ? 2 : 1,
                ),
              ),
              child: Focus(
                onFocusChange: (focused) =>
                    setState(() => _isFocused = focused),
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.obscureText && _isObscured,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  style: GlassmorphismTheme.bodyStyle,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle:
                        const TextStyle(color: GlassmorphismTheme.textTertiary),
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(
                            widget.prefixIcon,
                            color: _isFocused
                                ? GlassmorphismTheme.gold
                                : GlassmorphismTheme.textSecondary,
                          )
                        : null,
                    suffixIcon: widget.obscureText
                        ? IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: GlassmorphismTheme.textSecondary,
                            ),
                            onPressed: () =>
                                setState(() => _isObscured = !_isObscured),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(GlassmorphismTheme.md),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
