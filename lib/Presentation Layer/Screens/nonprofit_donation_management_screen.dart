import 'package:flutter/material.dart';

import '../../Data Layer/Models/non_profit_model.dart';

class NonProfitDonationManagementScreen extends StatefulWidget {
  final NonProfit nonprofit;
  const NonProfitDonationManagementScreen({super.key, required this.nonprofit});

  @override
  State<NonProfitDonationManagementScreen> createState() =>
      _NonProfitDonationManagementScreenState();
}

class _NonProfitDonationManagementScreenState
    extends State<NonProfitDonationManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.nonprofit.recentDonors!.length,
          itemBuilder: (context, index) => donationInfoCard()),
    );
  }

  Widget donationInfoCard() {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      height: MediaQuery.of(context).size.height * .2,
      child: Column(children: const [
        Text(
          'hey',
        )
      ]),
    );
  }
}
