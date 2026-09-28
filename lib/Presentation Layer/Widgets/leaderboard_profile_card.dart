import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/leaderboard_entry_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart'
    show GlassmorphismTheme;

import 'glassmorphism_widgets.dart';
// import '../theme/glassmorphism_theme.dart';
// import '../widgets/glass/glass_card.dart';

Widget leaderBoardCard(LeaderBoardEntry profile) {
  return GlassCard(
    margin: const EdgeInsets.symmetric(
      vertical: GlassmorphismTheme.sm,
      horizontal: GlassmorphismTheme.md,
    ),
    // hasGoldBorder: profile.levelNumber <= 3, // Gold border for top 3
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
      child: Padding(
        padding: const EdgeInsets.all(GlassmorphismTheme.md),
        child: Row(
          children: [
            // Profile Avatar with Gold Ring for Top Users
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: profile.levelNumber <= 3
                    ? Border.all(
                        color: GlassmorphismTheme.gold,
                        width: 2.0,
                      )
                    : null,
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: GlassmorphismTheme.glassWhite,
                backgroundImage: NetworkImage(profile.profileImage!),
                child: profile.profileImage == null
                    ? Icon(
                        Icons.person,
                        color: GlassmorphismTheme.textSecondary,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: GlassmorphismTheme.md),
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.username,
                    style: GlassmorphismTheme.h3Style.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: GlassmorphismTheme.xs),
                  // Altrue Points
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: GlassmorphismTheme.gold,
                        size: 16,
                      ),
                      const SizedBox(width: GlassmorphismTheme.xs),
                      Text(
                        '${profile.altruePoints} points',
                        style: GlassmorphismTheme.captionStyle.copyWith(
                          color: GlassmorphismTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: GlassmorphismTheme.xs),
                  // Altrue Level
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: profile.levelNumber <= 3
                            ? GlassmorphismTheme.gold
                            : GlassmorphismTheme.textTertiary,
                        size: 16,
                      ),
                      const SizedBox(width: GlassmorphismTheme.xs),
                      Text(
                        'Level ${profile.levelNumber}',
                        style: GlassmorphismTheme.captionStyle.copyWith(
                          color: profile.levelNumber <= 3
                              ? GlassmorphismTheme.gold
                              : GlassmorphismTheme.textSecondary,
                          fontWeight: profile.levelNumber <= 3
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Rank Badge for Top 3
            if (profile.levelNumber <= 3)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: GlassmorphismTheme.sm,
                  vertical: GlassmorphismTheme.xs,
                ),
                decoration: BoxDecoration(
                  gradient: GlassmorphismTheme.goldGradient,
                  borderRadius:
                      BorderRadius.circular(GlassmorphismTheme.radiusSm),
                ),
                child: Text(
                  '#${profile.levelNumber}',
                  style: GlassmorphismTheme.buttonStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
