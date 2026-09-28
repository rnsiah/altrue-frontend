import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/leaderboard_entry_model.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

class LeaderboardWidget extends StatelessWidget {
  final List<LeaderBoardEntry> leaders; // List of leaderboard entries
  final VoidCallback onSeeBoardPressed; // Callback for the 'See Board' button

  const LeaderboardWidget({
    required this.leaders,
    required this.onSeeBoardPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title: Altrue Leaders
              Text(
                'Altrue Leaders',
                style: GlassmorphismTheme.h2Style.copyWith(
                  color: GlassmorphismTheme.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Button: See Board
              GlassCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: GlassmorphismTheme.md,
                  vertical: GlassmorphismTheme.sm,
                ),
                hasGoldBorder: true,
                onTap: onSeeBoardPressed,
                child: Text(
                  'See Board',
                  style: GlassmorphismTheme.buttonStyle.copyWith(
                    fontSize: GlassmorphismTheme.bodySize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: GlassmorphismTheme.md), // Add some spacing
        // Leaderboard list
        SizedBox(
          height: 140, // Adjusted height for better visual balance
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            itemCount: leaders.length > 8 ? 8 : leaders.length,
            padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
            itemBuilder: (context, index) {
              final leader = leaders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.xs),
                child: _buildLeaderCard(leader, index + 1),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderCard(LeaderBoardEntry leader, int rank) {
    final isTopThree = rank <= 3;
    
    return GlassCard(
      width: 120,
      hasGoldBorder: isTopThree,
      padding: const EdgeInsets.all(GlassmorphismTheme.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Rank Badge for Top 3
          if (isTopThree)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: GlassmorphismTheme.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                gradient: GlassmorphismTheme.goldGradient,
                borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusSm),
              ),
              child: Text(
                '#$rank',
                style: GlassmorphismTheme.buttonStyle.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isTopThree) const SizedBox(height: GlassmorphismTheme.xs),
          
          // Circle avatar for profile image
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isTopThree
                  ? Border.all(
                      color: GlassmorphismTheme.gold,
                      width: 2.0,
                    )
                  : null,
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: GlassmorphismTheme.glassWhite,
              backgroundImage: leader.profileImage != null
                  ? NetworkImage(leader.profileImage!)
                  : const AssetImage('assets/default_avatar.png') as ImageProvider,
              child: leader.profileImage == null
                  ? Icon(
                      Icons.person,
                      color: GlassmorphismTheme.textSecondary,
                      size: 24,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          
          // Leader's name
          Text(
            leader.username,
            style: GlassmorphismTheme.captionStyle.copyWith(
              fontSize: 13,
              fontWeight: isTopThree ? FontWeight.bold : FontWeight.w500,
              color: isTopThree ? GlassmorphismTheme.gold : GlassmorphismTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          
          // Leader's points
          Text(
            '${leader.altruePoints} pts',
            style: GlassmorphismTheme.captionStyle.copyWith(
              fontSize: 11,
              color: GlassmorphismTheme.textTertiary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
