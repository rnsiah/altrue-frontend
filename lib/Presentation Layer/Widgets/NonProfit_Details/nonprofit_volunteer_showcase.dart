import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';

class NonProfitVolunteerShowcase extends StatelessWidget {
  final NonProfit nonProfit;

  const NonProfitVolunteerShowcase({super.key, required this.nonProfit});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${nonProfit.name}has these volunteer opportunities available',
        textAlign: TextAlign.center,
      ),
    );
  }
}
