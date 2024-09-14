import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_action_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_level_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:http/http.dart' as http;


class UserActionRewardScreen extends StatefulWidget {
  final Profile profile;
  const UserActionRewardScreen({super.key, required this.profile});

  @override
  State<UserActionRewardScreen> createState() => _UserActionRewardScreenState();
}

class _UserActionRewardScreenState extends State<UserActionRewardScreen> {
  List<AltrueLevel> levels = [];

  Future<List<AltrueLevel>> fetchLevels() async {
    final url = Uri.parse('https://6ebc-2601-2c6-500-16f0-f98e-16e3-2b1-5ab6.ngrok-free.app/api/levels/');
    print('Fetching levels from: $url');  // Debug statement

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');  // Debug statement
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => AltrueLevel.fromJson(data)).toList();
    } else {
      print('Failed to load levels with status code: ${response.statusCode}');  // Debug statement
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
        action.isCompleted = false; // Ensure actions not completed are set correctly
      }
    }
  }
}

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Altrue Actions'),
      ),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Altrue Level ${level.levelNumber}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...level.requiredActions!.map((action) => _buildActionTile(action)).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionTile(AltrueAction action) {
      final bool isCompleted = action.isCompleted ?? false;

    return Row(
      children: [
        Expanded(
          child: Text(
            action.name ?? '',
            style: TextStyle(
              fontSize: 16,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        if (!isCompleted)
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              setState(() {
                action.isCompleted = true;
                // Optionally update the profile or backend here
              });
            },
          ),
      ],
    );
  }
}