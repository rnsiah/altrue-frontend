import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_coupon_card.dart';

class CompanyCouponInfo extends StatelessWidget {
  final ForProfitCompany company;
  const CompanyCouponInfo({Key? key, required this.company}) : super(key: key);

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
          child: ListView.builder(
              itemCount: company.coupons!.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return CompanyCouponCard(
                  coupon: company.coupons![index],
                );
              }),
        ));
  }
}
