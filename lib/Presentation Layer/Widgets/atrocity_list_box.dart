import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';

import '../../Data Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import '../../Data Layer/Models/atrocity_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Routers/functionality_router.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

class AtrocityBox extends StatelessWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityBox({
    required this.profile,
    required this.atrocity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<AtrocityBlocBloc>()
            .add(AtrocityItemFteched(atrocity: atrocity));
        context.go('/allNpProjects/atrocityView',
            extra:
                AtrocityDetailArguments(atrocity: atrocity, profile: profile));
      },
      child: atrocity.id == 2 || atrocity.id == 4
          ? _buildSpecialContainer(context)
          : _buildStandardContainer(context),
    );
  }

  Widget _buildSpecialContainer(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      height: 130,
      width: 100,
      hasGoldBorder: true,
      borderRadius: GlassmorphismTheme.radiusLg,
      child: Stack(
        children: [
          // Background image with dark overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
              child: Image.network(
                atrocity.imageUrl!,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          // Content overlay
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Text(
                atrocity.title,
                style: GlassmorphismTheme.h3Style.copyWith(
                  color: GlassmorphismTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardContainer(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      height: 130,
      width: 100,
      borderRadius: GlassmorphismTheme.radiusLg,
      child: Stack(
        children: [
          // Background image with green overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(GlassmorphismTheme.radiusLg),
              child: Image.network(
                atrocity.imageUrl!,
                fit: BoxFit.cover,
                color: Colors.green.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          // Content overlay
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Action button
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  transform: Matrix4.translationValues(0, -GlassmorphismTheme.sm, 0),
                  child: IconButton(
                    iconSize: 32,
                    color: GlassmorphismTheme.gold,
                    icon: const Icon(Icons.arrow_circle_up_outlined),
                    onPressed: () {},
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.all(GlassmorphismTheme.md),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    atrocity.title,
                    style: GlassmorphismTheme.h3Style.copyWith(
                      color: GlassmorphismTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithSizeAdjustment(BuildContext context, String title) {
    final textPainter = TextPainter(
        text: TextSpan(
      text: title,
      style: GlassmorphismTheme.h3Style.copyWith(
        fontWeight: FontWeight.bold,
        color: GlassmorphismTheme.textPrimary,
      ),
    ));
    textPainter.layout(maxWidth: 100); // Assuming a maximum width of 100

    final numberOfLines = textPainter.computeLineMetrics().length;

    return Text(title,
        style: TextStyle(
          fontSize: numberOfLines > 2 // Adjust based on your logic
              ? GlassmorphismTheme.bodySize // Set a smaller font size for more than 2 lines
              : GlassmorphismTheme.h3Size,
          fontWeight: FontWeight.bold,
          color: GlassmorphismTheme.textPrimary,
        ));
  }
}
