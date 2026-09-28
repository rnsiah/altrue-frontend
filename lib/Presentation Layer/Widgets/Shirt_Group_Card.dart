import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

import '../../Data Layer/Models/shirt_group_model.dart';
import '../../Data Layer/Models/user_model.dart';
import 'expanded_content_widget.dart';
import 'image_widget.dart';

class ShirtGroupCard extends StatefulWidget {
  final ShirtGroup shirtgroup;
  final Profile profile;
  const ShirtGroupCard(
      {super.key, required this.shirtgroup, required this.profile});

  @override
  State<ShirtGroupCard> createState() => _ShirtGroupCardState();
}

class _ShirtGroupCardState extends State<ShirtGroupCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.xs),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * .78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            duration: const Duration(milliseconds: 500),
            child: GlassCard(
              hasGoldBorder: true,
              borderRadius: GlassmorphismTheme.radius2Xl,
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: ExpandedContentWidget(
                shirtgroup: widget.shirtgroup,
              ),
            ),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: isExpanded ? 150 : 100,
              child: GestureDetector(
                onPanUpdate: onPanUpdate,
                onTap: openDetailListPage,
                child: Hero(
                  tag: widget.shirtgroup.groupImage!,
                  child: GlassCard(
                    hasGoldBorder: true,
                    borderRadius: GlassmorphismTheme.radiusLg,
                    padding: EdgeInsets.zero,
                    child: ImageWidget(
                      shirtgroup: widget.shirtgroup,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void openDetailListPage() {
    if (!isExpanded) {
      setState(() => isExpanded = true);
      return;
    }
    context.go(
      '/shirtGroupList',
      extra: ShirtGroupArguments(
          profile: widget.profile, shirtGroup: widget.shirtgroup),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}