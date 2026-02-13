import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Circular_Clipper.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Shirt_Details/shirt_details_tab.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/shirt_order/shirt_order_widget.dart';
import 'package:popup_banner/popup_banner.dart';

import '../../Data Layer/Models/rating_model.dart';

// ignore: must_be_immutable
class ShirtDetails extends StatefulWidget {
  Shirt shirt;
  Profile profile;
  ShirtDetails({
    super.key,
    required this.shirt,
    required this.profile,
  });

  @override
  _ShirtDetailsState createState() => _ShirtDetailsState();
}

ShirtRepository shirtRepository = ShirtRepository();

class _ShirtDetailsState extends State<ShirtDetails>
    with TickerProviderStateMixin {
  // _getShirtDetails() async {
  //   Shirt theshirt = await shirtRepository.fetchShirt(widget.shirt.id!);
  //   return theshirt;
  // }

  // _getProfile() {
  //   ProfileBloc profileBloc = context.read<ProfileBloc>();
  //   Profile profile = profileBloc.state.profile!;
  //   return profile;
  // }

  @override
  Widget build(BuildContext context) {
    // ShirtOrderBlocBloc shirtOrderBloc = context.read<ShirtOrderBlocBloc>();
    // CartBloc cartBloc = context.read<CartBloc>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.grey[900],
        floatingActionButton: widget.profile.altruePoints != null &&
                widget.shirt.requiredLevel != null &&
                widget.profile.altruePoints! >
                    widget.shirt.requiredLevel!.minimumPoints
            ? FloatingActionButton.extended(
                label: const Text('Get Now'),
                elevation: 12,
                onPressed: () {
                  context
                      .read<ShirtOrderBlocBloc>()
                      .add(ShirtOrderStarted(shirt: widget.shirt));
                  showModalBottomSheet(
                      backgroundColor: Colors.black54.withOpacity(.9),
                      context: context,
                      isScrollControlled: true, // Allow the bottom sheet to expand fully
                      builder: (_) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: ShirtOrderForm(
                              cartBloc: context.read<CartBloc>(),
                              shirtOrderBlocBloc:
                                  context.read<ShirtOrderBlocBloc>(),
                              shirt: widget.shirt,
                            ),
                          ),
                        );
                      });
                },
                backgroundColor: Colors.amber,
              )
            : FloatingActionButton(
                elevation: 12,
                backgroundColor: Colors.amber,
                child: const Text(
                  'Get This',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, right: 20, bottom: 20),
                            margin: const EdgeInsets.only(top: 45),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 10),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                if (widget
                                        .shirt.requiredLevel!.levelNumber ==
                                    1) ...[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/altrueLevel1Icon.png'))),
                                  )
                                ],
                                if (widget
                                        .shirt.requiredLevel!.levelNumber ==
                                    2) ...[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/AltrueLevel2Icon.png'))),
                                  )
                                ],
                                const Text(
                                  'You Need To Increase Your Altrue Level To Get This Exclusive Item',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
        body: ListView(children: <Widget>[
          Stack(children: <Widget>[
            Container(
              transform: Matrix4.translationValues(0.0, -50, 0.0),
              child: Hero(
                tag: widget.shirt.originalImage!,
                child: ClipShadowPath(
                  clipper: CircularClipper(),
                  shadow: const Shadow(blurRadius: 20.0),
                  child: Image(
                    height: 340.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.shirt.originalImage!),
                  ),
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     IconButton(
            //       padding: const EdgeInsets.only(left: 30),
            //       onPressed: () => Navigator.pop(context),
            //       icon: const Icon(Icons.arrow_back),
            //       iconSize: 30,
            //       color: Colors.amber,
            //     ),
            //     const Opacity(
            //       opacity: .7,
            //       child: Image(
            //         image: AssetImage('images/Altrue Logo White.png'),
            //         fit: BoxFit.scaleDown,
            //         height: 60,
            //         width: 150,
            //       ),
            //     ),
            //     IconButton(
            //       padding: const EdgeInsets.only(left: 2),
            //       onPressed: () {
            //         context
            //             .read<ProfileBloc>()
            //             .add(AddShirt(addedShirt: widget.shirt));
            //       },
            //       icon: const Icon(Icons.favorite),
            //       iconSize: 30,
            //       color: Colors.amber,
            //     ),
            //   ],
            // ),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
                        Row(children: [
          widget.shirt.variations!.isNotEmpty
              ? GestureDetector(
                  onTap: () => PopupBanner(
                      autoSlide: false,
                      fit: BoxFit.fitWidth,
                      context: context,
                      onClick: (indedx) {
                        debugPrint("clicked $indedx");
                      },
                      images: [
                        widget.shirt.shirtImage!,
                        widget.shirt.shirtBackImage!
                      ]).show(),
                  child: Container(
                      transform: Matrix4.translationValues(-20, -140, 0),
                      width: MediaQuery.of(context).size.width * .75,
                      height: 300,
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.shirt.shirtImage!),
                      )),
                )
              : GestureDetector(
                  onTap: () => PopupBanner(
                      context: context,
                      onClick: (indedx) {
                        debugPrint("clicked $indedx");
                      },
                      images: [
                        widget.shirt.shirtImage!,
                        widget.shirt.shirtBackImage!
                      ]).show(),
                  child: Container(
                      transform: Matrix4.translationValues(-30, -140, 0),
                      width: MediaQuery.of(context).size.width * .75,
                      height: 300,
                      child: Image(
                          fit: BoxFit.contain,
                          image: NetworkImage(widget.shirt.shirtImage!))),
                ),
          Container(
            transform: Matrix4.translationValues(-15, -100, 0),
            child: Column(children: [
              Text('\$${widget.shirt.price}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const Text('Price',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Points Needed',
                style: TextStyle(fontSize: 8, color: Colors.amber),
              ),
              Text(
                widget.shirt.pointsNeededToPurchase!.toString(),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              const Text(
                'Level Required ',
                style: TextStyle(fontSize: 9, color: Colors.amber),
                textAlign: TextAlign.center,
              ),
              showLevelIcon(widget.shirt, 70, 80)
            ]),
          )
                        ]),
                        Container(
          transform: Matrix4.translationValues(10, -140, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.shirt.name!,
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 28,
                          )),
                      const SizedBox(height: 8),
                      Text('Region:${widget.shirt.country!.name}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.amber)),
                      const SizedBox(height: 6),
                    ]),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Rate This Shirt',
                      style: TextStyle(fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(right: 9.0, left: 9),
                        child: BlocConsumer<ProfileBloc, ProfileState>(
                          listener: (context, state) {
                            if (state.status == ProfileStatus.rated) {
                              print('state updated');
                              _showSnackbar(
                                  context, 'Thanks For The Rating');
                            }
                          },
                          builder: (context, state) {
                            return RatingBar.builder(
                                unratedColor: Colors.white,
                                initialRating:
                                    widget.shirt.averageRating!,
                                itemSize: 18,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 4,
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                tapOnlyMode: true,
                                onRatingUpdate: (rating) {
                                  Rating theRating = Rating(
                                      stars: rating.toInt(),
                                      shirt: widget.shirt.id,
                                      user: widget.profile);
                                  print(theRating.toJson());
                                  context.read<ProfileBloc>().add(
                                      RateSomething(rating: theRating));
          
                                  _showSnackbar(
                                      context, 'Thanks For The Rating');
                                });
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Shirt Rating: ${widget.shirt.averageRating!.roundToDouble().toString()}',
                        style: const TextStyle(color: Colors.amber),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
                        ),
                        Container(
          transform: Matrix4.translationValues(0, -140, 0),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(iconColor: Colors.amber),
            header: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'The Story',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            collapsed: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.shirt.altrueInfo!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            expanded: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.shirt.altrueInfo!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
                        ),
                        Container(
          transform: Matrix4.translationValues(0, -140, 0),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(iconColor: Colors.amber),
            header: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Shirt Style',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            collapsed: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.shirt.shirtStyle!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            expanded: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.shirt.shirtStyle!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
                        ),
                        Container(
          transform: Matrix4.translationValues(0, -140, 0),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(iconColor: Colors.amber),
            header: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Shirt Materials',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            collapsed: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.shirt.shirtMaterials!,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            expanded: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.shirt.shirtMaterials!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
                        ),
          
                        Container(
          transform: Matrix4.translationValues(0, -140, 0),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(iconColor: Colors.amber),
            header: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Altrue Stats',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            collapsed: widget.shirt.quantityLimited == true
                ? const Center(
                    child: Text(
                      'Limited Quantity',
                      style: TextStyle(color: Colors.white, fontSize: 45),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            expanded: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                        child: Text(
                      '${widget.shirt.shirtSizes!.first.size} - ${widget.shirt.shirtSizes!.last.size}',
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    )),
                    const Text(
                      'Shirt Sizes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.shirt.totalQuanity.toString(),
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Shirt Qty',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.shirt.averageRating.toString(),
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Shirt Rating',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
                        ),
          
                        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Container(
              child: Column(children: const [
            // Container(
            //   transform: Matrix4.translationValues(-128, 0, 0),
            //   child: const Text('Shirt Info:',
            //       style: TextStyle(
            //           fontSize: 22,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white)),
            // ),
            SizedBox(height: 6),
          
            // Text(
            //   widget.shirt.altrueInfo ?? widget.shirt.altrueInfo!,
            //   style: const TextStyle(
            //       fontSize: 14, color: Colors.white),
            // ),
          ])),
                        ),
                        // Text(
                        //   shirt.atrocity[0].title,
                        //   style: TextStyle(
                        //       fontSize: 21,
                        //       fontWeight: FontWeight.w600
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                      ]),
          ShirtDetailTabs(
            shirt: widget.shirt,
            profile: widget.profile,
          )
        ]));
  }

  showLevelIcon(Shirt shirt, double height, double width) {
    if (shirt.requiredLevel!.levelNumber == 1) {
      return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/altrueLevel1Icon.png'))),
      );
    } else if (shirt.requiredLevel!.levelNumber == 2) {
      return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/AltrueLevel2Icon.png'))),
      );
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          message,
          style: const TextStyle(color: Colors.amber),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
