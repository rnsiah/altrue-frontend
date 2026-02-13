import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_donation_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

class ProfileRecentDonations extends StatelessWidget {
  final Profile profile;
  const ProfileRecentDonations({super.key, required this.profile});

  

  @override
  Widget build(BuildContext context) {
    final nonprofits = profile.userdonations!.where((donation) => donation.nonprofit != null).toList().reversed.toList();
    final atrocities = profile.userdonations!.where((donation) => donation.atrocity != null).toList().reversed.toList();
    final projects = profile.userdonations!.where((donation) => donation.project != null).toList().reversed.toList();
    return SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, bottom: 12),
                          child: Text(
                            'Recent Donations',
                            style: TextStyle(color: Colors.amber, fontSize: 20),
                          ),
                        ),
                          _buildDonationCategory('Nonprofits', nonprofits),
                          _buildDonationCategory('Atrocities', atrocities),
                          _buildDonationCategory('Projects', projects),
                        
                      ]))
                  );

                  
  }
  Widget _buildDonationCategory(String categoryName, List<UserDonation> donations) {
    double totalDonations = donations.fold(0, (sum, donation)=> sum+ double.parse(donation.dollarAmount));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: TextStyle(color: Colors.amber, fontSize: 18),
              ),
              Text("Total: \$${totalDonations.toStringAsFixed(2)}", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w500),)
            ],
          ),
        ),
        SizedBox(
          height: 120, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donation = donations[index];
              if (donation.nonprofit != null) {
                return _buildNonprofitItem(context, donation.nonprofit!, donation);
              } else if (donation.atrocity != null) {
                return _buildAtrocityItem(context, donation.atrocity!,donation);
              } else if (donation.project != null) {
                return _buildProjectItem(context, donation.project!,donation);
              }
              return Container(); // Fallback for any unknown types
            },
          ),
        ),
      ],
    );
  }
  String getMonthName(int month) {
  const months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  return months[month - 1]; // Months are 1-based in DateTime
}
  Widget _buildNonprofitItem(BuildContext context, UserDonationNonProfit nonprofit, UserDonation donation) {
   
    DateTime parsedDate =DateTime.parse(donation.donationDate);
    String month = getMonthName(parsedDate.month);
    String formattedDate = "$month ${parsedDate.day}, ${parsedDate.year}";

    

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap:()=>_showDonationDetails(context,donation, formattedDate),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              image: NetworkImage(nonprofit.logo!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAtrocityItem(BuildContext context, UserDonationAtrocity atrocity, UserDonation donation) {
    DateTime parsedDate =DateTime.parse(donation.donationDate);
    String month = getMonthName(parsedDate.month);
    String formattedDate = "$month ${parsedDate.day}, ${parsedDate.year}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>_showDonationDetails(context, donation, formattedDate),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.amberAccent,
          ),
          child: Center(
            child: Text(
              atrocity.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectItem(BuildContext context ,NonProfitProject project, UserDonation donation) {
    DateTime parsedDate =DateTime.parse(donation.donationDate);
    String month = getMonthName(parsedDate.month);
    String formattedDate = "$month ${parsedDate.day}, ${parsedDate.year}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>_showDonationDetails(context,donation,formattedDate),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(project.projectImage!),
            fit: BoxFit.fill) ,
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              project.title,
              style: TextStyle(backgroundColor: Colors.black. withOpacity(.4), color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
  void _showDonationDetails(BuildContext context, UserDonation donation, String date) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Transparent background for rounded edges and design
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black, // Set background color to black
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Donation Details',
                  style: TextStyle(
                    color: Colors.amber, // Set text color to amber
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing between title and details
              Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.amber),
                  const SizedBox(width: 10),
                  Text(
                    'Amount: \$${donation.dollarAmount.toString()}',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.amber),
                  const SizedBox(width: 10),
                  Text(
                    'Date: $date',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Spacing before the button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber, // Amber background button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded button
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.black, // Black text for contrast
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}