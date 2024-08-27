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


  Future<bool> _shareNonProfit()async{
    final imageUrl = widget.nonProfit.logo;
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    final tempFile = File('${(await getTemporaryDirectory()).path}/temp_image.jpg');
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
    return Scaffold(
      backgroundColor: Colors.grey[900],
      persistentFooterButtons: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .04,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
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
                child: const Text(
                  'Donate Now',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      context: context,
                      builder: (context) => NPLearnMore(
                          nonprofit: widget.nonProfit,
                          profile: widget.profile));
                },
                color: Colors.amber,
                child: const Text('Learn More',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              )
            ],
          ),
        )
      ],
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
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
                        child: Image(
                          height: 400.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.nonProfit.mainImage!),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: const EdgeInsets.only(left: 30),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                    const Image(
                      image: AssetImage('images/Altrue Logo White.png'),
                      fit: BoxFit.scaleDown,
                      height: 60,
                      width: 150,
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 0),
                      onPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(AddNonProfit(nonProfit: widget.nonProfit));
                        print(widget.nonProfit.name);
                      },
                      icon: const Icon(Icons.favorite),
                      iconSize: 30,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                bottom: 30.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    elevation: 12.0,
                    padding: const EdgeInsets.all(10),
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
                    shape: const CircleBorder(),
                    fillColor: Colors.black,
                    child: Icon(
                      showVideo ? Icons.pause : Icons.play_arrow,
                      size: 60.0,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              widget.nonProfit.owner!.username == widget.profile.username
                  ? const Positioned(
                      bottom: 5, right: 150, child: Text('Edit Video Link'))
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
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: RawMaterialButton(
                          shape: const CircleBorder(),
                          elevation: 3,
                          fillColor: Colors.black,
                          onPressed: widget.nonProfit.facebook != null
                              ? () => _launchURL(
                                  'http://facebook.com/${widget.nonProfit.facebook}')
                              : () {},
                          child: const Icon(
                            Icons.facebook_rounded,
                            color: Colors.amber,
                            size: 30,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: RawMaterialButton(
                          shape: const CircleBorder(),
                          elevation: 3,
                          fillColor: Colors.black.withOpacity(.70),
                          onPressed: widget.nonProfit.facebook != null
                              ? () => _launchURL(
                                  'http://facebook.com/${widget.nonProfit.facebook}')
                              : () {},
                          child: const Icon(
                            Icons.social_distance,
                            size: 30,
                            color: Colors.amber,
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 115.0,
                left: 28.0,
                child: GestureDetector(
                  onTap: () async{
                      final success= await _shareNonProfit();
                      if(success){
                        profileBloc.add(ShareNonProfit(nonprofit: widget.nonProfit));

                      }
                  },
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      height: 44,
                      width: 44,
                      child: const Center(
                        child: Icon(
                          Icons.share,
                          size: 30,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: const Text('Share ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.amber)),
                    ),
                  ]),
                ),
              ),
              Positioned(
                bottom: .0,
                left: 20.0,
                child: Column(children: [
                  Text('\$ ${widget.nonProfit.balance}',
                      style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 19)),
                  const Text(
                    'Raised Already',
                    style: TextStyle(color: Colors.white),
                  )
                ]),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Column(
                    children: [
                      RatingBar.builder(
                        itemCount: 5,
                        initialRating: 3,
                        itemSize: 25,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
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
                      const Text(
                        'Rate NonProfit',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                    ],
                  )),
              widget.nonProfit.owner!.username == widget.profile.username
                  ? Positioned(
                      bottom: 90.0,
                      right: 25.0,
                      child: Column(children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                          iconSize: 40.0,
                          color: Colors.amber,
                        ),
                        Container(
                          color: Colors.black,
                          width: 50,
                          child: const Text('Edit Image ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.amber,
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
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Text(
                        widget.nonProfit.name.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () => _launchURL(widget.nonProfit.websiteUrl),
                          child: Image(
                            image: NetworkImage(widget.nonProfit.logo),
                            width: 150,
                            height: 75,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Year Started:${widget.nonProfit.yearStarted}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ]),

                const SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.nonProfit.owner!.username ==
                              widget.profile.username
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mission Statement',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ))
                              ],
                            )
                          : const Text(
                              'Mission Statement',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.nonProfit.missionStatement!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      widget.nonProfit.owner!.username ==
                              widget.profile.username
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Vision Statement',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ))
                              ],
                            )
                          : const Text(
                              'Vision Statement',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.nonProfit.visionStatement!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  )),
                ),
                const SizedBox(height: 35),
                const Center(
                    child: Text('Support The Altrue Way',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.amber))),
                const SizedBox(
                  height: 14,
                ),
                NonProfitDetailTabs(
                  nonProfit: widget.nonProfit,
                  profile: widget.profile,
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
    );
  }
}
