import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/leaderboard_bloc/bloc/leaderboard_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/leaderboard_entry_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/leaderboard_profile_card.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  LeaderboardScreenState createState() => LeaderboardScreenState();
}

class LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<LeaderboardBloc>().add(FetchLeaderboard());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchTerm = value;
    });
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
          'Altrue Leaderboard',
          style:
              isDark ? GlassmorphismTheme.h1Style : GlassmorphismTheme.h1Style,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: GlassCard(
            margin:
                const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
            padding: const EdgeInsets.all(GlassmorphismTheme.sm),
            borderRadius: GlassmorphismTheme.radiusLg,
            child: TabBar(
              labelColor: GlassmorphismTheme.gold,
              unselectedLabelColor: isDark
                  ? GlassmorphismTheme.textSecondary
                  : GlassmorphismTheme.textSecondary,
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusMd),
                gradient: GlassmorphismTheme.goldGradient,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Top 100'),
                Tab(text: 'All Users'),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDark
                  ? GlassmorphismTheme.darkPrimary
                  : GlassmorphismTheme.textPrimary,
              isDark
                  ? GlassmorphismTheme.darkSecondary
                  : GlassmorphismTheme.textSecondary,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
                height:
                    MediaQuery.of(context).padding.top + kToolbarHeight + 48),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
              child: GlassCard(
                borderRadius: GlassmorphismTheme.radiusLg,
                child: TextField(
                  onChanged: _onSearchChanged,
                  style: isDark
                      ? GlassmorphismTheme.bodyStyle
                      : GlassmorphismTheme.bodyStyle,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDark
                          ? GlassmorphismTheme.textSecondary
                          : GlassmorphismTheme.textSecondary,
                    ),
                    hintText: 'Search users...',
                    hintStyle: isDark
                        ? GlassmorphismTheme.captionStyle
                        : GlassmorphismTheme.captionStyle,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(GlassmorphismTheme.md),
                  ),
                ),
              ),
            ),
            const SizedBox(height: GlassmorphismTheme.md),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLeaderboardList(context, top100: true),
                  _buildLeaderboardList(context),
                ],
              ),
            ),

            // User's current rank card
            _buildUserRankCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardList(BuildContext context, {bool top100 = false}) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderBoardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LeaderboardLoaded) {
          List<LeaderBoardEntry> filteredList =
              state.leaderboard.where((profile) {
            return profile.username
                .toLowerCase()
                .contains(searchTerm.toLowerCase());
          }).toList();

          if (top100) {
            filteredList = filteredList.take(100).toList();
          }

          if (filteredList.isEmpty) {
            return Center(
              child: GlassCard(
                margin: const EdgeInsets.all(GlassmorphismTheme.md),
                child: Padding(
                  padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                  child: Text(
                    'No users found',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? GlassmorphismTheme.bodyStyle
                        : GlassmorphismTheme.bodyStyle,
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final entry = filteredList[index];
              final rank = index + 1;
              final hasGoldAccent = rank <= 3;

              return Padding(
                padding: const EdgeInsets.only(bottom: GlassmorphismTheme.sm),
                child: _buildLeaderboardCard(entry, rank, hasGoldAccent),
              );
            },
          );
        } else if (state is LeaderboarError) {
          return Center(
            child: GlassCard(
              margin: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Padding(
                padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                child: Text(
                  'Error: ${state.message}',
                  style: Theme.of(context).brightness == Brightness.dark
                      ? GlassmorphismTheme.bodyStyle
                      : GlassmorphismTheme.bodyStyle,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: GlassCard(
              margin: const EdgeInsets.all(GlassmorphismTheme.md),
              child: Padding(
                padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                child: Text('No leaderboard data available.',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? GlassmorphismTheme.bodyStyle
                        : GlassmorphismTheme.bodyStyle),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildLeaderboardCard(
      LeaderBoardEntry entry, int rank, bool hasGoldAccent) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      hasGoldBorder: hasGoldAccent,
      borderRadius: GlassmorphismTheme.radiusLg,
      child: Padding(
        padding: const EdgeInsets.all(GlassmorphismTheme.md),
        child: Row(
          children: [
            // Rank with gold accent for top 3
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient:
                    hasGoldAccent ? GlassmorphismTheme.goldGradient : null,
                color: hasGoldAccent
                    ? null
                    : (isDark
                        ? GlassmorphismTheme.darkTertiary
                        : GlassmorphismTheme.textTertiary),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  rank.toString(),
                  style: TextStyle(
                    color: hasGoldAccent
                        ? GlassmorphismTheme.darkPrimary
                        : (isDark
                            ? GlassmorphismTheme.textPrimary
                            : GlassmorphismTheme.textPrimary),
                    fontWeight: FontWeight.bold,
                    fontSize: GlassmorphismTheme.bodySize,
                  ),
                ),
              ),
            ),
            const SizedBox(width: GlassmorphismTheme.md),

            // Profile Image
            CircleAvatar(
              radius: 24,
              backgroundColor: isDark
                  ? GlassmorphismTheme.darkTertiary
                  : GlassmorphismTheme.textTertiary,
              backgroundImage: entry.profileImage != null
                  ? NetworkImage(entry.profileImage!)
                  : null,
              child: entry.profileImage == null
                  ? Icon(
                      Icons.person,
                      color: isDark
                          ? GlassmorphismTheme.textSecondary
                          : GlassmorphismTheme.textSecondary,
                    )
                  : null,
            ),
            const SizedBox(width: GlassmorphismTheme.md),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.username,
                    style: isDark
                        ? GlassmorphismTheme.h3Style
                        : GlassmorphismTheme.h3Style,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: GlassmorphismTheme.xs),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: GlassmorphismTheme.gold,
                      ),
                      const SizedBox(width: GlassmorphismTheme.xs),
                      Text(
                        '${entry.altruePoints} pts',
                        style: isDark
                            ? GlassmorphismTheme.captionStyle
                            : GlassmorphismTheme.captionStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 16,
                        color: GlassmorphismTheme.gold,
                      ),
                      const SizedBox(width: GlassmorphismTheme.xs),
                      Text(
                        'Level ${entry.levelNumber}',
                        style: isDark
                            ? GlassmorphismTheme.captionStyle
                            : GlassmorphismTheme.captionStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rank badge for top 3
            if (hasGoldAccent)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: GlassmorphismTheme.sm,
                  vertical: GlassmorphismTheme.xs,
                ),
                decoration: BoxDecoration(
                  gradient: GlassmorphismTheme.goldGradient,
                  borderRadius:
                      BorderRadius.circular(GlassmorphismTheme.radiusSm),
                ),
                child: Text(
                  _getRankText(rank),
                  style: TextStyle(
                    color: GlassmorphismTheme.darkPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: GlassmorphismTheme.captionSize,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getRankText(int rank) {
    switch (rank) {
      case 1:
        return '1st';
      case 2:
        return '2nd';
      case 3:
        return '3rd';
      default:
        return '${rank}th';
    }
  }

  Widget _buildUserRankCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      margin: const EdgeInsets.all(GlassmorphismTheme.md),
      borderRadius: GlassmorphismTheme.radiusLg,
      gradient: GlassmorphismTheme.goldGradient,
      child: Padding(
        padding: const EdgeInsets.all(GlassmorphismTheme.md),
        child: Row(
          children: [
            // User avatar placeholder
            CircleAvatar(
              radius: 20,
              backgroundColor: GlassmorphismTheme.darkPrimary,
              child: Icon(
                Icons.person,
                color: GlassmorphismTheme.gold,
              ),
            ),
            const SizedBox(width: GlassmorphismTheme.md),

            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Rank',
                    style: TextStyle(
                      color: GlassmorphismTheme.darkPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: GlassmorphismTheme.bodySize,
                    ),
                  ),
                  Text(
                    '#42 • 2,450 pts',
                    style: TextStyle(
                      color: GlassmorphismTheme.darkPrimary.withOpacity(0.8),
                      fontSize: GlassmorphismTheme.captionSize,
                    ),
                  ),
                ],
              ),
            ),

            // Improvement indicator
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: GlassmorphismTheme.sm,
                vertical: GlassmorphismTheme.xs,
              ),
              decoration: BoxDecoration(
                color: GlassmorphismTheme.darkPrimary.withOpacity(0.2),
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 14,
                    color: GlassmorphismTheme.darkPrimary,
                  ),
                  const SizedBox(width: GlassmorphismTheme.xs),
                  Text(
                    '+5',
                    style: TextStyle(
                      color: GlassmorphismTheme.darkPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: GlassmorphismTheme.captionSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
