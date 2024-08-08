import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';

class CreateLink extends StatefulWidget {
  final NonProfit nonprofit;
  const CreateLink({super.key, required this.nonprofit});

  @override
  State<CreateLink> createState() => _CreateLinkState();
}

class _CreateLinkState extends State<CreateLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 7),
            onPressed: () => print('Search'),
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
