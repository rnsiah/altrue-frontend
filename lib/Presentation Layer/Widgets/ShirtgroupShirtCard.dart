import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../Data Layer/Models/shirt_model.dart';

class ShirtgroupShirtCard extends StatelessWidget {
  final Shirt shirt;
  const ShirtgroupShirtCard({super.key, required this.shirt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedBuilder: (context, action) => buildCard(context),
        openBuilder: (context, action) => Container(),
      ),
    );
  }

  Column buildCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          shirt.name!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Colors.white,
                ),
              ],
              image: DecorationImage(
                  fit: BoxFit.contain, image: NetworkImage(shirt.shirtImage!))),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('love')],
        )
      ],
    );
  }
}
