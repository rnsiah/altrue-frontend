import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/leaderboard_bloc/bloc/leaderboard_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/leaderboard_entry_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/leaderboard_profile_card.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  LeaderboardScreenState createState() => LeaderboardScreenState();
}

class LeaderboardScreenState extends State<LeaderboardScreen> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Altrue Leaderboard', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: TabBar(
            labelColor: Colors.amber,
            controller: _tabController,
            tabs:  const [
              Tab(text: 'Top 100', ),
              Tab(text: 'All Users'),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search users...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLeaderboardList(context, top100: true),
                _buildLeaderboardList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardList(BuildContext context, {bool top100 = false}) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderBoardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LeaderboardLoaded) {
          List<LeaderBoardEntry> filteredList = state.leaderboard.where((profile) {
            return profile.username.toLowerCase().contains(searchTerm.toLowerCase());
          }).toList();

          if (top100) {
            filteredList = filteredList.take(100).toList();
          }

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return leaderBoardCard(filteredList[index]);
            },
          );
        } else if (state is LeaderboarError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No leaderboard data available.'));
        }
      },
    );
  }
}