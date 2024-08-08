import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/hompage/Featured_Atrocities/card_widget.dart';

import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class FeaturedAtrocities extends StatefulWidget {
  const FeaturedAtrocities({
    Key? key,
  }) : super(key: key);

  @override
  State<FeaturedAtrocities> createState() => _FeaturedAtrocitiesState();
}

class _FeaturedAtrocitiesState extends State<FeaturedAtrocities> {
  List<Atrocity>? theList;

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
        itemCount: theList!.length,
        itemBuilder: (context, index) => CardWidget(
            image: theList![index].imageUrl.toString(),
            name: theList![index].title,
            category: theList![index].category!.first.name!));
  }
}
