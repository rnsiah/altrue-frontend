import 'package:flutter/material.dart';

class UserActionRewardScreen extends StatefulWidget {
  const UserActionRewardScreen({super.key});

  @override
  State<UserActionRewardScreen> createState() => _UserActionRewardScreenState();
}

class _UserActionRewardScreenState extends State<UserActionRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserAction Rewards'),
      ),
    );
  }
}