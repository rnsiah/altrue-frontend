import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/Company_Matching_Details/company_atrocity_matching_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/Company_Matching_Details/company_nonprofit_matching_details.dart';

class CompanyMatchingDetailTabs extends StatefulWidget {
  final ForProfitCompany company;
  const CompanyMatchingDetailTabs({Key? key, required this.company})
      : super(key: key);

  @override
  State<CompanyMatchingDetailTabs> createState() =>
      _CompanyMatchingDetailTabsState();
}

class _CompanyMatchingDetailTabsState extends State<CompanyMatchingDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'Atrocity Matches',
      ),
      const Tab(
        text: 'NonProfit Matches',
      ),
    ];
    List<Widget> pages = [
      CompanyAtrocityMatches(
        company: widget.company,
      ),
      CompanyNonProfitMatches(company: widget.company)
    ];
    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            child: TabBar(
              labelStyle: const TextStyle(fontSize: 10),
              isScrollable: true,
              labelColor: Colors.amber,
              controller: tabController,
              tabs: tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.black,
            ),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(80),
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
