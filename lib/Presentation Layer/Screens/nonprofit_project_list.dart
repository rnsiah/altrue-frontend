import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/widgets/glass/glass_card.dart';
import 'package:lovelovelove/widgets/glass/glass_button.dart';
import 'package:lovelovelove/theme/glassmorphism_theme.dart';

import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/user_model.dart';

class NonProfitProjectList extends StatefulWidget {
  final NonProfit nonprofit;
  final Profile profile;
  final String nonprofitId;
  const NonProfitProjectList({
    super.key,
    required this.nonprofit,
    required this.profile,
    required this.nonprofitId,
  });

  @override
  State<NonProfitProjectList> createState() => _NonProfitProjectListState();
}

class _NonProfitProjectListState extends State<NonProfitProjectList> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: GlassmorphismTheme.gold,
        onPressed: () => context.go(
          '/createProject',
          extra: CreateProjectArguments(
            nonprofit: widget.nonprofit,
            profile: widget.profile,
          ),
        ),
        label: Text(
          'Add Project',
          style: GlassmorphismTheme.buttonStyle,
        ),
        icon: Icon(
          Icons.add_circle_outline,
          color: GlassmorphismTheme.darkPrimary,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'NonProfit Projects',
          style: GlassmorphismTheme.h1Style,
        ),
        actions: [
          GlassButton(
            onPressed: () => context.go(
              '/createProject',
              extra: CreateProjectArguments(
                nonprofit: widget.nonprofit,
                profile: widget.profile,
              ),
            ),
            icon: Icons.add_circle_outline,
            text: 'New',
          ),
          const SizedBox(width: GlassmorphismTheme.sm),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ]
                : [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ],
          ),
        ),
        child: SafeArea(
          child: widget.nonprofit.projects?.isNotEmpty == true
              ? ListView.builder(
                  padding: const EdgeInsets.all(GlassmorphismTheme.md),
                  scrollDirection: Axis.vertical,
                  itemCount: widget.nonprofit.projects!.length,
                  itemBuilder: (context, index) => _buildProjectCard(
                    widget.nonprofit.projects![index],
                  ),
                )
              : _buildEmptyState(),
        ),
      ),
    );
  }

  Widget _buildProjectCard(NonProfitProject project) {
    final isActive = project.isActive ?? false;
    final isPending = project.isActive == null;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: GlassmorphismTheme.md),
      hasGoldBorder: isActive,
      onTap: () => _handleProjectTap(project),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: GlassmorphismTheme.h3Style.copyWith(
                        color: isActive
                            ? GlassmorphismTheme.gold
                            : GlassmorphismTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (project.cause != null) ...[
                      const SizedBox(height: GlassmorphismTheme.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GlassmorphismTheme.sm,
                          vertical: GlassmorphismTheme.xs,
                        ),
                        decoration: BoxDecoration(
                          color: GlassmorphismTheme.gold.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                              GlassmorphismTheme.radiusSm),
                        ),
                        child: Text(
                          project.cause!.name!,
                          style: GlassmorphismTheme.captionStyle.copyWith(
                            color: GlassmorphismTheme.gold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: GlassmorphismTheme.md),
              _buildStatusChip(isActive, isPending),
            ],
          ),

          const SizedBox(height: GlassmorphismTheme.md),

          // Description
          if (project.information?.isNotEmpty == true) ...[
            Text(
              project.information!,
              style: GlassmorphismTheme.bodyStyle.copyWith(
                color: GlassmorphismTheme.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: GlassmorphismTheme.md),
          ],

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Followers
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 16,
                    color: isActive
                        ? GlassmorphismTheme.gold
                        : GlassmorphismTheme.textSecondary,
                  ),
                  const SizedBox(width: GlassmorphismTheme.xs),
                  Text(
                    '${project.followers?.length ?? 0} followers',
                    style: GlassmorphismTheme.captionStyle.copyWith(
                      color: isActive
                          ? GlassmorphismTheme.gold
                          : GlassmorphismTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Funding Progress
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 16,
                    color: isActive
                        ? GlassmorphismTheme.gold
                        : GlassmorphismTheme.textSecondary,
                  ),
                  const SizedBox(width: GlassmorphismTheme.xs),
                  Text(
                    '\$${project.currentFunds ?? 0} / \$${project.fundraisingGoal ?? 0}',
                    style: GlassmorphismTheme.captionStyle.copyWith(
                      color: isActive
                          ? GlassmorphismTheme.gold
                          : GlassmorphismTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Progress Bar
          if (project.fundraisingGoal != null &&
              double.parse(project.fundraisingGoal!) > 0) ...[
            const SizedBox(height: GlassmorphismTheme.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusSm),
              child: LinearProgressIndicator(
                value: (project.currentFunds ?? 0) /
                    double.parse(project.fundraisingGoal!),
                backgroundColor: GlassmorphismTheme.glassWhite,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isActive
                      ? GlassmorphismTheme.gold
                      : GlassmorphismTheme.textTertiary,
                ),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: GlassmorphismTheme.xs),
            Text(
              '${((project.currentFunds ?? 0) / double.parse(project.fundraisingGoal!) * 100).toStringAsFixed(1)}% funded',
              style: GlassmorphismTheme.captionStyle.copyWith(
                color: GlassmorphismTheme.textTertiary,
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusChip(bool isActive, bool isPending) {
    Color backgroundColor;
    Color textColor;
    String text;
    IconData icon;

    if (isPending) {
      backgroundColor = GlassmorphismTheme.gold.withOpacity(0.2);
      textColor = GlassmorphismTheme.gold;
      text = 'Pending';
      icon = Icons.schedule;
    } else if (isActive) {
      backgroundColor = GlassmorphismTheme.gold.withOpacity(0.9);
      textColor = GlassmorphismTheme.darkPrimary;
      text = 'Active';
      icon = Icons.check_circle;
    } else {
      backgroundColor = GlassmorphismTheme.glassWhite;
      textColor = GlassmorphismTheme.textSecondary;
      text = 'Inactive';
      icon = Icons.pause_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GlassmorphismTheme.sm,
        vertical: GlassmorphismTheme.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusXl),
        border: Border.all(
          color: isActive ? GlassmorphismTheme.gold : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: textColor,
          ),
          const SizedBox(width: GlassmorphismTheme.xs),
          Text(
            text,
            style: GlassmorphismTheme.captionStyle.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: GlassCard(
        margin: const EdgeInsets.all(GlassmorphismTheme.xl),
        hasGoldBorder: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.work_outline,
              size: 64,
              color: GlassmorphismTheme.gold.withOpacity(0.5),
            ),
            const SizedBox(height: GlassmorphismTheme.md),
            Text(
              'No Projects Yet',
              style: GlassmorphismTheme.h2Style.copyWith(
                color: GlassmorphismTheme.gold,
              ),
            ),
            const SizedBox(height: GlassmorphismTheme.sm),
            Text(
              'Start making impact by creating your first project',
              style: GlassmorphismTheme.bodyStyle.copyWith(
                color: GlassmorphismTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: GlassmorphismTheme.lg),
            GlassButton(
              onPressed: () => context.go(
                '/createProject',
                extra: CreateProjectArguments(
                  nonprofit: widget.nonprofit,
                  profile: widget.profile,
                ),
              ),
              text: 'Create First Project',
              icon: Icons.add_circle_outline,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  void _handleProjectTap(NonProfitProject project) {
    // Navigate to project details or edit screen
    // This can be implemented based on your routing setup
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening project: ${project.title}'),
        backgroundColor: GlassmorphismTheme.gold,
      ),
    );
  }
}
