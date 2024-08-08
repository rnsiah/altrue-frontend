import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/UserProfile_Transaction_Details/userprofile_details_donationsTab.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/UserProfile_Transaction_Details/userprofle_orders_tab.dart';

class UserProfileDetailTabs extends StatefulWidget {
  final Profile profile;

  const UserProfileDetailTabs({Key? key, required this.profile})
      : super(key: key);

  @override
  _UserProfileDetailTabsState createState() => _UserProfileDetailTabsState();
}

class _UserProfileDetailTabsState extends State<UserProfileDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'My Orders',
      ),
      const Tab(text: 'My Donations'),
    ];
    List<Widget> pages = [
      UserProfileOrdersTab(profile: widget.profile),
      UserProfileDonationsTab(profile: widget.profile),
    ];
    TabController controller = TabController(length: tabs.length, vsync: this);

    return Padding(
        padding: const EdgeInsets.all(12),
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
        ));
  }
}
