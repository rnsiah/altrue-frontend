import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_coupon_model.dart';

class CompanyCouponCard extends StatelessWidget {
  final CompanyCoupon coupon;
  const CompanyCouponCard({Key? key, required this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: 
        coupon.couponImage != null?
        Image(
          image: NetworkImage(coupon.couponImage!, ),
        ):const Text('hey'),
        title: Text(
          coupon.name,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          coupon.description!,
          style: const TextStyle(fontSize: 8),
        ),
        trailing: Text(coupon.couponCode!, style: const TextStyle(fontSize: 8)),
      ),
    );
  }
}
