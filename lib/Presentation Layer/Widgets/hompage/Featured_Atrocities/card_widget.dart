import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CardWidget extends StatelessWidget {
  final String image;
  final String name;
  final String category;
  const CardWidget({
    required this.image,
    required this.name,
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('The Last Day Of summer');
        },
        child: ZStack([
          Image.network(image).box.shadow2xl.height(450).make(),
          Column(
            children: [
              name.text.black.size(30).make(),
              const SizedBox(
                height: 12,
              ),
              category.text.size(14).make()
            ],
          ),
        ], alignment: Alignment.centerLeft)
            .p20());
  }
}
