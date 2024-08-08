import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_coupons_info.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_finance_data.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_matching_info.dart';

class ComapnyDetailTabs extends StatefulWidget {
  final ForProfitCompany company;
  const ComapnyDetailTabs({Key? key, required this.company}) : super(key: key);

  @override
  State<ComapnyDetailTabs> createState() => _ComapnyDetailTabsState();
}

class _ComapnyDetailTabsState extends State<ComapnyDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'Altrue Info',
      ),
      const Tab(
        text: 'Company Matching',
      ),
      const Tab(
        text: 'Altrue Deals',
      )
    ];
    List<Widget> pages = [
      CompanyFInanceData(company: widget.company),
      CompanyMatchingInfo(company: widget.company),
      CompanyCouponInfo(company: widget.company),
    ];
    TabController tabController =
        TabController(length: tabs.length, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.amber,
              controller: tabController,
              tabs: tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.black,
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
