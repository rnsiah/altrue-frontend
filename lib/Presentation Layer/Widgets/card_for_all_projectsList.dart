import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/np_project_rating.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/two_sided_rounded_button.dart';

import '../../Data Layer/Models/user_model.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

class AllNpProjectsCard extends StatefulWidget {
  final Profile profile;
  final NonProfitProject project;
  final double contHeight = 245;
  final double contWidth = 202;
  const AllNpProjectsCard(
      {super.key, required this.project, required this.profile});

  @override
  State<AllNpProjectsCard> createState() => _AllNpProjectsCardState();
}

class _AllNpProjectsCardState extends State<AllNpProjectsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: GlassmorphismTheme.sm, bottom: GlassmorphismTheme.md, right: GlassmorphismTheme.sm),
      child: GestureDetector(
        onTap: () {
          context.go('/allNpProjects/npProjectDetails',
              extra: NonProfitProjectDetailArguments(
                  project: widget.project, profile: widget.profile));
        },
        child: GlassCard(
          height: 200,
          width: MediaQuery.of(context).size.width * .4,
          borderRadius: GlassmorphismTheme.radius2Xl,
          hasGoldBorder: true,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(GlassmorphismTheme.radius2Xl),
                  child: Image.network(
                    widget.project.projectImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay for better text readability
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GlassmorphismTheme.radius2Xl),
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
              // Action buttons
              Positioned(
                top: GlassmorphismTheme.sm,
                right: GlassmorphismTheme.sm,
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: GlassmorphismTheme.gold,
                      ),
                      onPressed: () {},
                    ),
                    const NpProjectRating(),
                  ],
                ),
              ),
              // Nonprofit logo
              Positioned(
                top: GlassmorphismTheme.md,
                left: GlassmorphismTheme.sm,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusSm),
                    border: Border.all(
                      color: GlassmorphismTheme.gold.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusSm - 1),
                    child: Image.network(
                      widget.project.nonprofit!.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Project info
              Positioned(
                left: GlassmorphismTheme.sm,
                right: GlassmorphismTheme.sm,
                bottom: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GlassmorphismTheme.h3Style.copyWith(
                        color: GlassmorphismTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: GlassmorphismTheme.xs),
                    Text(
                      widget.project.nonprofit!.name,
                      style: GlassmorphismTheme.captionStyle.copyWith(
                        color: GlassmorphismTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Learn More button
              Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      color: GlassmorphismTheme.gold,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(GlassmorphismTheme.radius2Xl),
                        topRight: Radius.circular(GlassmorphismTheme.radius2Xl),
                      ),
                    ),
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: GlassmorphismTheme.sm, horizontal: GlassmorphismTheme.sm),
                    alignment: Alignment.center,
                    child: Text(
                      'Learn More',
                      style: GlassmorphismTheme.buttonStyle.copyWith(
                        fontSize: GlassmorphismTheme.captionSize,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
