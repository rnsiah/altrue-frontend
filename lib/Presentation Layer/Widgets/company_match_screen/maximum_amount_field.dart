import 'package:flutter/material.dart';

class MaximumAmountField extends StatelessWidget {
  final Function(String) onAmountSelected;
  const  MaximumAmountField({
    super.key, required this.onAmountSelected
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
            labelText: 'Choose Maximum Amount',
            labelStyle: TextStyle(color: Colors.amber),
            focusColor: Colors.amber,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber))),
        onSubmitted: (value) => {
         onAmountSelected(value)
        },
      ),
    );
  }
}
