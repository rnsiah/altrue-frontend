import 'package:flutter/material.dart';
import 'dart:ui';
import '../../theme/glassmorphism_theme.dart';

/// A reusable glass text input widget with frosted glass effect
/// 
/// Features:
/// - Frosted glass background
/// - Gold focus border
/// - White placeholder text
/// - Proper padding (16px)
/// - Dark theme compatible
/// - Password visibility toggle
/// - Prefix/suffix icons
/// 
/// Usage:
/// ```dart
/// GlassInput(
///   hintText: 'Enter your email',
///   prefixIcon: Icons.email,
///   keyboardType: TextInputType.emailAddress,
/// )
/// ```
class GlassInput extends StatefulWidget {
  /// Text controller
  final TextEditingController? controller;
  
  /// Placeholder text
  final String? hintText;
  
  /// Label text (shown above input)
  final String? labelText;
  
  /// Icon shown at the start
  final IconData? prefixIcon;
  
  /// Widget shown at the end
  final Widget? suffix;
  
  /// Icon shown at the end (alternative to suffix widget)
  final IconData? suffixIcon;
  
  /// Callback when suffix icon is tapped
  final VoidCallback? onSuffixTap;
  
  /// Whether to obscure text (for passwords)
  final bool obscureText;
  
  /// Keyboard type
  final TextInputType? keyboardType;
  
  /// Text input action
  final TextInputAction? textInputAction;
  
  /// Value change callback
  final ValueChanged<String>? onChanged;
  
  /// Submit callback
  final ValueChanged<String>? onSubmitted;
  
  /// Focus node
  final FocusNode? focusNode;
  
  /// Whether input is enabled
  final bool enabled;
  
  /// Validator function
  final String? Function(String?)? validator;
  
  /// Max lines (1 for single line, null/null for multiline)
  final int? maxLines;
  
  /// Min lines
  final int? minLines;
  
  /// Whether to show character counter
  final bool showCounter;
  
  /// Max length
  final int? maxLength;
  
  /// Autofill hints
  final Iterable<String>? autofillHints;
  
  /// Border radius
  final double borderRadius;
  
  /// Content padding
  final EdgeInsetsGeometry? contentPadding;

  const GlassInput({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
    this.validator,
    this.maxLines = 1,
    this.minLines,
    this.showCounter = false,
    this.maxLength,
    this.autofillHints,
    this.borderRadius = GlassmorphismTheme.radiusLg,
    this.contentPadding,
  });

  @override
  State<GlassInput> createState() => _GlassInputState();
}

class _GlassInputState extends State<GlassInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscured = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _validate(String value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
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
        
        // Input field
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: GlassmorphismTheme.blurMedium,
              sigmaY: GlassmorphismTheme.blurMedium,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.enabled 
                    ? GlassmorphismTheme.glassWhite 
                    : GlassmorphismTheme.glassWhite.withOpacity(0.05),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: _getBorderColor(),
                  width: _isFocused ? 2 : 1,
                ),
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                obscureText: widget.obscureText && _isObscured,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                enabled: widget.enabled,
                maxLines: widget.obscureText ? 1 : widget.maxLines,
                minLines: widget.minLines,
                maxLength: widget.showCounter ? widget.maxLength : null,
                autofillHints: widget.autofillHints,
                style: GlassmorphismTheme.bodyStyle.copyWith(
                  color: widget.enabled 
                      ? GlassmorphismTheme.textPrimary 
                      : GlassmorphismTheme.textDisabled,
                ),
                onChanged: (value) {
                  _validate(value);
                  widget.onChanged?.call(value);
                },
                onSubmitted: widget.onSubmitted,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: GlassmorphismTheme.textTertiary,
                  ),
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          color: _isFocused
                              ? GlassmorphismTheme.gold
                              : GlassmorphismTheme.textSecondary,
                          size: 20,
                        )
                      : null,
                  suffixIcon: _buildSuffix(),
                  border: InputBorder.none,
                  contentPadding: widget.contentPadding ?? const EdgeInsets.all(GlassmorphismTheme.md),
                  counterText: widget.showCounter ? null : '',
                ),
              ),
            ),
          ),
        ),
        
        // Error text
        if (_errorText != null) ...[
          const SizedBox(height: GlassmorphismTheme.xs),
          Text(
            _errorText!,
            style: GlassmorphismTheme.captionStyle.copyWith(
              color: Colors.redAccent,
            ),
          ),
        ],
      ],
    );
  }

  Color _getBorderColor() {
    if (_errorText != null) {
      return Colors.redAccent;
    }
    if (_isFocused) {
      return GlassmorphismTheme.gold;
    }
    return Colors.white.withOpacity(0.2);
  }

  Widget? _buildSuffix() {
    // Password visibility toggle
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: GlassmorphismTheme.textSecondary,
          size: 20,
        ),
        onPressed: () => setState(() => _isObscured = !_isObscured),
      );
    }
    
    // Custom suffix widget
    if (widget.suffix != null) {
      return widget.suffix;
    }
    
    // Suffix icon
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(
          widget.suffixIcon,
          color: _isFocused 
              ? GlassmorphismTheme.gold 
              : GlassmorphismTheme.textSecondary,
          size: 20,
        ),
        onPressed: widget.onSuffixTap,
      );
    }
    
    return null;
  }
}

/// A glass search input with built-in search icon
class GlassSearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final FocusNode? focusNode;

  const GlassSearchInput({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return GlassInput(
      controller: controller,
      hintText: hintText,
      prefixIcon: Icons.search,
      suffixIcon: controller?.text.isNotEmpty == true ? Icons.clear : null,
      onSuffixTap: () {
        controller?.clear();
        onClear?.call();
        onChanged?.call('');
      },
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
    );
  }
}

/// A multiline glass text area
class GlassTextArea extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final int? maxLength;

  const GlassTextArea({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.maxLines = 4,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return GlassInput(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      maxLines: maxLines,
      maxLength: maxLength,
      showCounter: maxLength != null,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
