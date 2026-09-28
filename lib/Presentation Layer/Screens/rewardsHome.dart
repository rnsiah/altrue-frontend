import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/altrue_statistics_bloc/bloc/altrue_statistics_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/leaderboard_bloc/bloc/leaderboard_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/promoted_actions_bloc/bloc/promoted_actions_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/AltrueStatsCard.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/altrueLevelProfileCard.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/leaderboard_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/loading_indicator.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/promoted_actions_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/weekly_featured_shirts.dart';
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';
import '../../widgets/glass/glass_button.dart';

class RewardsHomeScreen extends StatefulWidget {
  final Profile profile;
  const RewardsHomeScreen({super.key, required this.profile});

  @override
  State<RewardsHomeScreen> createState() => _RewardsHomeScreenState();
}

class _RewardsHomeScreenState extends State<RewardsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: GlassButton(
        text: 'Redeem Rewards',
        icon: Icons.card_giftcard,
        variant: GlassButtonVariant.primary,
        onPressed: (){
          context.go('/rewardhome/');
        },
        borderRadius: GlassmorphismTheme.radius2Xl,
        horizontalPadding: GlassmorphismTheme.lg,
        verticalPadding: GlassmorphismTheme.md,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              GlassmorphismTheme.darkPrimary,
              GlassmorphismTheme.darkSecondary,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: GlassmorphismTheme.xl * 2),
          child: Column(
            children: [
              // User Level Hero Card with Glassmorphism
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                child: GlassCard(
                  hasGoldBorder: true,
                  padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                  gradient: GlassmorphismTheme.glassGradient,
                  child: UserLevelHeroCard(
                    profile: widget.profile,
                    heightFactor: .22,
                  ),
                ),
              ),
              
              SizedBox(height: GlassmorphismTheme.lg),
              
              // Featured Shirts Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                child: GlassCard(
                  padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                  gradient: GlassmorphismTheme.glassGradient,
                  child: BlocBuilder<ShirtBloc, ShirtState>(
                    builder: (context, state) {
                      return FeaturedShirts(
                        profile: widget.profile,
                        title: 'Rewards Of the Week',
                        imageWidth: 200,
                        shirtlist: state.featuredShirts,
                        imageHeight: 170,
                      );
                    },
                  ),
                ),
              ),
              
              SizedBox(height: GlassmorphismTheme.lg),
              
              // Leaderboard Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                child: GlassCard(
                  padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                  gradient: GlassmorphismTheme.glassGradient,
                  child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
                    builder: (context, state) {
                      if(state is LeaderboardLoaded){
                        return LeaderboardWidget(leaders: state.leaderboard, onSeeBoardPressed: (){});
                      }
                      return LoadingIndicator();
                    },
                  ),
                ),
              ),
              
              SizedBox(height: GlassmorphismTheme.lg),
              
              // Promoted Actions Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                child: GlassCard(
                  padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                  gradient: GlassmorphismTheme.glassGradient,
                  child: BlocBuilder<PromotedActionsBloc, PromotedActionsState>(
                    builder: (context, state) {
                      if(state is PromotedActionsLoaded){
                        return PromotedActionsWidget(promotedActions: state.promotedActions);
                      }
                      return LoadingIndicator();
                    },
                  ),
                ),
              ),
              
              SizedBox(height: GlassmorphismTheme.lg),
              
              // Statistics Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
                child: GlassCard(
                  padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                  gradient: GlassmorphismTheme.glassGradient,
                  child: BlocBuilder<AltrueStatisticsBloc, AltrueStatisticsState>(
                    builder: (context, state) {
                      if(state is AltrueStatisticsLoaded){
                        return CumulativeStatsHeroCard(statistics: state.statistics);
                      }
                      return LoadingIndicator();
                      },
                  ),
                ),
              ),
              
              SizedBox(height: GlassmorphismTheme.xl * 2),
            ],
          ),
        ),
      ),
    );
  }
}
