import 'package:flutter/material.dart';

import '../../Data Layer/Models/user_model.dart';

class AltrueActionsScreen extends StatefulWidget {
  final Profile profile;
  const AltrueActionsScreen({super.key, required this.profile});

  @override
  State<AltrueActionsScreen> createState() => _AltrueActionsScreenState();
}

class _AltrueActionsScreenState extends State<AltrueActionsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Altrue Actions'),
      ),

    );
  }
}