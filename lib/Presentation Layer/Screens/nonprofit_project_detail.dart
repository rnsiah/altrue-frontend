import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';

import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/rating_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Widgets/np_project_donate_modal.dart';

class NonProjectDetail extends StatefulWidget {
  final NonProfitProject project;
  final Profile profile;
  const NonProjectDetail(
      {super.key, required this.project, required this.profile});

  @override
  State<NonProjectDetail> createState() => _NonProjectDetailState();
}

class _NonProjectDetailState extends State<NonProjectDetail> {
  String text =
      'Expandable widgets are often used within a scroll view. When the user expands a widget, be it an ExpandablePanel or an Expandable with a custom control, they expect the expanded widget to fit within the viewable area (if possible';

  @override
  Widget build(BuildContext context) {
    double amount = 0;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Image(image: AssetImage('images/Altrue Logo White.png')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: size.height * .065,
        width: size.width * .8,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.grey[900],
                isDismissible: true,
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => DraggableScrollableSheet(
                    initialChildSize: .7,
                    minChildSize: .6,
                    maxChildSize: .8,
                    expand: false,
                    builder: (_, controller) => NpProjectDonateModal(
                          profile: widget.profile,
                          project: widget.project,
                        )));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: Colors.white)))),
          child: const Text(
            'Donate Now',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
      ),
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                height: size.height * .55,
                child: Image.network(
                  widget.project.projectImage!,
                  fit: BoxFit.cover,
                ),
              ),
              DraggableScrollableSheet(
                  maxChildSize: 1,
                  initialChildSize: .6,
                  minChildSize: .6,
                  builder: (context, controller) => SingleChildScrollView(
                        controller: controller,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        widget.project.title,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.amber)),
                                      onPressed: () {},
                                      child: const Text(
                                        'Follow',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                    // IconButton(
                                    //   onPressed: (){},
                                    //   color: Colors.amber,
                                    //   iconSize: 30,
                                    //   icon: const Icon(Icons.favorite_border_outlined),)
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.project.nonprofit!.name,
                                      style:
                                          const TextStyle(color: Colors.amber),
                                    ),
                                    RatingBar.builder(
                                      itemSize: 20,
                                      itemCount: 5,
                                      initialRating: 3,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        Rating theRating = Rating(
                                            stars: rating.toInt(),
                                            user: widget.profile,
                                            project: widget.project.id);
                                        context.read<ProfileBloc>().add(
                                            RateSomething(rating: theRating));
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                //  ` Row(children: const [
                                //     Icon(Icons.star, color: Colors.white, size: 15,),
                                //      Icon(Icons.star, color: Colors.white, size: 15,),
                                //       Icon(Icons.star, color: Colors.white, size: 15,),
                                //        Icon(Icons.star, color: Colors.white, size: 15,),
                                //         Icon(Icons.star, color: Colors.white, size: 15,)
                                //   ],),`
                                const SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  child: Row(children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.amber)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Total Raised',
                                              style: TextStyle(
                                                  color: Colors.amber),
                                            ),
                                            Text(
                                              '\$${widget.project.currentFunds.toString()}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.amber)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Column(children: [
                                        const Text('Supporters',
                                            style:
                                                TextStyle(color: Colors.amber)),
                                        Text(
                                            widget.project.followers!.length
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 19))
                                      ]),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.amber)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Column(children: [
                                        const Text('Supporters',
                                            style:
                                                TextStyle(color: Colors.amber)),
                                        Text(
                                            widget.project.followers!.length
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 19))
                                      ]),
                                    ))
                                  ]),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, state) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'About Project:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            NonProfitRespository repo =
                                                NonProfitRespository();
                                            NonProfit nonProfit =
                                                await repo.fetchNonProfit(widget
                                                    .project.nonprofit!.id);
                                            context.go(
                                                '/allProjectsList/nonProfitView',
                                                extra:
                                                    NonProfitDetailArguments(
                                                        nonProfit: nonProfit,
                                                        profile:
                                                            state.profile!));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(widget
                                                        .project
                                                        .nonprofit!
                                                        .logo))),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  widget.project.information!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                      useInkWell: true,
                                      iconColor: Colors.amber),
                                  header: const Text(
                                    'Supplies Needed',
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  expanded: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        text,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  collapsed: Text(
                                    text,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  height: 300,
                                ),
                                const SizedBox(
                                  height: 200,
                                  child: Text('hety'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
            ],
          ),
        ),
      ]),
    );
  }
}
