import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';

class MyCompanyHome extends StatefulWidget {
  final Profile profile;
  final ForProfitCompany company;

  const MyCompanyHome(
      {super.key, required this.profile, required this.company});

  @override
  State<MyCompanyHome> createState() => _MyCompanyHomeState();
}

class _MyCompanyHomeState extends State<MyCompanyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
          ],
        ),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: TitleView(
            color: Colors.amber,
            company: widget.company,
            titleTxt: widget.company.name,
          ),
        ),
        MediterranesnDietView(
          textColor: Colors.white,
          color: Colors.black,
          profile: widget.profile,
          isProfileInfo: false,
          isCompanyInfo: true,
          company: widget.company,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Colors.black,
                              elevation: 12),
                          onPressed: () {
                            context.go('/userProfile/companyDonations',
                                extra: CompanyHomeArguments(
                                    company: widget.company,
                                    profile: widget.profile));
                          },
                          child: const Text(
                            'Our Donations',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            context.go('/comapnyRewards',
                                extra: CompanyHomeArguments(
                                    company: widget.company,
                                    profile: widget.profile));
                          },
                          child: const Text(
                            'Our Rewards',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      context.go('/companymatch',
                          extra: CompanyMatchScreenArguments(
                              profile: widget.profile,
                              company: widget.company));
                    },
                    child: const Text(
                      'Partnerships',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
