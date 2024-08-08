import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'dart:math' as math;

import 'package:lovelovelove/Presentation%20Layer/Widgets/ShirtgroupShirtCard.dart';

class ShirtGroupListShirtSelector extends StatefulWidget {
  final List<Shirt> shirtList;
  const ShirtGroupListShirtSelector({super.key, required this.shirtList});

  @override
  State<ShirtGroupListShirtSelector> createState() =>
      _ShirtGroupListShirtSelectorState();
}

class _ShirtGroupListShirtSelectorState
    extends State<ShirtGroupListShirtSelector> {
  late PageController _pageController;
  int initalPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(viewportFraction: .85, initialPage: initalPage);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AspectRatio(
        aspectRatio: 0.9,
        child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                initalPage = value;
                print('page changed');
              });
            },
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.shirtList.length,
            itemBuilder: (context, index) => buildShirtSlider(index)),
      ),
    );
  }

  Widget buildShirtSlider(int index) => AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = index - _pageController.page!;

          value = (value * .038).clamp(-1, 1);
        }
        return AnimatedOpacity(
          opacity: initalPage == index ? 1 : 0.4,
          duration: const Duration(milliseconds: 350),
          child: Transform.rotate(
            angle: math.pi * value,
            child: ShirtgroupShirtCard(shirt: widget.shirtList[index]),
          ),
        );
      });
}
