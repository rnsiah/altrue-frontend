import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';

class PickColorWidgett extends StatefulWidget {
  final List<String> shirtColors;
  final Shirt shirt;
  final String selectedColor;
  final ShirtOrderBlocBloc shirtOrderBlocBloc;
  final ShirtOrderBlocEvent shirtOrderBlocEvent;
  const PickColorWidgett(
      {super.key,
      required this.shirtColors,
      required this.shirt,
      required this.shirtOrderBlocBloc,
      required this.selectedColor,
      required this.shirtOrderBlocEvent});

  @override
  State<PickColorWidgett> createState() => _PickColorWidgettState();
}

class _PickColorWidgettState extends State<PickColorWidgett> {
  @override
  Widget build(BuildContext context) {
    String theColor = widget.shirt.variations![0].color.color;
    return BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
      builder: (context, state) {
        return DropdownButton<String>(
            value: theColor,
            items: widget.shirtColors.map((e) {
              return DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(),
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {
                theColor = value!;
                widget.shirtOrderBlocBloc.add(widget.shirtOrderBlocEvent);
              });
            });
      },
    );
  }
}
