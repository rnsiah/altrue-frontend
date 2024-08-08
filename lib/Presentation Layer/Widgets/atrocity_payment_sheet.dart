import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Data Layer/Models/atrocity_model.dart';

class AtrocityPaymentSheet extends StatefulWidget {
  final Atrocity atrocity;
  const AtrocityPaymentSheet({super.key, required this.atrocity});

  @override
  State<AtrocityPaymentSheet> createState() => _AtrocityPaymentSheetState();
}

class _AtrocityPaymentSheetState extends State<AtrocityPaymentSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Text(widget.atrocity.title),
          Text(widget.atrocity.info!)
        ]),
      ),
    );
  }
}
