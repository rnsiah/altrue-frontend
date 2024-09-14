import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/leaderboard_entry_model.dart';

class LeaderboardWidget extends StatelessWidget {
  final List<LeaderBoardEntry> leaders; // List of leaderboard entries
  final VoidCallback onSeeBoardPressed; // Callback for the 'See Board' button

  const LeaderboardWidget({
    required this.leaders,
    required this.onSeeBoardPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title: Altrue Leaders
              Text(
                'Altrue Leaders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              // Button: See Board
              TextButton(
                onPressed: onSeeBoardPressed,
                child: Text(
                  'See Board',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10), // Add some spacing
        // Leaderboard list
        Container(
          height: 100, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            itemCount: 8,
            itemBuilder: (context, index) {
              final leader = leaders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildLeaderCard(leader),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderCard(LeaderBoardEntry leader) {
    return FittedBox(
      child: Container(
        width: 120, // Card width
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circle avatar for profile image
            CircleAvatar(
              radius: 30,
              backgroundImage: leader.profileImage != null
                  ? NetworkImage(leader.profileImage!)
                  : AssetImage('assets/default_avatar.png') as ImageProvider, // Fallback to default avatar if no image
            ),
            const SizedBox(height: 10),
            // Leader's name
            Text(
              leader.username,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Leader's points
            Text(
              '${leader.altruePoints} points',
              style: TextStyle(
                fontSize: 14,
                color: Colors.amber,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
