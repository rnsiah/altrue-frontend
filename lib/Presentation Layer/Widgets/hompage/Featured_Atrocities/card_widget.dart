import 'package:flutter/material.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/glassmorphism_widgets.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';

class CardWidget extends StatelessWidget {
  final String image;
  final String name;
  final String category;
  const CardWidget({
    required this.image,
    required this.name,
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('The Last Day Of summer');
      },
      child: GlassCard(
        // height: 450,
        margin: const EdgeInsets.all(GlassmorphismTheme.md),
        // hasGoldBorder: true,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Background image with overlay
            Positioned.fill(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusLg),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Dark overlay for better text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(GlassmorphismTheme.radiusLg),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(GlassmorphismTheme.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GlassmorphismTheme.h2Style.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.sm),
                  Text(
                    category,
                    style: GlassmorphismTheme.captionStyle.copyWith(
                      color: GlassmorphismTheme.gold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
