import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatefulWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center
          ,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.message),
            TextButton(onPressed:()=> context.go('/home',), 
            child: const Text('Go Home'))
          ],
        ),
      ),
    );
  }
}