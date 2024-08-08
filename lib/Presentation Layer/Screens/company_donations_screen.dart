import 'package:flutter/material.dart';

import '../../Data Layer/Models/company_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Widgets/all_company_donations.dart';
import '../Widgets/company_dashboard/title_viiew.dart';

class CompanyDonationScreen extends StatefulWidget {
  final ForProfitCompany company;
  final Profile profile;
  const CompanyDonationScreen({super.key, required this.company, required this.profile});

  @override
  State<CompanyDonationScreen> createState() => __CompanyDonationScreen();
}

class __CompanyDonationScreen extends State<CompanyDonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.amber,
        
        onPressed: ()=>Navigator.of(context).pushNamed('/companyaddDonation', arguments: widget.company),
        child: const Icon(Icons.add,
        color: Colors.white,),
      ),
      appBar: AppBar(
        title: const Text('Our Donations'),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        
        backgroundColor: Colors.black,
        items: const [
          
         BottomNavigationBarItem(
          label: 'Home',
          icon:Icon(Icons.home)),
          BottomNavigationBarItem(
            label: 'My Cart',
            icon: Icon(Icons.shop)),BottomNavigationBarItem(
          label: 'Home',
          icon:Icon(Icons.home)),
          BottomNavigationBarItem(
          label: 'Home',
          icon:Icon(Icons.home)),
      ]),
      
      body: Column(children: [
        const SizedBox(height: 100,),
        const TitleView(
          titleTxt: 'Most Recent Donations',
        ),
        widget.company.donationsMade!.donations!.isNotEmpty
               
            ? CompanyDonationsList(company: widget.company)
            : SizedBox(
                height: 80,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Text(
                        'Your Organization has ${widget.company.totalDonationCount.toString()} donations',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/companymatch',
                              arguments: widget.company);
                        },
                        child: const Text(
                          'Get Started Now',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              )
      ]),
    ); 
  }
}