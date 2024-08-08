import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/company_background.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/company_details_content.dart';

class CompanYDetailPage extends StatefulWidget {
  final ForProfitCompany company;

  const CompanYDetailPage({Key? key, required this.company}) : super(key: key);

  @override
  State<CompanYDetailPage> createState() => _CompanYDetailPageState();
}

class _CompanYDetailPageState extends State<CompanYDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CompanyDetailsBackground(company: widget.company),
          CompanyDetailsContent(
            company: widget.company,
          )
        ],
      ),
    );
  }
}
