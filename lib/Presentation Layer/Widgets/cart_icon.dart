import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

class CartIcon extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  final int notificationCount;

  const CartIcon({
    Key? key,
    this.onTap,
    required this.text,
    required this.iconData,
    required this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider.value(
      value: context.read<CartBloc>(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GlassCard(
                opacity: 0.1,
                borderRadius: GlassmorphismTheme.radiusLg,
                padding: const EdgeInsets.symmetric(
                  horizontal: GlassmorphismTheme.sm,
                  vertical: GlassmorphismTheme.xs,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      iconData,
                      color: isDark
                          ? GlassmorphismTheme.textPrimary
                          : GlassmorphismTheme.textSecondary,
                      size: 24,
                    ),
                    const SizedBox(height: GlassmorphismTheme.xs),
                    Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? GlassmorphismTheme.textSecondary
                            : GlassmorphismTheme.textPrimary,
                        fontSize: GlassmorphismTheme.captionSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GlassCard(
                    opacity: 0.9,
                    borderRadius: GlassmorphismTheme.radiusSm,
                    gradient: GlassmorphismTheme.goldGradient,
                    padding: const EdgeInsets.symmetric(
                      horizontal: GlassmorphismTheme.sm,
                      vertical: GlassmorphismTheme.xs,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(
                        color: GlassmorphismTheme.darkPrimary,
                        fontSize: GlassmorphismTheme.captionSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
