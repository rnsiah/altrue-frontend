import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_atrocity_showcase.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_shirt_showcase.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_volunteer_showcase.dart';

class NonProfitDetailTabs extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NonProfitDetailTabs(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  _NonProfitDetailTabsState createState() => _NonProfitDetailTabsState();
}

class _NonProfitDetailTabsState extends State<NonProfitDetailTabs>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'Shirts',
      ),
      const Tab(
        text: 'Atrocities',
      ),
      const Tab(
        text: 'Volunteer Opportunities',
      )
    ];
    List<Widget> pages = [
      NonProfitShirtCase(
        nonProfit: widget.nonProfit,
        profile: widget.profile,
      ),
      NonprofitAtrocityShowcase(
        nonprofit: widget.nonProfit,
        profile: widget.profile,
      ),
      NonProfitVolunteerShowcase(nonProfit: widget.nonProfit)
    ];

    TabController controller = TabController(length: tabs.length, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: TabBar(
              controller: controller,
              tabs: tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.white,
            ),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: TabBarView(
              controller: controller,
              children: pages,
            ),
          )
        ],
      ),
    );
  }
}
