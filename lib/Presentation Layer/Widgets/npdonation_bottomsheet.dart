import 'package:flutter/material.dart';

import '../../Data Layer/Models/nonprofit_project_model.dart';

class DonationBottomSheet extends StatefulWidget {
  final NonProfitProject project;
  const DonationBottomSheet({super.key, required this.project});

  @override
  State<DonationBottomSheet> createState() => _DonationBottomSheetState();
}

class _DonationBottomSheetState extends State<DonationBottomSheet> {
  double donationAmount = 0.0; // Store the selected donation amount
  TextEditingController manualAmountController = TextEditingController();
  @override
  void dispose() {
    manualAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[900], // Set background color to grey[900]
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Name',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Organization Name',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cause',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle donation logic here
                },
                child: const Text('Donate'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'Recent Donors',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 60.0, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Number of recent donors
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const CircleAvatar(
                      radius: 24.0,
                      // Replace with donor profile image
                      backgroundImage:
                          AssetImage('images/altrueLevel1Icon.png'),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Donor $index',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Donation Amount',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: donationAmount,
                  min: 0.0,
                  max: 100.0, // Adjust the maximum donation amount
                  onChanged: (newValue) {
                    setState(() {
                      donationAmount = newValue;
                    });
                  },
                ),
              ),
              Text('\$$donationAmount',
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text('or', style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8.0),
          TextField(
            controller: manualAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Amount',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle donation submission here
              if (manualAmountController.text.isNotEmpty) {
                // Use the manually entered amount if available
                double enteredAmount =
                    double.parse(manualAmountController.text);
                if (enteredAmount > 0) {
                  // Handle the donation
                }
              } else {
                // Use the slider amount
                if (donationAmount > 0) {
                  // Handle the donation
                }
              }
            },
            child: const Text('Donate'),
          ),
        ],
      ),
    );
  }
}
