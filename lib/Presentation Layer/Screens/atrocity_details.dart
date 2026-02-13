import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Atrocity_Details/atroc_donate.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Atrocity_Details/atrocity_details_tabs.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Circular_Clipper.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/atrocity_learn_more/atrocity_learn_more_tabs.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class AtrocityDetails extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;
  final String atrocityId;

  const AtrocityDetails(
      {super.key, required this.atrocity, required this.profile, required this.atrocityId});
  @override
  State<AtrocityDetails> createState() => _AtrocityDetailsState();
}

class _AtrocityDetailsState extends State<AtrocityDetails> {
  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        ),
        builder: (builder) {
          return Container(
            height: 500.0,
            color: Colors.grey, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: const SizedBox(
                child: Center(
              child: Text("This is a modal sheet"),
            )),
          );
        });
  }


  

  Future<bool> _shareAtrocity()async{
    final imageUrl = widget.atrocity.imageUrl!;
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    final tempFile = File('${(await getTemporaryDirectory()).path}/temp_image.jpg');
    await tempFile.writeAsBytes(bytes);

    final result = await Share.shareXFiles(
    [XFile(tempFile.path)],
    text: widget.atrocity.info.toString(),
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
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              elevation: 12,
              color: Colors.black,
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.black.withOpacity(.8),
                    isDismissible: true,
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
                    ),
                    builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.7,
                        minChildSize: 0.5,
                        maxChildSize: 0.90,
                        expand: false,
                        builder: (_, controller) => AtrocityDonateModal(
                            atrocity: widget.atrocity,
                            profile: widget.profile)));
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
              elevation: 12,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        AtrocityLearnMoreTabs(atrocity: widget.atrocity, profile: widget.profile,));
              },
              color: Colors.amber,
              child: const Text('Learn More',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            )
          ],
        )
      ],
      backgroundColor: Colors.black26,
      // body: SlidingUpPanel(
      //   parallaxEnabled: true,
      //   panel: Center(
      //     child: Text('Lern'),
      //   ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50, 0.0),
                child: Hero(
                  tag: widget.atrocity.imageUrl!,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: const Shadow(blurRadius: 20.0),
                    child: Image(
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.atrocity.imageUrl!),
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
              //     const Image(
              //       image: AssetImage('images/Altrue Logo White.png'),
              //       fit: BoxFit.scaleDown,
              //       height: 60,
              //       width: 150,
              //     ),
              //     IconButton(
              //       padding: const EdgeInsets.only(left: 20),
              //       onPressed: () {
              //         print(widget.atrocity.slug);
              //       },
              //       icon: const Icon(Icons.favorite),
              //       iconSize: 30,
              //       color: Colors.amber,
              //     ),
              //   ],
              // ),
              Positioned.fill(
                bottom: 30.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    elevation: 12.0,
                    padding: const EdgeInsets.all(10),
                    onPressed: () => _launchURL(widget.atrocity.videoURL),
                    shape: const CircleBorder(),
                    fillColor: Colors.white,
                    child: const Icon(Icons.play_arrow,
                        size: 60.0, color: Colors.black),
                  ),
                ),
              ),
              const Positioned(
                  bottom: 5,
                  right: 150,
                  child: Text('Watch Video',
                      style: TextStyle(color: Colors.white))),
              Positioned(
                bottom: 0,
                right: 25,
                child: Column(children: [
                  Text(
                    widget.atrocity.noOfDonations.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  const Text('Donations', style: TextStyle(color: Colors.white))
                ]),
              ),
              Positioned(
                  bottom: 0,
                  left: 20,
                  child: Column(children: [
                    Text("\$${widget.atrocity.balance}",
                        style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const Text(
                      'Altrue Funds Raised:',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ])),
              Text(widget.atrocity.balance.toString(),
                  style: const TextStyle(color: Colors.white)),
              Positioned(
                bottom: 90.0,
                left: 20.0,
                child: Column(children: [
                  IconButton(
                    onPressed: ()async{
                      final  success = await _shareAtrocity();
                      if(success){
                        profileBloc.add(ShareAtrocity(atrocity: widget.atrocity));
                      }
                    },
                    icon: const Icon(Icons.share),
                    iconSize: 40.0,
                    color: Colors.amber,
                  ),
                  Container(
                    width: 50,
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: const Text('Share',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.amber)),
                  ),
                ]),
              ),
              Positioned(
                bottom: 90.0,
                right: 25.0,
                child: Column(children: [
                  IconButton(
                    onPressed: () {
                      print(widget.atrocity.slug);
                      context
                          .read<ProfileBloc>()
                          .add(AddAtrocity(atrocity: widget.atrocity));
                    },
                    icon: const Icon(Icons.add),
                    iconSize: 40.0,
                    color: Colors.amber,
                  ),
                  Container(
                    color: Colors.black,
                    width: 50,
                    child: const Text('Follow ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.amber)),
                  ),
                ]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: Text(
                          widget.atrocity.title.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: 90,
                            height: 60,
                            child: Image(
                              fit: BoxFit.contain,
                              image:
                                  NetworkImage(widget.atrocity.country!.flag),
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'REGION:',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(widget.atrocity.region!.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      "What's Going On:",
                      style: TextStyle(fontSize: 18, color: Colors.amber),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.atrocity.info!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AtrocityDetailTabs(atrocity: widget.atrocity, profile: widget.profile)
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          message,
          style: const TextStyle(color: Colors.amber),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
