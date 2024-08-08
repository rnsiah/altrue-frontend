import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_group_model.dart';

import '../../Data Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import '../../Data Layer/Blocs/shirt_group_bloc/bloc/shirtgroup_bloc.dart';
import '../../Data Layer/Models/shirt_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Routers/functionality_router.dart';
import '../Widgets/shirt_order/shirt_order_widget.dart';

class ShirtGroupListPage extends StatefulWidget {
  final ShirtGroup shirtGroup;
  final Profile profile;
  const ShirtGroupListPage(
      {super.key, required this.shirtGroup, required this.profile});

  @override
  State<ShirtGroupListPage> createState() => _ShirtGroupListPageState();
}

class _ShirtGroupListPageState extends State<ShirtGroupListPage> {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.amber,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20))));
  final ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))));
  @override
  Widget build(BuildContext context) {
    Shirt shirt =  widget.shirtGroup.shirts![0];
      ShirtOrderBlocBloc shirtOrderBloc = context.read<ShirtOrderBlocBloc>();
      CartBloc cartBloc = context.read<CartBloc>();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<ShirtgroupBloc, ShirtgroupState>(
                    builder: (context, state) {
                      if (state == ShirtChanging) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                onPressed: (() {
                                  Navigator.pop(context);
                                }),
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.amber,
                                )),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          state.shirt == null
                              ? Align(
                                child: Text(
                                    widget.shirtGroup.shirts![0].name!,textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white, ),
                                  ),
                              )
                              : Text(
                                  state.shirt!.name!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                          state.shirt == null
                              ? Text(
                                  widget.shirtGroup.shirts![0].price
                                      .toString(),
                                  style: const TextStyle(color: Colors.white))
                              : Text(state.shirt!.price.toString(),
                                  style: const TextStyle(color: Colors.white)),
                                  const SizedBox(
                            height: 22,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('images/limitedIcon.png'))),),
                              const SizedBox(
                            height: 22,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('images/altrueLevel1Icon.png'))),),
                          const IconCard(),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width * .75,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.29),
                            offset: const Offset(0, 10),
                            blurRadius: 60)
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(63),
                          bottomLeft: Radius.circular(63)),
                      image: DecorationImage(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.cover,
                          opacity: .3,
                          image:
                              NetworkImage(widget.shirtGroup.groupImage!))),
                  child: BlocBuilder<ShirtgroupBloc, ShirtgroupState>(
                    buildWhen: (previous, current) {
                      if (previous.shirt != current.shirt) {
                        print({previous.shirt: true});
                        return true;
                      }
                      print({previous.shirt: false});
                      return false;
                    },
                    builder: (context, state) {
                      return PageView.builder(
                        onPageChanged: (index) async {
                         shirt = widget.shirtGroup.shirts![index];
                          context.read<ShirtgroupBloc>().add(
                              PageChangeShirtInfo(
                                  shirt: widget.shirtGroup.shirts![index]));

                          print(widget.shirtGroup.shirts![index].name);
                          print(state.shirt);
                        },
                        itemCount: widget.shirtGroup.shirts!.length,
                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context, index) {
                          return buildShirtGroupShirtCard(context, index);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 52),
              child: Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${widget.shirtGroup.name}\n',
                        style: const TextStyle(color: Colors.amber, fontSize: 28)),
                    TextSpan(
                        text: 'creator: ${widget.shirtGroup.creator}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ]))
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 84,
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        context.read<ShirtOrderBlocBloc>().add(ShirtOrderStarted(shirt:shirt));
                        showModalBottomSheet(context: context, builder: (_){
                          return ShirtOrderForm(cartBloc: cartBloc,
                          shirtOrderBlocBloc: shirtOrderBloc,
                          shirt: shirt,);
                        });
                      },
                      child: const Text('Buy Now'),
                    )),
                Expanded(
                    child: SizedBox(
                  height: 84,
                  child: ElevatedButton(
                    style: buttonStyle2,
                    child: const Text('More Info'),
                    onPressed: () {},
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     backgroundColor: Colors.black,
    //     title: Text(widget.shirtGroup.name!),
    //   ),
    //   body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    //     SizedBox(
    //         height: 100,
    //         width: double.infinity,
    //         child: Image.network(
    //           widget.shirtGroup.groupImage!,
    //           fit: BoxFit.cover,
    //         )),
    //     Container(
    //       height: 400,
    //       width: 400,
    //       child: ShirtGroupListShirtSelector(
    //         shirtList: widget.shirtGroup.shirts!,
    //       ),
    //     ),
    //     Column(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         Container(
    //           decoration: const BoxDecoration(
    //               color: Colors.black,
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(60),
    //                   topRight: Radius.circular(60))),
    //           height: 240,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     widget.shirtGroup.shirts![1].name!,
    //                     style:
    //                         const TextStyle(color: Colors.amber, fontSize: 24),
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ]),
    // );
  }

  Container buildShirtGroupShirtCard(BuildContext context, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/ShirtDetail',
                  arguments: ShirtDetailArguments(
                      profile: widget.profile,
                      shirt: widget.shirtGroup.shirts![index]));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.shirtGroup.shirts![index].shirtImage!))),
                ),
                Text(
                  widget.shirtGroup.shirts![index].name!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.shirtGroup.shirts![index].price.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RatingBar.builder(
              allowHalfRating: true,
              glowColor: Colors.white,
              itemCount: 5,
              initialRating: widget.shirtGroup.shirts![index].averageRating!,
              itemSize: 28,
              itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {})
        ],
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .03),
      padding: const EdgeInsets.all(10),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: Colors.amber,
        boxShadow: const [
          BoxShadow(offset: Offset(0, 10), blurRadius: 22, color: Colors.black),
          BoxShadow(
              offset: Offset(-15, -15), blurRadius: 20, color: Colors.black)
        ],
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.abc,
        color: Colors.black,
      ),
    );
  }
}
