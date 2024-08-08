// import 'package:awesome_dropdown/awesome_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
// import 'package:mobile/Data_Layer/Models/shirt_model.dart';

// class ProjectPicker extends StatefulWidget {
//   final NonProfit nonProfit;
//   ProjectPicker({Key? key, required this.nonProfit}) : super(key: key);

//   @override
//   _ProjectPickerState createState() => _ProjectPickerState();
// }

// class _ProjectPickerState extends State<ProjectPicker> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   bool _isBackPressedOrTouchedOutSide = false,
//       _isDropDownOpened = false,
//       _isPanDown = false;
//   late List<String> _list;
//   String _selectedItem = '';

//   List<String> projects(NonProfit nonProfit) {
//     List<String> titles = [];
//     for (var project in nonProfit.projects!) {
//       titles.add(project.title);
//     }
//     return titles;
//   }

//   @override
//   void initState() {
//     _list = projects(widget.nonProfit);
//     _selectedItem = 'Pick A Project';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _removeFocus,
//       onPanDown: (focus) {
//         _isPanDown = true;
//         _removeFocus();
//       },
//       child: AwesomeDropDown(
//         dropDownList: _list,
//       ),
//     );
//   }
// }
