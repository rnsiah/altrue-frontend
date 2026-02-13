import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';

class CauseList extends StatefulWidget {
  final Profile profile;

  const CauseList({super.key, required this.profile});
  @override
  State<CauseList> createState() => _CauseListState();
}

class _CauseListState extends State<CauseList> {
  String getfewWords(String words) {
    List<String> splitWords = words.split(" ");
    List<String> newWords = splitWords.sublist(0, 8);
    if (newWords.length >= 8) {
      return newWords.join(' ');
    }
    return words;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Image(
      //     image: AssetImage('images/Altrue Logo White.png'),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.black,
      // ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18, bottom: 20),
              child: Text(
                'Altrue Causes',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            // DropdownButton(items: [
            //   DropdownMenuItem(
            //       child: Text(
            //     'T-Shirts',
            //     style: TextStyle(
            //         fontSize: 24,
            //         color: Colors.black,
            //         fontWeight: FontWeight.w600),
            //     textAlign: TextAlign.left,
            //   )),
            // ], onChanged: (value) {  },),
            Container(
              height: 700,
              padding: const EdgeInsets.only(left: 32),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoryList.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () => context.go(
                              '/allNpProjects/causeView',
                              extra: CategoryArguments(
                                  category: state.categoryList[index],
                                  profile: widget.profile),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                height: 400,
                                width: MediaQuery.of(context).size.width * .8,
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 100),
                                        Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 10,
                                            color: Colors.black,
                                            child: Padding(
                                              padding: const EdgeInsets.all(32),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'A',
                                                    style: TextStyle(
                                                        shadows: [
                                                          Shadow(
                                                              offset: Offset(
                                                                  1.4, 1.4),
                                                              blurRadius: 10.0,
                                                              color:
                                                                  Colors.white)
                                                        ],
                                                        color: Colors.white,
                                                        fontSize: 60,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  const SizedBox(height: 40),
                                                  Text(
                                                      state.categoryList[index]
                                                          .name!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.left),
                                                  const Text(
                                                    'Altrue Cause',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: SizedBox(
                                                      width: 165,
                                                      child: Text(
                                                        '${state.categoryList[index].nonprofitCount} organizations fighting to end this cause',
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    state.categoryList[index]
                                                                .name !=
                                                            'All Causes'
                                                        ? '${getfewWords(state.categoryList[index].information!)}...'
                                                        : '',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Row(
                                                    children: const [
                                                      Text('Learn More',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .amber)),
                                                      Icon(Icons.arrow_forward,
                                                          color: Colors.amber)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                    Positioned(
                                      top: -17,
                                      right: -30,
                                      width: 250,
                                      height: 250,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(state
                                                  .categoryList[index].image!)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 100,
                                      child: Card(
                                          elevation: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .8,
                                            child: Column(children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                child: Text(
                                                  'The Stats',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(children: [
                                                      const Text(
                                                        'NonProfits',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                          state
                                                              .categoryList[
                                                                  index]
                                                              .nonprofitCount
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .amber,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 24))
                                                    ]),
                                                    Column(children: [
                                                      const Text('Raised',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                      Text(
                                                        '\$${state.categoryList[index].donationTotal!}',
                                                        style: const TextStyle(
                                                            color: Colors.amber,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24),
                                                      ),
                                                    ]),
                                                    Column(
                                                      children: [
                                                        const Text('Projects',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        Text(
                                                            state
                                                                .categoryList[
                                                                    index]
                                                                .projectCount
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .amber,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 24)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
