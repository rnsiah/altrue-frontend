import 'package:flutter/material.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
// import '../theme/glassmorphism_theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor:
              AlwaysStoppedAnimation<Color>(GlassmorphismTheme.goldDark),
        ),
      );
}
