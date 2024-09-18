import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';



class ShirtSelector extends StatelessWidget {
  final int index;
  final List<Atrocity> atrocities;
  final Profile profile;
  final PageController pageController;

  const ShirtSelector({
    Key? key,
    required this.index,
    required this.atrocities,
    required this.profile,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
          value = (1 - (value.abs() * 0.3) + 0.6).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 400,
            width: Curves.easeInOut.transform(value) * 550,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          context.go(
            '/allNpProjects/atrocityView/',
            extra: AtrocityDetailArguments(profile: profile, atrocity: atrocities[index]),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: atrocities[index].imageUrl!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        atrocities[index].imageUrl!,
                        height: 220,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              bottom: 40,
              child: Container(
                color: Colors.black.withOpacity(.25),
                width: 240,
                child: Text(
                  atrocities[index].title.toUpperCase(),
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}