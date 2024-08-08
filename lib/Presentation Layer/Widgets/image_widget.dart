import 'package:flutter/material.dart';

import '../../Data Layer/Models/shirt_group_model.dart';

class ImageWidget extends StatelessWidget {
  final ShirtGroup shirtgroup;
  const ImageWidget({super.key, required this.shirtgroup});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.5,
      width: size.width * 0.8,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 2),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
         
          children: [
            buildImage(),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTopText(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage() => SizedBox.expand(
        child: ClipRRect(
          
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Image.network(shirtgroup.groupImage!, fit: BoxFit.cover,),
        ),
      );

  Widget buildTopText() => Text(
        shirtgroup.name!,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 3,
              color: Colors.grey
            )
          ],
          fontSize: 28,
        ),
      );
}
