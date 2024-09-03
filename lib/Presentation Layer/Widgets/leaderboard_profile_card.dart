import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/leaderboard_entry_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

Widget leaderBoardCard(LeaderBoardEntry profile) {
  return InkWell(
    onTap: (){},
    child: Card(
      
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(profile.profileImage!),
             
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text('Altrue Points: ${profile.altruePoints}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.amber),
                    Text('Altrue Level: ${profile.levelNumber.toString()}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}