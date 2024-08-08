import 'package:flutter/material.dart';

import '../../Data Layer/Models/shirt_group_model.dart';
import '../../Data Layer/Models/user_model.dart';
import 'Shirt_Group_Card.dart';

class ShirtGroupsList extends StatefulWidget {
  final List<ShirtGroup> groups;
  final Profile profile;
  const ShirtGroupsList(
      {super.key, required this.groups, required this.profile});

  @override
  State<ShirtGroupsList> createState() => _ShirtGroupsListState();
}

class _ShirtGroupsListState extends State<ShirtGroupsList> {
  final pageController = PageController(viewportFraction: .8);
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              controller: pageController,
              itemCount: widget.groups.length,
              itemBuilder: (context, index) {
                return ShirtGroupCard(
                  profile: widget.profile,
                  shirtgroup: widget.groups[index],
                );
              }),
        )
      ],
    );
  }
}
