import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}