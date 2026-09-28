import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';
import '../../theme/glassmorphism_theme.dart';

class PromotedActionsWidget extends StatelessWidget {
  final List<AltrueAction> promotedActions; // List of promoted actions

  const PromotedActionsWidget({
    required this.promotedActions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title: Promoted Actions of the Week
        Padding(
          padding: const EdgeInsets.only(left: GlassmorphismTheme.sm),
          child: Text(
            'Promoted Actions of the Week',
            style: GlassmorphismTheme.h3Style.copyWith(
              color: GlassmorphismTheme.gold,
            ),
          ),
        ),
        const SizedBox(height: GlassmorphismTheme.sm), // Add some spacing
        // Promoted actions list
        SizedBox(
          height: 100, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            itemCount: promotedActions.length,
            itemBuilder: (context, index) {
              final action = promotedActions[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
                child: _buildPromotedActionCard(action),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPromotedActionCard(AltrueAction action) {
    return FittedBox(
      child: Container(
        width: 250, // Card width
        decoration: BoxDecoration(
          color: Colors.amber[400],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Action name
              Text(
                action.name ?? 'No name',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Action info
              Text(
                action.info ?? 'No info available',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12.0),
              // Points awarded
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.star, color: Colors.white),
                  const SizedBox(width: 4.0),
                  Text(
                    '${action.pointsAwarded ?? 0} points',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
