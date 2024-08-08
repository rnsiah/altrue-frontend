import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

import '../../Data Layer/Models/user_model.dart';

class CompanyRewardsScreen extends StatefulWidget {
  final Profile profile;
  final ForProfitCompany company;

  const CompanyRewardsScreen({super.key, required this.company, required this.profile});

  @override
  State<CompanyRewardsScreen> createState() => _CompanyRewardsScreenState();
}

class _CompanyRewardsScreenState extends State<CompanyRewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.black,
      title: const Text('Company Rewards'),
    ),body: Column(
      children: [
        MaterialButton(
      child: const Text('Create New Reward'),
      onPressed: (){
        Navigator.of(context).pushNamed('/createCompanyReward', arguments: CompanyHomeArguments(company: widget.company, profile: widget.profile));
      },
    )
      ],
    ),);
    
    
  }
}