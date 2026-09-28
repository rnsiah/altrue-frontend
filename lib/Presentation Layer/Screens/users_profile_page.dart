import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Theme/glassmorphism_theme.dart';

class UsersProfilePage extends StatefulWidget {
  final Profile profile;
  const UsersProfilePage({super.key, required this.profile});

  @override
  State<UsersProfilePage> createState() => _UsersProfilePageState();
}

class _UsersProfilePageState extends State<UsersProfilePage> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(
          widget.profile.username!,
          style: GlassTheme.textWhiteBold.copyWith(fontSize: 24),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: GlassTheme.darkGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(GlassTheme.spacingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: GlassTheme.spacingXL + GlassTheme.spacingLG), // Space for app bar
              _buildHeader(widget.profile),
              SizedBox(height: GlassTheme.spacingLG),
              _buildImpactSummary(widget.profile),
              SizedBox(height: GlassTheme.spacingLG),
              _buildRecentActions(widget.profile),
              SizedBox(height: GlassTheme.spacingLG),
              _buildBadges(widget.profile),
              SizedBox(height: GlassTheme.spacingLG),
              _buildDonationHistory(widget.profile),
              SizedBox(height: GlassTheme.spacingLG),
              _buildRewards(widget.profile)
            ],
          ),
        ),
      ),
    );
  }
 

 Widget _buildHeader(Profile profile) {
    return GlassCard(
      padding: const EdgeInsets.all(GlassTheme.spacingLG),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: profile.profilePicture != null
                ? NetworkImage(profile.profilePicture!.url)
                : AssetImage('assets/images/default_profile.png') as ImageProvider,
            backgroundColor: GlassTheme.accentGold.withOpacity(0.2),
          ),
          const SizedBox(width: GlassTheme.spacingLG),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.username ?? "Anonymous",
                  style: GlassTheme.textWhiteBold.copyWith(fontSize: 24),
                ),
                const SizedBox(height: GlassTheme.spacingXS),
                Text(
                  profile.title ?? "No title provided",
                  style: GlassTheme.textWhite.copyWith(fontSize: 16),
                ),
                const SizedBox(height: GlassTheme.spacingMD),
                GlassButton(
                  width: 120,
                  height: 40,
                  onPressed: () {
                    // Add follow functionality here
                  },
                  child: Text(
                    "Follow",
                    style: GlassTheme.textWhiteBold.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildImpactSummary(Profile profile) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Impact Summary",
            style: GlassTheme.textGold.copyWith(fontSize: 20),
          ),
          const SizedBox(height: GlassTheme.spacingMD),
          _buildImpactRow("Total Donations", "\$${profile.donationTotal?.toStringAsFixed(2) ?? '0.00'}"),
          const SizedBox(height: GlassTheme.spacingSM),
          _buildImpactRow("Causes Supported", "${profile.projectsFollowing?.length ?? 0}"),
          const SizedBox(height: GlassTheme.spacingSM),
          _buildImpactRow("Badges Earned", "${profile.userActions?.length ?? 0}"),
        ],
      ),
    );
  }
  
  Widget _buildImpactRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GlassTheme.textWhite.copyWith(fontSize: 16)),
        Text(value, style: GlassTheme.textGold.copyWith(fontSize: 16)),
      ],
    );
  }
  Widget _buildRecentActions(Profile profile) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Actions",
            style: GlassTheme.textGold.copyWith(fontSize: 20),
          ),
          const SizedBox(height: GlassTheme.spacingMD),
          if (profile.userActions != null && profile.userActions!.isNotEmpty)
            ...profile.userActions!.take(4).map((action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: GlassTheme.spacingSM),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: GlassTheme.accentGold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: GlassTheme.spacingMD),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            action.altrueAction.name!,
                            style: GlassTheme.textWhiteBold.copyWith(fontSize: 16),
                          ),
                          if (action.altrueAction.info != null)
                            Text(
                              action.altrueAction.info!,
                              style: GlassTheme.textWhite.copyWith(fontSize: 14),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList()
          else
            Text(
              "No recent actions.",
              style: GlassTheme.textWhite.copyWith(fontSize: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildBadges(Profile profile) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Badges Earned",
            style: GlassTheme.textGold.copyWith(fontSize: 20),
          ),
          const SizedBox(height: GlassTheme.spacingMD),
          if (profile.userActions != null && profile.userActions!.isNotEmpty)
            Wrap(
              spacing: GlassTheme.spacingMD,
              runSpacing: GlassTheme.spacingMD,
              children: profile.userActions!
                  .map((action) => GlassCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GlassTheme.spacingMD,
                      vertical: GlassTheme.spacingSM,
                    ),
                    borderRadius: GlassTheme.radiusSM,
                    borderColor: GlassTheme.accentGold.withOpacity(0.5),
                    child: Text(
                      action.altrueAction.name!,
                      style: GlassTheme.textGold.copyWith(fontSize: 14),
                    ),
                  ))
                  .toList(),
            )
          else
            Text(
              "No badges earned yet.",
              style: GlassTheme.textWhite.copyWith(fontSize: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildDonationHistory(Profile profile) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Donation History",
            style: GlassTheme.textGold.copyWith(fontSize: 20),
          ),
          const SizedBox(height: GlassTheme.spacingMD),
          if (profile.userdonations != null && profile.userdonations!.isNotEmpty)
            ...profile.userdonations!.take(4).map((donation) {
              return Padding(
                padding: const EdgeInsets.only(bottom: GlassTheme.spacingMD),
                child: GlassCard(
                  padding: const EdgeInsets.all(GlassTheme.spacingMD),
                  borderRadius: GlassTheme.radiusSM,
                  borderColor: GlassTheme.accentGold.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donation',
                            style: GlassTheme.textWhiteBold.copyWith(fontSize: 16),
                          ),
                          Text(
                            "Amount: \$${donation.dollarAmount}",
                            style: GlassTheme.textWhite.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        donation.donationDate,
                        style: GlassTheme.textGold.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            }).toList()
          else
            Text(
              "No donation history.",
              style: GlassTheme.textWhite.copyWith(fontSize: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildRewards(Profile profile) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Earned Rewards",
            style: GlassTheme.textGold.copyWith(fontSize: 20),
          ),
          const SizedBox(height: GlassTheme.spacingMD),
          if (profile.shirtList != null && profile.shirtList!.isNotEmpty)
            Wrap(
              spacing: GlassTheme.spacingMD,
              runSpacing: GlassTheme.spacingMD,
              children: profile.shirtList!
                  .map((shirt) => GlassCard(
                    padding: const EdgeInsets.all(GlassTheme.spacingSM),
                    borderRadius: GlassTheme.radiusSM,
                    borderColor: GlassTheme.accentGold.withOpacity(0.3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(GlassTheme.radiusSM),
                      child: Image.network(
                        shirt.shirtImage!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))
                  .toList(),
            )
          else
            Text(
              "No rewards claimed yet.",
              style: GlassTheme.textWhite.copyWith(fontSize: 16),
            ),
        ],
      ),
    );
  }
}
