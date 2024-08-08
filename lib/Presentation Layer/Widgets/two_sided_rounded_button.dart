import 'package:flutter/material.dart';

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double radious;
  final Function press;
   const TwoSideRoundedButton({super.key, 
    this.text = 'press me',
    required this.press,
    this.radious = 29,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=>press,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radious),
            bottomRight: Radius.circular(radious),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
