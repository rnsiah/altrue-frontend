import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Atrocity_Details/atrocity_nonprofit_showcase.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Atrocity_Details/atrocity_shirt_showcase.dart';

class AtrocityDetailTabs extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityDetailTabs(
      {Key? key, required this.atrocity, required this.profile})
      : super(key: key);

  @override
  State<AtrocityDetailTabs> createState() => _AtrocityDetailTabState();
}

class _AtrocityDetailTabState extends State<AtrocityDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'Shirts',
      ),
      const Tab(
        text: 'Altrue Organizations',
      ),
    ];
    List<Widget> pages = [
      AtrocityShirtShowcase(
        atrocity: widget.atrocity,
        profile: widget.profile,
      ),
      AtrocityNonProfitShowcase(
        atrocity: widget.atrocity,
        profile: widget.profile,
      )
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
            size: const Size.fromHeight(200),
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
