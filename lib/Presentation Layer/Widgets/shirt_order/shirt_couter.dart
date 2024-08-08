import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';

class ShirtCounter extends StatefulWidget {
  final Shirt shirt;

  const ShirtCounter({super.key, required this.shirt});

  @override
  _ShirtCounterState createState() => _ShirtCounterState();
}

class _ShirtCounterState extends State<ShirtCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 70,
        child: Center(
          child: CustomNumberPicker(
            customAddButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(color: Colors.black),
                ),
                height: 39,
                width: 30,
                child: const Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
            customMinusButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                height: 40,
                width: 30,
                child: const Center(
                  child: Icon(Icons.remove),
                ),
              ),
            ),
            initialValue: 1,
            maxValue: 5,
            minValue: 1,
            step: 1,
            valueTextStyle: const TextStyle(color: Colors.amber, fontSize: 22),
            onValue: (value) {
              setState(() {
                value = numOfItems;
              });
            },
          ),
        ));
  }
}
