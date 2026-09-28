import 'package:flutter/material.dart';
import '../../Data Layer/Models/user_model.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

class AltrueActionsScreen extends StatefulWidget {
  final Profile profile;
  const AltrueActionsScreen({super.key, required this.profile});

  @override
  State<AltrueActionsScreen> createState() => _AltrueActionsScreenState();
}

class _AltrueActionsScreenState extends State<AltrueActionsScreen> {
  // Sample actions data - you can replace this with your actual data source
  final List<Map<String, dynamic>> sampleActions = [
    {
      'id': 1,
      'name': 'Daily Meditation',
      'description': 'Complete 10 minutes of mindfulness meditation',
      'points': 50,
      'category': 'Wellness',
      'icon': Icons.self_improvement,
      'isCompleted': false,
    },
    {
      'id': 2,
      'name': 'Gratitude Journal',
      'description': 'Write down 3 things you are grateful for',
      'points': 30,
      'category': 'Mindfulness',
      'icon': Icons.menu_book,
      'isCompleted': false,
    },
    {
      'id': 3,
      'name': 'Random Act of Kindness',
      'description': 'Perform one random act of kindness today',
      'points': 75,
      'category': 'Kindness',
      'icon': Icons.favorite,
      'isCompleted': true,
    },
    {
      'id': 4,
      'name': 'Nature Walk',
      'description': 'Take a 20-minute walk in nature',
      'points': 40,
      'category': 'Nature',
      'icon': Icons.nature,
      'isCompleted': false,
    },
    {
      'id': 5,
      'name': 'Digital Detox',
      'description': 'Spend 1 hour without electronic devices',
      'points': 60,
      'category': 'Digital Wellness',
      'icon': Icons.phone_disabled,
      'isCompleted': false,
    },
    {
      'id': 6,
      'name': 'Healthy Meal',
      'description': 'Prepare and eat a nutritious meal',
      'points': 45,
      'category': 'Health',
      'icon': Icons.restaurant,
      'isCompleted': true,
    },
  ];

  String _selectedCategory = 'All';

  // Get unique categories
  List<String> get categories {
    final categories = sampleActions
        .map((action) => action['category'] as String)
        .toSet()
        .toList();
    categories.insert(0, 'All');
    return categories;
  }

  // Get filtered actions
  List<Map<String, dynamic>> get filteredActions {
    if (_selectedCategory == 'All') {
      return sampleActions;
    }
    return sampleActions
        .where((action) => action['category'] == _selectedCategory)
        .toList();
  }

