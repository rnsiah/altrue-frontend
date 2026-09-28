import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Circular_Clipper.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_learn_more/nonprofit_learn_more.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofit_learn_more/nonprofit_learn_more_tabs.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/NonProfit_Details/nonprofitdetail_tabs.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Theme/glass_widgets.dart';
import 'package:lovelovelove/Theme/glass_effects.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Data Layer/Models/rating_model.dart';

class NonProfitDetails extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NonProfitDetails(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  State<NonProfitDetails> createState() => _NonProfitDetailsState();
}

class _NonProfitDetailsState extends State<NonProfitDetails> {
  bool showVideo = false;
  YoutubePlayerController? controller;

  _launchURL(var url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _shareNonProfit() async {
    final imageUrl = widget.nonProfit.logo;
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    final tempFile =
        File('${(await getTemporaryDirectory()).path}/temp_image.jpg');
    await tempFile.writeAsBytes(bytes);

    final result = await Share.shareXFiles(
      [XFile(tempFile.path)],
      text: widget.nonProfit.description.toString(),
    );
    if (result.status == ShareResultStatus.unavailable) {
      print('Sharing is unavailable on this platform.');
      return false;
    } else if (result.status == ShareResultStatus.dismissed) {
      print('Share was dismissed.');
      return false;
    } else {
      print('Share was successful.');
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: widget.nonProfit.video!,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    return Container(
        decoration: const BoxDecoration(
          gradient: darkGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          persistentFooterButtons: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GlassButton(
                    text: 'Donate Now',
                    isAccent: true,
                    isFullWidth: false,
                    onPressed: () {
                      showModalBottomSheet(
                          isDismissible: true,
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0)),
                          ),
                          builder: (_) => DraggableScrollableSheet(
                                initialChildSize: 0.8,
                                minChildSize: 0.2,
                                maxChildSize: 0.85,
                                expand: false,
                                builder: (_, controller) => NpDonate(
                                  nonProfit: widget.nonProfit,
                                  profile: widget.profile,
                                ),
                              ));
                    },
                  ),
                  GlassButton(
                    text: 'Learn More',
                    isAccent: false,
                    isFullWidth: false,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0)),
                          ),
                          context: context,
                          builder: (context) => NPLearnMore(
                              nonprofit: widget.nonProfit,
                              profile: widget.profile));
                    },
                  )
                ],
              ),
            )
          ],
          body: Container(
            decoration: const BoxDecoration(
              gradient: darkGradient,
            ),
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(GlassmorphismTheme.radius2Xl),
                          bottomRight:
                              Radius.circular(GlassmorphismTheme.radius2Xl)),
                      child: AnimatedOpacity(
                        opacity: showVideo ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          transform: Matrix4.translationValues(0.0, -50, 0.0),
                          child: Hero(
                            tag: widget.nonProfit.logo,
                            child: ClipShadowPath(
                              clipper: CircularClipper(),
                              shadow: const Shadow(blurRadius: 20.0),
                              child: Stack(
                                children: [
                                  Image(
                                    height: 400.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        widget.nonProfit.mainImage!),
                                  ),
                                  // Glass overlay on nonprofit header image
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.3),
                                            Colors.black.withOpacity(0.7),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    showVideo
                        ? YoutubePlayer(
                            controller: controller!,
                            showVideoProgressIndicator: true,
                          )
                        : Container(),
                    AnimatedOpacity(
                      opacity: showVideo ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 300),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     IconButton(
                      //       padding: const EdgeInsets.only(left: 30),
                      //       onPressed: () => Navigator.pop(context),
                      //       icon: const Icon(Icons.arrow_back),
                      //       iconSize: 30,
                      //       color: Colors.white,
                      //     ),
                      //     const Image(
                      //       image: AssetImage('images/Altrue Logo White.png'),
                      //       fit: BoxFit.scaleDown,
                      //       height: 60,
                      //       width: 150,
                      //     ),
                      //     IconButton(
                      //       padding: const EdgeInsets.only(left: 0),
                      //       onPressed: () {
                      //         context
                      //             .read<ProfileBloc>()
                      //             .add(AddNonProfit(nonProfit: widget.nonProfit));
                      //         print(widget.nonProfit.name);
                      //       },
                      //       icon: const Icon(Icons.favorite),
                      //       iconSize: 30,
                      //       color: Colors.amber,
                      //     ),
                      //   ],
                      // ),
                    ),
                    Positioned.fill(
                      bottom: 30.0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GlassButton(
                          icon: showVideo ? Icons.pause : Icons.play_arrow,
                          isAccent: false,
                          borderRadius: GlassmorphismTheme.radiusXl,
                          onPressed: () {
                            setState(() {
                              showVideo = !showVideo;
                              if (showVideo) {
                                controller!.play();
                              } else {
                                controller!.pause();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    widget.nonProfit.owner!.username == widget.profile.username
                        ? const Positioned(
                            bottom: 5,
                            right: 150,
                            child: Text('Edit Video Link'))
                        : const Positioned(
                            bottom: 5,
                            right: 150,
                            child: Text(
                              'Watch Video',
                              style: TextStyle(color: Colors.white),
                            )),
                    Positioned(
                      bottom: 115.0,
                      right: 12,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: GlassmorphismTheme.xs,
                                bottom: GlassmorphismTheme.xs),
                            child: GlassButton(
                              icon: Icons.facebook_rounded,
                              isAccent: false,
                              borderRadius: GlassmorphismTheme.radiusXl,
                              onPressed: widget.nonProfit.facebook != null
                                  ? () => _launchURL(
                                      'http://facebook.com/${widget.nonProfit.facebook}')
                                  : () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: GlassmorphismTheme.xs,
                                right: GlassmorphismTheme.xs),
                            child: GlassButton(
                              icon: Icons.social_distance,
                              isAccent: false,
                              borderRadius: GlassmorphismTheme.radiusXl,
                              onPressed: widget.nonProfit.facebook != null
                                  ? () => _launchURL(
                                      'http://facebook.com/${widget.nonProfit.facebook}')
                                  : () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 115.0,
                      left: 28.0,
                      child: GestureDetector(
                        onTap: () async {
                          final success = await _shareNonProfit();
                          if (success) {
                            profileBloc.add(
                                ShareNonProfit(nonprofit: widget.nonProfit));
                          }
                        },
                        child: Column(children: [
                          GlassButton(
                            icon: Icons.share,
                            isAccent: false,
                            borderRadius: GlassmorphismTheme.radiusXl,
                          ),
                          const SizedBox(height: GlassmorphismTheme.xs),
                          GlassCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: GlassmorphismTheme.sm,
                              vertical: GlassmorphismTheme.xs,
                            ),
                            borderRadius: GlassmorphismTheme.radiusSm,
                            opacity: 0.2,
                            child: Text('Share',
                                style: GlassmorphismTheme.captionStyle.copyWith(
                                  color: GlassmorphismTheme.gold,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ]),
                      ),
                    ),
                    Positioned(
                      bottom: .0,
                      left: 20.0,
                      child: Column(children: [
                        Text('\$ ${widget.nonProfit.balance}',
                            style: TextStyle(
                                color: GlassmorphismTheme.gold,
                                fontWeight: FontWeight.bold,
                                fontSize: GlassmorphismTheme.h2Size)),
                        Text(
                          'Raised Already',
                          style: GlassmorphismTheme.captionStyle.copyWith(
                            color: GlassmorphismTheme.textSecondary,
                          ),
                        )
                      ]),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: GlassCard(
                          padding: const EdgeInsets.all(GlassmorphismTheme.sm),
                          borderRadius: GlassmorphismTheme.radiusMd,
                          opacity: 0.15,
                          child: Column(
                            children: [
                              RatingBar.builder(
                                itemCount: 5,
                                initialRating: 3,
                                itemSize: GlassmorphismTheme.h3Size,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: GlassmorphismTheme.gold,
                                ),
                                onRatingUpdate: (rating) {
                                  Rating theRating = Rating(
                                      user: widget.profile,
                                      stars: rating.toInt(),
                                      nonprofit: widget.nonProfit.id);
                                  context
                                      .read<ProfileBloc>()
                                      .add(RateSomething(rating: theRating));
                                },
                              ),
                              Text(
                                'Rate NonProfit',
                                style: GlassmorphismTheme.captionStyle.copyWith(
                                  color: GlassmorphismTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        )),
                    widget.nonProfit.owner!.username == widget.profile.username
                        ? Positioned(
                            bottom: 90.0,
                            right: 25.0,
                            child: Column(children: [
                              GlassButton(
                                icon: Icons.edit,
                                isAccent: false,
                                borderRadius: GlassmorphismTheme.radiusXl,
                                onPressed: () {},
                              ),
                              const SizedBox(height: GlassmorphismTheme.xs),
                              GlassCard(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: GlassmorphismTheme.sm,
                                  vertical: GlassmorphismTheme.xs,
                                ),
                                borderRadius: GlassmorphismTheme.radiusSm,
                                opacity: 0.2,
                                child: Text('Edit Image',
                                    textAlign: TextAlign.center,
                                    style: GlassmorphismTheme.captionStyle
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: GlassmorphismTheme.gold,
                                    )),
                              ),
                            ]),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                  ],
                ),
                const SizedBox(
                  height: GlassmorphismTheme.md,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GlassmorphismTheme.md,
                      vertical: GlassmorphismTheme.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(children: [
                        Expanded(
                          flex: 3,
                          child: GlassCard(
                            padding:
                                const EdgeInsets.all(GlassmorphismTheme.md),
                            borderRadius: GlassmorphismTheme.radiusLg,
                            opacity: 0.1,
                            child: Text(
                              widget.nonProfit.name.toUpperCase(),
                              style: GlassmorphismTheme.h2Style.copyWith(
                                color: GlassmorphismTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        const SizedBox(width: GlassmorphismTheme.md),
                        GlassCard(
                          padding: const EdgeInsets.all(GlassmorphismTheme.md),
                          borderRadius: GlassmorphismTheme.radiusLg,
                          opacity: 0.1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    _launchURL(widget.nonProfit.websiteUrl),
                                child: Image(
                                  image: NetworkImage(widget.nonProfit.logo),
                                  width: 120,
                                  height: 60,
                                ),
                              ),
                              const SizedBox(height: GlassmorphismTheme.sm),
                              Text(
                                'Year Started: ${widget.nonProfit.yearStarted}',
                                style: GlassmorphismTheme.captionStyle.copyWith(
                                  color: GlassmorphismTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),

                      const SizedBox(
                        height: GlassmorphismTheme.lg,
                      ),

                      GlassCard(
                        padding: const EdgeInsets.all(GlassmorphismTheme.lg),
                        borderRadius: GlassmorphismTheme.radiusXl,
                        opacity: 0.1,
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.nonProfit.owner!.username ==
                                      widget.profile.username
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mission Statement',
                                          textAlign: TextAlign.center,
                                          style: GlassmorphismTheme.h3Style
                                              .copyWith(
                                            color: GlassmorphismTheme.gold,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: GlassmorphismTheme.gold,
                                              size: GlassmorphismTheme.h3Size,
                                            ))
                                      ],
                                    )
                                  : Text(
                                      'Mission Statement',
                                      textAlign: TextAlign.center,
                                      style:
                                          GlassmorphismTheme.h3Style.copyWith(
                                        color: GlassmorphismTheme.gold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(GlassmorphismTheme.sm),
                                child: Text(
                                  widget.nonProfit.missionStatement!,
                                  style: GlassmorphismTheme.bodyStyle.copyWith(
                                    color: GlassmorphismTheme.textPrimary,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              const SizedBox(
                                height: GlassmorphismTheme.lg,
                              ),
                              widget.nonProfit.owner!.username ==
                                      widget.profile.username
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Vision Statement',
                                          textAlign: TextAlign.center,
                                          style: GlassmorphismTheme.h3Style
                                              .copyWith(
                                            color: GlassmorphismTheme.gold,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: GlassmorphismTheme.gold,
                                              size: GlassmorphismTheme.h3Size,
                                            ))
                                      ],
                                    )
                                  : Text(
                                      'Vision Statement',
                                      textAlign: TextAlign.center,
                                      style:
                                          GlassmorphismTheme.h3Style.copyWith(
                                        color: GlassmorphismTheme.gold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(GlassmorphismTheme.sm),
                                child: Text(
                                  widget.nonProfit.visionStatement!,
                                  style: GlassmorphismTheme.bodyStyle.copyWith(
                                    color: GlassmorphismTheme.textPrimary,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                      const SizedBox(height: GlassmorphismTheme.xl),
                      GlassCard(
                        padding: const EdgeInsets.all(GlassmorphismTheme.md),
                        borderRadius: GlassmorphismTheme.radiusLg,
                        opacity: 0.1,
                        child: Center(
                            child: Text('Support The Altrue Way',
                                style: GlassmorphismTheme.h3Style.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: GlassmorphismTheme.gold,
                                ))),
                      ),
                      const SizedBox(
                        height: GlassmorphismTheme.md,
                      ),
                      GlassCard(
                        padding: const EdgeInsets.all(GlassmorphismTheme.sm),
                        borderRadius: GlassmorphismTheme.radiusXl,
                        opacity: 0.05,
                        child: NonProfitDetailTabs(
                          nonProfit: widget.nonProfit,
                          profile: widget.profile,
                        ),
                      )
                      // NonProfitDetails(nonProfit: nonProfit)
                      //  Expanded(
                      //    child: ListView.builder(itemCount: widget.atrocities.category.length,
                      //      itemBuilder: (context, index)=>CategoryCard(
                      //        category:widget.atrocities.category[index],
                      //        press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Cause_Details(category:widget.atrocities.category[index]))),
                      //      ),
                      // ),
                      //  )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
