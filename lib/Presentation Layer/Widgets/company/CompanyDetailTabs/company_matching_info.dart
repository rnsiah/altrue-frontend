import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/Company_Matching_Details/company_matching_tabs.dart';

class CompanyMatchingInfo extends StatefulWidget {
  final ForProfitCompany company;
  const CompanyMatchingInfo({Key? key, required this.company})
      : super(key: key);

  @override
  State<CompanyMatchingInfo> createState() => _CompanyMatchingInfoState();
}

class _CompanyMatchingInfoState extends State<CompanyMatchingInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 9),
        child: Container(
          width: MediaQuery.of(context).size.width * .93,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: CompanyMatchingDetailTabs(
            company: widget.company,
          ),
        ));
  }
}
