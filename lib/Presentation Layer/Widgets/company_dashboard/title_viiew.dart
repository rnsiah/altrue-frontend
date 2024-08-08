import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final NonProfitRep? nonProfit;
  final String subTxt;
  final ForProfitCompany? company;
  final Color? color;

  final GestureTapCallback? ontap;

  const TitleView({
    Key? key,
    this.nonProfit,
    this.color,
    this.company,
    this.titleTxt = "",
    this.ontap,
    this.subTxt = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Row(
          children: <Widget>[
            nonProfit != null
                ? Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(nonProfit!.logo))),
                  )
                : company != null
                    ? Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(company!.logo!))),
                      )
                    : Container(
                        height: 0,
                      ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              child: Text(
                titleTxt,
                textAlign: TextAlign.left,
                style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    letterSpacing: 0.5,
                    color: color),
              ),
            ),
            InkWell(
              onTap: ontap,
              highlightColor: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      subTxt,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      height: 38,
                      width: 26,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RouteWithArgs {
  final String route;
  final Object? arguments;

  RouteWithArgs({required this.route, this.arguments});
}
