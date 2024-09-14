import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_statistics_model.dart';

class CumulativeStatsHeroCard extends StatelessWidget {
  final AltrueStatistics statistics;  // Accept the AltrueStatistics model

  const CumulativeStatsHeroCard({
    required this.statistics,  // Pass the model as a parameter
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'App-Wide Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.5,
                ),
                children: [
                  buildStatItem('Total Users', statistics.totalUsers.toString()),
                  buildStatItem('Amount Raised', '\$${statistics.totalAmountRaised}'),
                  buildStatItem('Total Donated', '\$${statistics.totalDonated}'),
                  buildStatItem('Points Accumulated', statistics.totalPointsAccumulated.toString()),
                  buildStatItem('Total Nonprofits', statistics.totalNonprofits.toString()),
                  buildStatItem('Total Companies', statistics.totalCompanies.toString()),
                  buildStatItem('Total Atrocities', statistics.totalAtrocities.toString()),
                  buildStatItem('Total Donors', statistics.totalDonors.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}