import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/user_model.dart';
// import '../Routers/functionality_router.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

class NonProfitListBox extends StatelessWidget {
  final NonProfit nonprofit;
  final Profile profile;

  const NonProfitListBox({
    super.key,
    required this.nonprofit,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(
        horizontal: GlassmorphismTheme.md,
        vertical: GlassmorphismTheme.sm,
      ),
      borderRadius: GlassmorphismTheme.radiusLg,
      hasGoldBorder: true,
      onTap: () {
        context.go('/nonProfitView',
            extra: NonProfitDetailArguments(
                nonProfit: nonprofit, profile: profile));
      },
      child: Row(
        children: [
          // Logo section
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusMd),
              border: Border.all(
                color: GlassmorphismTheme.gold.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(GlassmorphismTheme.radiusMd - 1),
              child: Image.network(
                nonprofit.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: GlassmorphismTheme.md),

          // Content section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  nonprofit.name,
                  style: GlassmorphismTheme.h3Style.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: GlassmorphismTheme.xs),

                // Category with gold accent
                Text(
                  nonprofit.category![0].name ?? 'Nonprofit Organization',
                  style: GlassmorphismTheme.captionStyle.copyWith(
                    color: GlassmorphismTheme.gold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: GlassmorphismTheme.xs),

                // Description
                Text(
                  nonprofit.description ?? '',
                  style: GlassmorphismTheme.captionStyle.copyWith(
                    color: GlassmorphismTheme.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Arrow icon
          const Icon(
            Icons.arrow_forward_ios,
            color: GlassmorphismTheme.gold,
            size: 16,
          ),
        ],
      ),
    );
  }
}
