import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';

class ShirtSizePicker extends StatefulWidget {
  final Shirt shirt;
  const ShirtSizePicker({Key? key, required this.shirt}) : super(key: key);

  @override
  _ShirtSizePickerState createState() => _ShirtSizePickerState();
}

class _ShirtSizePickerState extends State<ShirtSizePicker> {
  List<String> shirtSizes(Shirt shirt) {
    List<String> titles = [];
    for (var project in shirt.shirtSizes!) {
      titles.add(project.size);
    }
    return titles;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 150,
      // child: AwesomeDropDown(

      //   onDropDownItemClick: (item) {},
      //   dropDownList: shirtSizes(widget.shirt),
      //   numOfListItemToShow: widget.shirt.shirtSizes!.length,
      // ),
    );
  }
}
