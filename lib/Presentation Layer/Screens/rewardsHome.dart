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

class RewardsHomeScreen extends StatefulWidget {
  final Profile profile;
  const RewardsHomeScreen({super.key, required this.profile});

  @override
  State<RewardsHomeScreen> createState() => _RewardsHomeScreenState();
}

class _RewardsHomeScreenState extends State<RewardsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
        ),
        backgroundColor: Colors.grey[900],
        tooltip: 'Redeem Altrue Points',
        onPressed: (){
          context.go('/rewardhome/');
        }, label:const Text('Redeem Rewards', style: TextStyle(fontSize: 14, color: Colors.amber),) ,
        icon:const Icon(Icons.card_giftcard, size: 28,color: Colors.amber,)),
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Reward Home'),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserLevelHeroCard(
              profile: widget.profile,
              heightFactor: .22,
            ),
            // SizedBox(height: MediaQuery.of(context).size.height,),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<ShirtBloc, ShirtState>(
              builder: (context, state) {
                return FeaturedShirts(
                    profile: widget.profile,
                    title: 'Rewards Of the Week',
                    imageWidth: 200,
                    shirtlist: state.featuredShirts,
                    imageHeight: 170);
              },
            ),
            BlocBuilder<LeaderboardBloc, LeaderboardState>(
              builder: (context, state) {
                if(state is LeaderboardLoaded){
                  return LeaderboardWidget(leaders: state.leaderboard, onSeeBoardPressed: (){});
                }
                return LoadingIndicator();
              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<PromotedActionsBloc, PromotedActionsState>(
              builder: (context, state) {
                if(state is PromotedActionsLoaded){
                    return PromotedActionsWidget(promotedActions: state.promotedActions);
                }
                return LoadingIndicator();
              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<AltrueStatisticsBloc, AltrueStatisticsState>(
              builder: (context, state) {
                if(state is AltrueStatisticsLoaded){
                  return CumulativeStatsHeroCard(statistics: state.statistics);
                }
                return LoadingIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
