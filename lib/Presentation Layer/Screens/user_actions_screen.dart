import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_level_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

class UserActionRewardScreen extends StatefulWidget {
  final Profile profile;
  const UserActionRewardScreen({super.key, required this.profile});

  @override
  State<UserActionRewardScreen> createState() => _UserActionRewardScreenState();
}

class _UserActionRewardScreenState extends State<UserActionRewardScreen> {
  List<AltrueLevel> levels = [];

  Future<List<AltrueLevel>> fetchLevels() async {
    final url = Uri.parse(
        'https://d04c-2600-1700-a340-10e0-930-c134-41df-c8e2.ngrok-free.app/api/levels/');
    print('Fetching levels from: $url'); // Debug statement

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Debug statement
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => AltrueLevel.fromJson(data)).toList();
    } else {
      print(
          'Failed to load levels with status code: ${response.statusCode}'); // Debug statement
      throw Exception('Failed to load levels');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLevels().then((data) {
      setState(() {
        levels = data;
        _updateActionCompletion();
      });
    }).catchError((error) {
      print('Error fetching levels: $error');
    });
  }

  void _updateActionCompletion() {
    // Create a set of completed action IDs
    final completedActionIds = widget.profile.userActions!
        .map((userAction) => userAction.altrueAction.id)
        .whereType<int>()
        .toSet();

    // Iterate through levels and actions to update their completion status
    for (var level in levels) {
      for (var action in level.requiredActions ?? []) {
        if (completedActionIds.contains(action.id)) {
          action.isCompleted = true;
        } else {
          action.isCompleted =
              false; // Ensure actions not completed are set correctly
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Altrue Actions',
          style: GlassmorphismTheme.h1Style.copyWith(
            color: GlassmorphismTheme.gold,
          ),
        ),
        iconTheme: const IconThemeData(color: GlassmorphismTheme.textPrimary),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary,
                    GlassmorphismTheme.darkTertiary,
                  ]
                : [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with points summary
              GlassCard(
                margin: const EdgeInsets.all(GlassmorphismTheme.md),
                hasGoldBorder: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Points',
                          style: GlassmorphismTheme.captionStyle,
                        ),
                        const SizedBox(height: GlassmorphismTheme.xs),
                        Text(
                          '${widget.profile.altruePoints ?? 0}',
                          style: GlassmorphismTheme.heroStyle.copyWith(
                            color: GlassmorphismTheme.gold,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                    GlassIconButton(
                      icon: Icons.star,
                      variant: GlassButtonVariant.primary,
                      size: 48,
                      onPressed: () {
                        // Show points breakdown
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You have ${widget.profile.altruePoints ?? 0} total points!',
                              style: const TextStyle(
                                  color: GlassmorphismTheme.darkPrimary),
                            ),
                            backgroundColor: GlassmorphismTheme.gold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Levels list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GlassmorphismTheme.md),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    final completedActions = level.requiredActions
                            ?.where((action) => action.isCompleted == true)
                            .length ??
                        0;
                    final totalActions = level.requiredActions?.length ?? 0;
                    final progress = totalActions > 0
                        ? completedActions / totalActions
                        : 0.0;

                    return GlassCard(
                      margin:
                          const EdgeInsets.only(bottom: GlassmorphismTheme.md),
                      hasGoldBorder: progress >= 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Level header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Level ${level.levelNumber}',
                                style: GlassmorphismTheme.h2Style.copyWith(
                                  color: GlassmorphismTheme.gold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: GlassmorphismTheme.sm,
                                  vertical: GlassmorphismTheme.xs,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      GlassmorphismTheme.gold.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                      GlassmorphismTheme.radiusSm),
                                ),
                                child: Text(
                                  '$completedActions/$totalActions',
                                  style:
                                      GlassmorphismTheme.captionStyle.copyWith(
                                    color: GlassmorphismTheme.gold,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: GlassmorphismTheme.sm),

                          // Progress bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                GlassmorphismTheme.radiusSm),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: GlassmorphismTheme.glassWhite,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  GlassmorphismTheme.gold),
                              minHeight: 6,
                            ),
                          ),

                          const SizedBox(height: GlassmorphismTheme.md),

                          // Actions list
                          ...level.requiredActions!
                              .map((action) => _buildActionTile(action))
                              .toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(AltrueAction action) {
    final bool isCompleted = action.isCompleted ?? false;
    final actionPoints = action.pointsAwarded ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: GlassmorphismTheme.sm),
      child: GlassCard(
        opacity: 0.05,
        borderRadius: GlassmorphismTheme.radiusMd,
        padding: const EdgeInsets.symmetric(
          horizontal: GlassmorphismTheme.md,
          vertical: GlassmorphismTheme.sm,
        ),
        child: Row(
          children: [
            // Completion status
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? GlassmorphismTheme.gold.withOpacity(0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: isCompleted
                      ? GlassmorphismTheme.gold
                      : GlassmorphismTheme.textSecondary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: GlassmorphismTheme.gold,
                    )
                  : null,
            ),

            const SizedBox(width: GlassmorphismTheme.md),

            // Action details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    action.name ?? '',
                    style: GlassmorphismTheme.bodyStyle.copyWith(
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                      color: isCompleted
                          ? GlassmorphismTheme.textSecondary
                          : GlassmorphismTheme.textPrimary,
                    ),
                  ),
                  if (action.name != null) ...[
                    const SizedBox(height: GlassmorphismTheme.xs),
                    Text(
                      action.name!,
                      style: GlassmorphismTheme.captionStyle.copyWith(
                        color: GlassmorphismTheme.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Points and action button
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: GlassmorphismTheme.sm,
                    vertical: GlassmorphismTheme.xs,
                  ),
                  decoration: BoxDecoration(
                    color: GlassmorphismTheme.gold.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(GlassmorphismTheme.radiusSm),
                  ),
                  child: Text(
                    '+$actionPoints',
                    style: GlassmorphismTheme.captionStyle.copyWith(
                      color: GlassmorphismTheme.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!isCompleted) ...[
                  const SizedBox(width: GlassmorphismTheme.sm),
                  GlassIconButton(
                    icon: Icons.check_circle,
                    variant: GlassButtonVariant.primary,
                    size: 32,
                    onPressed: () {
                      setState(() {
                        action.isCompleted = true;
                        // Update profile points
                        widget.profile.altruePoints =
                            (widget.profile.altruePoints ?? 0) + actionPoints;
                        // Optionally update the backend here
                      });

                      // Show completion feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Completed: ${action.name} (+$actionPoints points)',
                            style: const TextStyle(
                                color: GlassmorphismTheme.darkPrimary),
                          ),
                          backgroundColor: GlassmorphismTheme.gold,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ] else ...[
                  const SizedBox(width: GlassmorphismTheme.sm),
                  const Icon(
                    Icons.check_circle,
                    color: GlassmorphismTheme.gold,
                    size: 32,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
