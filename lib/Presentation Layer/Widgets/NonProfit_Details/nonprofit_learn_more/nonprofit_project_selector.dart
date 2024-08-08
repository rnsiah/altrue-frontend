import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';

class ProjectSelector extends StatefulWidget {
  final NonProfit? nonProfit;
  const ProjectSelector({
    required this.nonProfit,
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectSelector> createState() => _ProjectSelectorState();
}

class _ProjectSelectorState extends State<ProjectSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
