import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_nonprofit_matching_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';

class MyNonProfitHome extends StatefulWidget {
  final Profile profile;
  final NonProfit nonprofit;
  final NonProfitRespository nonProfitRepository = NonProfitRespository();

  MyNonProfitHome({Key? key, required this.profile, required this.nonprofit})
      : super(key: key);

  @override
  MyNonProfitHomeState createState() => MyNonProfitHomeState();
}

class MyNonProfitHomeState extends State<MyNonProfitHome> {
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
            nonProfit: widget.profile.np,
            titleTxt: widget.profile.np!.name,
          ),
        ),
        MediterranesnDietView(
          textColor: Colors.white,
          color: Colors.grey[900],
          isCompanyInfo: false,
          profile: widget.profile,
          isProfileInfo: false,
          nonprofit: widget.nonprofit,
        ),
        SizedBox(
          height: 70,
          child: Expanded(
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
                      Navigator.of(context).pushNamed('/npDonationManagement',
                          arguments: widget.nonprofit);
                    },
                    child: const Text(
                      'Donations',
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
                      Navigator.of(context).pushNamed('/nonprofitProjectList',
                          arguments: NonProfitProjectListArguments(
                              nonProfit: widget.nonprofit,
                              profile: widget.profile));
                    },
                    child: const Text(
                      'Projects',
                      style: TextStyle(fontSize: 18, color: Colors.amber),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/npMatchinginfo',
                          arguments: widget.nonprofit);
                    },
                    child: const Text(
                      'Partnerships',
                      style: TextStyle(fontSize: 18, color: Colors.amber),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 70,
          child: Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/nonprofitProjectList',
                        arguments: NonProfitProjectListArguments(
                            nonProfit: widget.nonprofit,
                            profile: widget.profile));
                  },
                  child: const Text(
                    'Partnerships',
                    style: TextStyle(fontSize: 18, color: Colors.amber),
                  )),
            ],
          ),
        )
        //   TitleView(
        //     titleTxt: 'Our Projects',
        //     subTxt: 'Add Project',
        //     ontap: () async {
        //       NonProfit np = await widget.nonProfitRepository
        //           .fetchNonProfit(widget.profile.np!.id);

        //       Navigator.of(context).pushNamed('/createProject',
        //           arguments: CreateProjectArguments(
        //               nonprofit: np, profile: widget.profile));
        //     },
        //   ),
        //   MealsListView(
        //     profile: widget.profile,
        //     isProject: true,
        //     nonprofit: widget.nonprofit,
        //   ),
        //   const TitleView(
        //     titleTxt: 'Companies Matching',
        //   ),
        //   widget.nonprofit.matchingPartnerships!.isNotEmpty
        //       ? Padding(
        //           padding: const EdgeInsets.only(left: 15),
        //           child: SizedBox(
        //             height: 160,
        //             width: double.infinity,
        //             child: ListView.builder(
        //                 scrollDirection: Axis.horizontal,
        //                 itemCount:
        //                     widget.nonprofit.matchingPartnerships!.length,
        //                 itemBuilder: (context, index) {
        //                   return CompanyMatchCard(
        //                       company: widget
        //                           .nonprofit.matchingPartnerships![index]);
        //                 }),
        //           ),
        //         )
        //       : const SizedBox(
        //           height: 80,
        //           child: Center(
        //             child:
        //                 Text('No Companies Supporting Your Orgnanization yet'),
        //           ),
        //         )
        // ],
      ]),
    );
  }
}

class CompanyMatchCard extends StatelessWidget {
  const CompanyMatchCard({
    Key? key,
    required this.company,
  }) : super(key: key);

  final CompanyNonProfitMatchRelationship company;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     boxShadow: const [
      //       BoxShadow(
      //           color: Colors.black54, offset: Offset(0, 4), blurRadius: 10)
      //     ]),
      child: GestureDetector(
        onTap: () => {},
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: 130,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 180,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      // color: Colors.black26,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 9,
                          image: NetworkImage(company.company.logo))),
                ),
              ),
              Positioned(
                right: 8,
                top: 12,
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Amount Raised',
                        style: TextStyle(
                            backgroundColor: Colors.black.withOpacity(.70),
                            color: Colors.amber,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            '\$ ${company.totalRaised!.toInt()} /  \$${company.fundingLimit!.toInt()}',
                            softWrap: true,
                            style: TextStyle(
                                backgroundColor: Colors.black.withOpacity(.70),
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 8,
                  bottom: 12,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company.company.name,
                          softWrap: true,
                          style: TextStyle(
                              backgroundColor: Colors.black.withOpacity(.70),
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                            width: 150,
                            child: Text(
                                'Matching ${company.matchLevel}% of users donations',
                                style: TextStyle(
                                  backgroundColor:
                                      Colors.black.withOpacity(.70),
                                  color: Colors.white,
                                )))
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