  // Get completion stats
  Map<String, int> get completionStats {
    final completed =
        sampleActions.where((action) => action['isCompleted'] == true).length;
    final total = sampleActions.length;
    return {
      'completed': completed,
      'total': total,
      'remaining': total - completed,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stats = completionStats;

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
        actions: [
          // Stats button
          GlassIconButton(
            icon: Icons.analytics,
            variant: GlassButtonVariant.secondary,
            size: 40,
            onPressed: () {
              _showStatsDialog();
            },
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
              // Header with welcome message and points
              GlassCard(
                margin: const EdgeInsets.all(GlassmorphismTheme.md),
                hasGoldBorder: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back!',
                              style: GlassmorphismTheme.h3Style.copyWith(
                                color: GlassmorphismTheme.gold,
                              ),
                            ),
                            const SizedBox(height: GlassmorphismTheme.xs),
                            Text(
                              widget.profile.username ?? 'Altrue User',
                              style: GlassmorphismTheme.heroStyle.copyWith(
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(GlassmorphismTheme.md),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: GlassmorphismTheme.gold.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 32,
                            color: GlassmorphismTheme.gold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: GlassmorphismTheme.md),

                    // Quick stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                            'Completed',
                            stats['completed']!.toString(),
                            GlassmorphismTheme.gold),
                        _buildStatItem(
                            'Remaining',
                            stats['remaining']!.toString(),
                            GlassmorphismTheme.textSecondary),
                        _buildStatItem(
                            'Points',
                            '${widget.profile.altruePoints ?? 0}',
                            GlassmorphismTheme.gold),
                      ],
                    ),
                  ],
                ),
              ),

              // Category filter
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(
                    horizontal: GlassmorphismTheme.md),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == _selectedCategory;

                    return Padding(
                      padding:
                          const EdgeInsets.only(right: GlassmorphismTheme.sm),
                      child: GlassButton(
                        text: category,
                        variant: isSelected
                            ? GlassButtonVariant.primary
                            : GlassButtonVariant.secondary,
                        onPressed: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        horizontalPadding: GlassmorphismTheme.md,
                        verticalPadding: GlassmorphismTheme.sm,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: GlassmorphismTheme.md),

              // Actions grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GlassmorphismTheme.md),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: GlassmorphismTheme.md,
                    mainAxisSpacing: GlassmorphismTheme.md,
                  ),
                  itemCount: filteredActions.length,
                  itemBuilder: (context, index) {
                    final action = filteredActions[index];
                    final isCompleted = action['isCompleted'] as bool;

                    return _buildActionCard(action, isCompleted);
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating action button for quick add
      floatingActionButton: GlassButton(
        icon: Icons.add,
        variant: GlassButtonVariant.primary,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Add new action feature coming soon!',
                style: const TextStyle(color: GlassmorphismTheme.darkPrimary),
              ),
              backgroundColor: GlassmorphismTheme.gold,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GlassmorphismTheme.h2Style.copyWith(
            color: color,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: GlassmorphismTheme.xs),
        Text(
          label,
          style: GlassmorphismTheme.captionStyle,
        ),
      ],
    );
  }

  Widget _buildActionCard(Map<String, dynamic> action, bool isCompleted) {
    return GlassCard(
      hasGoldBorder: isCompleted,
      onTap: isCompleted ? null : () => _handleActionTap(action),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Action icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? GlassmorphismTheme.gold.withOpacity(0.2)
                  : GlassmorphismTheme.glassWhite,
            ),
            child: Icon(
              action['icon'] as IconData,
              size: 32,
              color: isCompleted
                  ? GlassmorphismTheme.gold
                  : GlassmorphismTheme.textSecondary,
            ),
          ),

          const SizedBox(height: GlassmorphismTheme.md),

          // Action name
          Text(
            action['name'] as String,
            style: GlassmorphismTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: isCompleted
                  ? GlassmorphismTheme.textSecondary
                  : GlassmorphismTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: GlassmorphismTheme.xs),

          // Action description
          Text(
            action['description'] as String,
            style: GlassmorphismTheme.captionStyle.copyWith(
              color: GlassmorphismTheme.textTertiary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: GlassmorphismTheme.sm),

          // Points and status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  '+${action['points']}',
                  style: GlassmorphismTheme.captionStyle.copyWith(
                    color: GlassmorphismTheme.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isCompleted) ...[
                const SizedBox(width: GlassmorphismTheme.sm),
                const Icon(
                  Icons.check_circle,
                  color: GlassmorphismTheme.gold,
                  size: 20,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _handleActionTap(Map<String, dynamic> action) {
    final actionName = action['name'] as String;
    final actionPoints = action['points'] as int;

    setState(() {
      action['isCompleted'] = true;
      // Update profile points
      widget.profile.altruePoints =
          (widget.profile.altruePoints ?? 0) + actionPoints;
    });

    // Show completion feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Completed: $actionName (+$actionPoints points)',
          style: const TextStyle(color: GlassmorphismTheme.darkPrimary),
        ),
        backgroundColor: GlassmorphismTheme.gold,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showStatsDialog() {
    final stats = completionStats;
    final completionRate =
        (stats['completed']! / stats['total']! * 100).round();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          hasGoldBorder: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Progress',
                    style: GlassmorphismTheme.h2Style.copyWith(
                      color: GlassmorphismTheme.gold,
                    ),
                  ),
                  GlassIconButton(
                    icon: Icons.close,
                    variant: GlassButtonVariant.secondary,
                    size: 32,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: GlassmorphismTheme.lg),

              // Completion rate
              Text(
                '$completionRate%',
                style: GlassmorphismTheme.heroStyle.copyWith(
                  color: GlassmorphismTheme.gold,
                  fontSize: 48,
                ),
              ),
              Text(
                'Completion Rate',
                style: GlassmorphismTheme.captionStyle,
              ),

              const SizedBox(height: GlassmorphismTheme.lg),

              // Detailed stats
              _buildDetailRow(
                  'Completed Actions', stats['completed']!.toString()),
              const SizedBox(height: GlassmorphismTheme.sm),
              _buildDetailRow(
                  'Remaining Actions', stats['remaining']!.toString()),
              const SizedBox(height: GlassmorphismTheme.sm),
              _buildDetailRow(
                  'Total Points', '${widget.profile.altruePoints ?? 0}'),

              const SizedBox(height: GlassmorphismTheme.lg),

              GlassButton(
                text: 'Great Job!',
                variant: GlassButtonVariant.primary,
                onPressed: () => Navigator.pop(context),
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GlassmorphismTheme.bodyStyle,
        ),
        Text(
          value,
          style: GlassmorphismTheme.bodyStyle.copyWith(
            color: GlassmorphismTheme.gold,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
