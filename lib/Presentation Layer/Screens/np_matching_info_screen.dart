import 'package:flutter/material.dart';

import 'package:lovelovelove/Data%20Layer/Models/company_nonprofit_matching_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';

import '../../Data Layer/Models/non_profit_model.dart';

class NpMatchingInfo extends StatefulWidget {
  final NonProfit nonprofit;
  const NpMatchingInfo({super.key, required this.nonprofit});

  @override
  State<NpMatchingInfo> createState() => _NpMatchingInfoState();
}

class _NpMatchingInfoState extends State<NpMatchingInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
      ),
      body: Column(
        children: [
          const TitleView(
            titleTxt: 'Companies Supporting',
            color: Colors.amber,
          ),
          SizedBox(
            height: 125,
            child: widget.nonprofit.matchingPartnerships != null &&
                    widget.nonprofit.matchingPartnerships!.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.nonprofit.matchingPartnerships!.length,
                    itemBuilder: (context, index) => CompaniesSupportingCard(
                          company:
                              widget.nonprofit.matchingPartnerships![index],
                          press: () {},
                        ))
                : const Text(
                    'Start A Relationship Now',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
          const TitleView(
            titleTxt: 'Matching Partnerships',
            color: Colors.amber,
          ),
          widget.nonprofit.matchingPartnerships != null &&
                  widget.nonprofit.matchingPartnerships!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                            widget.nonprofit.matchingPartnerships!.length,
                        itemBuilder: (context, index) => MatchingInfo(
                            relationship:
                                widget.nonprofit.matchingPartnerships![index])),
                  ),
                )
              : const Text('No Companies Matching')
        ],
      ),
    );
  }
}

class MatchingInfo extends StatelessWidget {
  final CompanyNonProfitMatchRelationship relationship;
  const MatchingInfo({super.key, required this.relationship});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .15,
        child: Material(
          elevation: 20,
          color: Colors.transparent,
          child: GestureDetector(
            onLongPress: () => {},
            onTap: () => {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(relationship.company.logo))),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  '${relationship.company.name} matching ${relationship.matchLevel}% of donations',
                                  style: const TextStyle(
                                      color: Colors.amber, fontSize: 18),
                                  maxLines: 2,
                                ),
                              ),
                            ]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.start_outlined,
                          color: Colors.amber,
                          size: 25,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompaniesSupportingCard extends StatelessWidget {
  final CompanyNonProfitMatchRelationship company;
  final Function press;

  const CompaniesSupportingCard(
      {super.key, required this.company, required this.press});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        width: 60,
        child: GestureDetector(
          onTap: () {
            press();
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.network(
                  company.company.logo,
                  scale: .7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  company.company.name,
                  style:
                      const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
