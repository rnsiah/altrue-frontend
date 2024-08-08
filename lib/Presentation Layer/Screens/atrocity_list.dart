import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/category_selector.dart';

class AtrocityList extends StatelessWidget {
  final Profile profile;

  const AtrocityList({super.key, required this.profile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
            backgroundColor: Colors.black),
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: context.read<AtrocityBlocBloc>(),
              ),
              BlocProvider.value(value: context.read<CategoryBloc>())
            ],
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Global Causes',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return CategorySelector(
                      isNonProfit: false,
                      isAtrocity: true,
                      isCompany: false,
                      isShirt: false,
                      isProject: false,
                      categoryList: state.categoryList,
                    );
                  },
                ),
                BlocConsumer<AtrocityBlocBloc, AtrocityBlocState>(
                  listener: (context, state) {},
                  buildWhen: (p, c) => p.atrocities != p.atrocityCategoryList,
                  builder: (context, state) {
                    if (state.atrocityCategoryList.isNotEmpty) {
                      return buildCategoryAtrocityList(state);
                    } else if (state.atrocityCategoryList.isEmpty &&
                        state.atrocities.isNotEmpty) {
                      return buildAtrocityList(state);
                    }
                    return buildAtrocityList(state);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Expanded buildAtrocityList(AtrocityBlocState state) {
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: state.atrocities.length,
      itemBuilder: (context, int index) {
        return AtrocityBox(
          profile: profile,
          atrocity: state.atrocities[index],
        );
      },
    ));
  }

  Expanded buildCategoryAtrocityList(AtrocityBlocState state) {
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: state.atrocityCategoryList.length,
      itemBuilder: (context, int index) {
        return AtrocityBox(
          profile: profile,
          atrocity: state.atrocityCategoryList[index],
        );
      },
    ));
  }
}

class AtrocityBox extends StatelessWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityBox({
    required this.profile,
    required this.atrocity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<AtrocityBlocBloc>()
            .add(AtrocityItemFteched(atrocity: atrocity));
        Navigator.of(context).pushNamed('/atrocityView',
            arguments:
                AtrocityDetailArguments(atrocity: atrocity, profile: profile));
      },
      child: atrocity.id == 2 || atrocity.id == 4
          ? Container(
              margin: const EdgeInsets.all(10),
              height: 130,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ],
                image: DecorationImage(
                    colorFilter:
                        const ColorFilter.mode(Colors.yellow, BlendMode.darken),
                    image: NetworkImage(atrocity.imageUrl!),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  atrocity.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      backgroundColor: Colors.black.withOpacity(.4)),
                ),
              ))
          : Container(
              margin: const EdgeInsets.all(10),
              height: 130,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ],
                image: DecorationImage(
                    colorFilter:
                        const ColorFilter.mode(Colors.green, BlendMode.darken),
                    image: NetworkImage(atrocity.imageUrl!),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      transform: Matrix4.translationValues(0, -10, 0),
                      child: IconButton(
                        iconSize: 40,
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_circle_up_outlined),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          atrocity.title,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              backgroundColor: Colors.black.withOpacity(.4)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

// class ShirtSelector extends StatefulWidget {
//   final int index;

//   const ShirtSelector({Key? key, required this.index}) : super(key: key);
//   @override
//   _ShirtSelectorState createState() => _ShirtSelectorState();
// }

// class _ShirtSelectorState extends State<ShirtSelector> {
//   PageController pageController = PageController();
//   late AtrocityBlocBloc atrocityBloc;

//   late Atrocity atrocity;

//   @override
//   void initState() {
//     pageController = PageController(initialPage: 1, viewportFraction: 0.8);
//     atrocityBloc = context.read<AtrocityBlocBloc>();
//     super.initState();
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     var index;
//     return AnimatedBuilder(
//       animation: pageController,
//       builder: (context, Widget? widget) {
//         double value = 1;
//         if (pageController.position.haveDimensions) {
//           value = pageController.page! - index;
//           value = (1 - (value.abs() * 0.3) + 0.6).clamp(0.0, 1.0);
//         }
//         return Center(
//             child: SizedBox(
//           height: Curves.easeInOut.transform(value) * 270.0,
//           width: Curves.easeInOut.transform(value) * 400,
//           child: widget,
//         ));
//       },
//       child: BlocBuilder<AtrocityBlocBloc, AtrocityBlocState>(
//         builder: (context, state) {
//           return AtrocityCard(
//             atrocity: atrocity,
//           );
//         },
//       ),
//     );
//   }
// }

// class AtrocityCard extends StatelessWidget {
//   final Atrocity atrocity;

//   const AtrocityCard({Key? key, required this.atrocity}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Stack(
//         children: [
//           Center(
//             child: Container(
//               child: Center(
//                 child: Hero(
//                   tag: atrocity.imageUrl!,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image(
//                       image: NetworkImage(atrocity.imageUrl!),
//                       height: 220.0,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//               left: 30,
//               bottom: 40,
//               child: Text(
//                 atrocity.title.toUpperCase(),
//                 style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w400),
//               ))
//         ],
//       ),
//     );
//   }
// }
