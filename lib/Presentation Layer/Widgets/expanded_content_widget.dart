import 'package:flutter/material.dart';

import '../../Data Layer/Models/shirt_group_model.dart';

class ExpandedContentWidget extends StatelessWidget {
  final ShirtGroup shirtgroup;
  const ExpandedContentWidget({super.key, required this.shirtgroup});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                .5,
                .5,
              ),
              blurRadius: 1.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              shirtgroup.name!,
              style: const TextStyle(fontSize: 22, color: Colors.amber),
            ),
            const SizedBox(
              height: 8,
            ),
            buildMoreInfo(shirtgroup: shirtgroup),
            const SizedBox(
              height: 8,
            ),
            Text(
              shirtgroup.description!,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ));
  }

  Widget buildMoreInfo({required ShirtGroup shirtgroup}) => Row(
        children: [
          Text(
            'Item Count: ${shirtgroup.shirts!.length}',
            style: const TextStyle(color: Colors.black),
          ),
        ],
      );
}
