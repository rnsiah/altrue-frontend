import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

class NpProjectCard extends StatelessWidget {
  final NonProfitProject project;
  final bool isForMatchScreen;
  final Profile profile;

  const NpProjectCard({
    super.key,
    required this.project,
    required this.profile,
    required this.isForMatchScreen,
  });

  @override
  Widget build(BuildContext context) {
    final raisedAmount = project.currentFunds ?? 0;
    final goalAmount = double.tryParse(project.fundraisingGoal ?? '0') ?? 1;
    final progress = (raisedAmount / goalAmount).clamp(0.0, 1.0);

    return GlassCard(
      margin: const EdgeInsets.symmetric(
        horizontal: GlassmorphismTheme.md,
        vertical: GlassmorphismTheme.sm,
      ),
      borderRadius: GlassmorphismTheme.radiusXl,
      hasGoldBorder: true,
      onTap: () {
        context.go(
          '/allNpProjects/npProjectDetails',
          extra: NonProfitProjectDetailArguments(
            project: project,
            profile: profile,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(GlassmorphismTheme.radiusXl),
                  topRight: Radius.circular(GlassmorphismTheme.radiusXl),
                ),
                child: project.projectImage != null
                    ? Image.network(
                        project.projectImage!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                          height: 180,
                          color: GlassmorphismTheme.darkTertiary,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: GlassmorphismTheme.gold,
                              size: 50,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 180,
                        color: GlassmorphismTheme.darkTertiary,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: GlassmorphismTheme.gold,
                            size: 50,
                          ),
                        ),
                      ),
              ),
              // Nonprofit Logo
              Positioned(
                top: GlassmorphismTheme.sm,
                left: GlassmorphismTheme.sm,
                child: GlassCard(
                  width: 48,
                  height: 48,
                  borderRadius: GlassmorphismTheme.radiusXl,
                  padding: EdgeInsets.zero,
                  gradient: GlassmorphismTheme.glassGradient,
                  child: ClipOval(
                    child: project.nonprofit?.logo != null
                        ? Image.network(
                            project.nonprofit!.logo,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.business,
                              color: GlassmorphismTheme.gold,
                            ),
                          )
                        : const Icon(Icons.business, color: GlassmorphismTheme.gold),
                  ),
                ),
              ),
              // Favorite Button
              Positioned(
                top: GlassmorphismTheme.sm,
                right: GlassmorphismTheme.sm,
                child: GlassCard(
                  width: 40,
                  height: 40,
                  borderRadius: GlassmorphismTheme.radiusXl,
                  padding: EdgeInsets.zero,
                  gradient: GlassmorphismTheme.glassGradient,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: GlassmorphismTheme.textPrimary,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          // Content Section
          Padding(
            padding: const EdgeInsets.all(GlassmorphismTheme.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cause Tag
                GlassCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: GlassmorphismTheme.sm,
                    vertical: GlassmorphismTheme.xs,
                  ),
                  gradient: GlassmorphismTheme.glassGradient,
                  borderRadius: GlassmorphismTheme.radiusSm,
                  child: Text(
                    project.cause?.name ?? 'General',
                    style: GlassmorphismTheme.captionStyle.copyWith(
                      color: GlassmorphismTheme.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: GlassmorphismTheme.sm),
                // Title
                Text(
                  project.title ?? 'Untitled Project',
                  style: GlassmorphismTheme.h2Style.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: GlassmorphismTheme.xs),
                // Nonprofit Name
                Text(
                  'by ${project.nonprofit?.name ?? 'Unknown'}',
                  style: GlassmorphismTheme.captionStyle.copyWith(
                    color: GlassmorphismTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: GlassmorphismTheme.md),
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusSm),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: GlassmorphismTheme.darkTertiary,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      GlassmorphismTheme.gold,
                    ),
                    minHeight: 6,
                  ),
                ),
                SizedBox(height: GlassmorphismTheme.sm),
                // Progress Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\${raisedAmount.toStringAsFixed(0)}',
                          style: GlassmorphismTheme.h3Style.copyWith(
                            color: GlassmorphismTheme.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'raised of \${goalAmount.toStringAsFixed(0)}',
                          style: GlassmorphismTheme.captionStyle.copyWith(
                            color: GlassmorphismTheme.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    GlassCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: GlassmorphismTheme.md,
                        vertical: GlassmorphismTheme.sm,
                      ),
                      gradient: GlassmorphismTheme.goldGradient,
                      borderRadius: GlassmorphismTheme.radiusXl,
                      child: Text(
                        'Support',
                        style: GlassmorphismTheme.buttonStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}