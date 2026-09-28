import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

class ProjectsFollowingCard extends StatelessWidget {
  final NonProfitProjectRep project;
  const ProjectsFollowingCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      height: 80,
      width: MediaQuery.of(context).size.width * .8,
      borderRadius: GlassmorphismTheme.radius2Xl,
      hasGoldBorder: false,
      margin: const EdgeInsets.symmetric(vertical: GlassmorphismTheme.sm),
      child: Row(
        children: [
          // Content section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    project.title,
                    style: GlassmorphismTheme.h3Style.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Subtitle with gold accent
                  Text(
                    project.title,
                    style: GlassmorphismTheme.captionStyle.copyWith(
                      color: GlassmorphismTheme.gold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Progress info
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '${project.id} of ${project.id} raised so far',
                      style: GlassmorphismTheme.captionStyle.copyWith(
                        color: GlassmorphismTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Image section
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(GlassmorphismTheme.radius2Xl),
                bottomRight: Radius.circular(GlassmorphismTheme.radius2Xl),
              ),
              border: Border.all(
                color: GlassmorphismTheme.gold.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(GlassmorphismTheme.radius2Xl - 1),
                bottomRight: Radius.circular(GlassmorphismTheme.radius2Xl - 1),
              ),
              child: Image.network(
                'https://patch.com/img/cdn20/getty/790386/20211130/040455/styles/patch_image/public/gettyimages-1264350329___30160247653.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}