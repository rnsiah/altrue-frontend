import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/hompage/Featured_Atrocities/card_widget.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
//

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
    if (theList == null || theList!.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 470, // Card height + margin
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.85,
          initialPage: 0,
        ),
        padEnds: false,
        itemCount: theList!.length,
        itemBuilder: (context, index) {
          final atrocity = theList![index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
            child: CardWidget(
              image: atrocity.imageUrl.toString(),
              name: atrocity.title,
              category: atrocity.category?.first.name ?? 'Featured',
            ),
          );
        },
      ),
    );
  }
}
