import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Shirt_Details/shirt_atrocity_showcase.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Shirt_Details/shirt_statistics.dart';

class ShirtDetailTabs extends StatefulWidget {
  final Profile profile;
  final Shirt shirt;
  const ShirtDetailTabs({Key? key, required this.shirt, required this.profile})
      : super(key: key);

  @override
  State<ShirtDetailTabs> createState() => _ShirtDetailTabsState();
}

class _ShirtDetailTabsState extends State<ShirtDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'Atrocities',
      ),
      const Tab(
        text: 'Shirts',
      ),
    ];
    List<Widget> pages = [
      ShirtAtrocityShowcase(
        shirt: widget.shirt,
        profile: widget.profile,
      ),
      ShirtStatistics(shirt: widget.shirt)
    ];
    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: TabBar(
              controller: tabController,
              tabs: tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.white,
            ),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(300),
            child: TabBarView(
              controller: tabController,
              children: pages,
            ),
          )
        ],
      ),
    );
  }
}
