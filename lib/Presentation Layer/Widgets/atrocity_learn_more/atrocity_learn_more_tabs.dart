import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/atrocity_learn_more/atroc.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/atrocity_learn_more/atrocity_statistics.dart';

class AtrocityLearnMoreTabs extends StatefulWidget {
  final Atrocity atrocity;

  const AtrocityLearnMoreTabs({Key? key, required this.atrocity})
      : super(key: key);

  @override
  State<AtrocityLearnMoreTabs> createState() => _AtrocityLearnMoreTabsState();
}

class _AtrocityLearnMoreTabsState extends State<AtrocityLearnMoreTabs>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      Tab(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 3, color: Colors.amber)),
          child: const Center(
              child: Text(
            'Relevant Links',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      const Tab(
        child:  Center(
          child: Text(
            'Altrue Statistics',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      
    ];

    List<Widget> pages = [
      AtroLearn(atrocity: widget.atrocity),
      AtrocityStatistics(atrocity: widget.atrocity)
    ];

    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: tabs,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.white,
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
