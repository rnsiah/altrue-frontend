import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class UsersProfilePage extends StatefulWidget {
  final Profile profile;
  const UsersProfilePage({super.key, required this.profile});

  @override
  State<UsersProfilePage> createState() => _UsersProfilePageState();
}

class _UsersProfilePageState extends State<UsersProfilePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar.new(title:Text(widget.profile.username!) ,
      centerTitle: true,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(widget.profile),
          SizedBox(height: 20,),
          _buildImpactSummary(widget.profile),
          SizedBox(height: 20,),
          _buildRecentActions(widget.profile),
          SizedBox(height: 20,),
          _buildBadges(widget.profile),
          SizedBox(height: 20,),
          _buildDonationHistory(widget.profile),
          SizedBox(height: 20,),
          _buildRewards(widget.profile)

        ],),
      ),
    );
  }
 

 Widget _buildHeader(Profile profile) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: profile.profilePicture != null
              ? NetworkImage(profile.profilePicture!.url) // Replace with the correct path
              : AssetImage('assets/images/default_profile.png') as ImageProvider,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.username ?? "Anonymous",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(profile.title ?? "No title provided"),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Add follow functionality here
                },
                child: const Text("Follow"),
              ),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildImpactSummary(Profile profile) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Impact Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Total Donations: \$${profile.donationTotal?.toStringAsFixed(2) ?? '0.00'}"),
            Text("Causes Supported: ${profile.projectsFollowing?.length ?? 0}"),
            Text("Badges Earned: ${profile.userActions?.length ?? 0}"),
          ],
        ),
      ),
    );
  }
  Widget _buildRecentActions(Profile profile) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (profile.userActions != null && profile.userActions!.isNotEmpty)
              ...profile.userActions!.map((action) {
                return ListTile(
                  title: Text(action.altrueAction.name!),
                  subtitle: Text(action.altrueAction.info ?? ""),
                );
              }).toList().getRange(0, 4)
            else
              const Text("No recent actions."),
          ],
        ),
      ),
    );
  }

  Widget _buildBadges(Profile profile) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Badges Earned",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (profile.userActions != null && profile.userActions!.isNotEmpty)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: profile.userActions!
                    .map((action) => Chip(label: Text(action.altrueAction.name!)))
                    .toList(),
              )
            else
              const Text("No badges earned yet."),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationHistory(Profile profile) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Donation History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (profile.userdonations != null && profile.userdonations!.isNotEmpty)
              ...profile.userdonations!.map((donation) {
                return ListTile(
                  title: Text('love'),
                  subtitle: Text("Amount: \$${donation.dollarAmount}"),
                  trailing: Text(donation.donationDate),
                );
              }).toList().reversed.toList().reversed.toList().getRange(0, 4)
            else
              const Text("No donation history."),
          ],
        ),
      ),
    );
  }

  Widget _buildRewards(Profile profile) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Earned Rewards",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (profile.shirtList != null && profile.shirtList!.isNotEmpty)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: profile.shirtList!
                    .map((shirt) =>ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(shirt.shirtImage!,
                      height: 100,
                      width: 100,),
                    ))
                    .toList(),
              )
            else
              const Text("No rewards claimed yet."),
          ],
        ),
      ),
    );
  }
}
