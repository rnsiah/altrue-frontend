import 'package:flutter/material.dart';

class ProfileInfoBigCard extends StatelessWidget {
  final String firstText, secondText;
  final Widget icon;

  const ProfileInfoBigCard(
      {Key? key,
      required this.firstText,
      required this.secondText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 16,
          bottom: 14,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: icon,
            ),
            Text(firstText,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.amber,
                    fontWeight: FontWeight.w600)),
            Text(secondText,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w200)),
          ],
        ),
      ),
    );
  }
}
