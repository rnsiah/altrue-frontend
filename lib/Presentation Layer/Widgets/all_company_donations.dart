import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_donation_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';

class CompanyDonationsList extends StatefulWidget {
  final ForProfitCompany company;
  const CompanyDonationsList({Key? key, required this.company})
      : super(key: key);

  @override
  State<CompanyDonationsList> createState() => _CompanyDonationsListState();
}

class _CompanyDonationsListState extends State<CompanyDonationsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Text(
                  'Direct Donations',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
          widget.company.donationsMade!.donations!.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          widget.company.donationsMade!.donations!.length,
                      padding:
                          const EdgeInsets.only(top: 0, bottom: 0, left: 14),
                      itemBuilder: (context, ind) => CompanyDonationCard(
                          isMatch: false,
                          donation:
                              widget.company.donationsMade!.donations![ind])),
                )
              : const SizedBox(
                  height: 30,
                  child: Center(
                      child: Text('Your company has made no donations'))),
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Text('Matched Donations',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: widget.company.donationsMade!.matched!.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 14),
                    itemCount: widget.company.donationsMade!.matched!.length,
                    itemBuilder: (context, ind) => CompanyDonationCard(
                          isMatch: true,
                          matchDonation:
                              widget.company.donationsMade!.matched![ind],
                        ))
                : const SizedBox(
                    height: 30,
                    child: Center(
                        child: Text(
                            "Your company hasn't matched any donations yet"))),
          ),
        ],
      ),
    );
  }
}

class CompanyDonationCard extends StatelessWidget {
  final CompanyDonation? donation;
  final bool isMatch;
  final CompanyMatchDonation? matchDonation;
  const CompanyDonationCard(
      {Key? key, required this.isMatch, this.donation, this.matchDonation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Stack(
        children: [
          isMatch == false
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 6, left: 8, right: 8, bottom: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3),
                            color: Colors.grey.withOpacity(.6)),
                      ],
                      // gradient: LinearGradient(
                      //     colors: [Colors.white, Colors.black],
                      //     begin: Alignment.topRight,
                      //     end: Alignment.bottomRight),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6, left: 8, right: 16, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //donation_box
                          Text(donation!.amount,
                              style: const TextStyle(color: Colors.amber)),

                          Text(
                              donation!.atrocity == null
                                  ? donation!.nonprofit!.name
                                  : donation!.atrocity!.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              )),
                          Text(
                              donation!.project != null
                                  ? donation!.project!.title
                                  : '',
                              style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ))
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 6, left: 8, right: 8, bottom: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3),
                            color: Colors.grey.withOpacity(.6)),
                      ],
                      color: Colors.black,
                      // gradient: LinearGradient(
                      //     colors: [Colors.white, Colors.black],
                      //     begin: Alignment.topRight,
                      //     end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6, left: 8, right: 16, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //donation_box
                          Text(matchDonation!.amount,
                              style: const TextStyle(color: Colors.amber)),
                          Text(matchDonation!.user.username,
                              style: const TextStyle(color: Colors.white)),
                          Text(
                              matchDonation!.atrocity == null
                                  ? matchDonation!.nonprofit!.name
                                  : matchDonation!.atrocity!.title,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.white)),
                          Text(
                              matchDonation!.project != null
                                  ? donation!.project!.title
                                  : '',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  )),
          Positioned(
              right: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: isMatch == true
                            ? NetworkImage(
                                matchDonation!.user.profilePicture!.url)
                            : NetworkImage(donation!.atrocity == null
                                ? donation!.nonprofit!.logo
                                : ''))),
              ))
        ],
      ),
    );
  }
}
