import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/np_project_rating.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/two_sided_rounded_button.dart';

import '../../Data Layer/Models/user_model.dart';
import '../Routers/functionality_router.dart';

class NpProjectCard extends StatefulWidget {
  final NonProfitProject project;
  final bool isForMatchScreen;
  final Profile profile;
  const NpProjectCard(
      {super.key,
      required this.project,
      required this.profile,
      required this.isForMatchScreen});

  @override
  State<NpProjectCard> createState() => _NpProjectCardState();
}

class _NpProjectCardState extends State<NpProjectCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/allProjectsList/npProjectDetails',
            extra: NonProfitProjectDetailArguments(
                project: widget.project, profile: widget.profile));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 14, bottom: 24),
        height: 245,
        width: 202,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 231,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(29),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 2,
                          color: Colors.black)
                    ]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                      image: NetworkImage(widget.project.projectImage!)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36))),
              // child: Image.network(
              //   widget.project.projectImage!, fit: BoxFit.cover,alignment: Alignment.center,),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  const NpProjectRating(),
                ],
              ),
            ),
            Positioned(
                top: 10,
                left: 20,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(
                    image: NetworkImage(widget.project.nonprofit!.logo),
                  ),
                )),
            Positioned(
                top: 142,
                child: SizedBox(
                  height: 110,
                  width: 202,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: RichText(
                              maxLines: 2,
                              text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "${widget.project.title}\n",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor:
                                              Colors.black.withOpacity(.44)),
                                    ),
                                    // TextSpan(
                                    //   text:
                                    //       'Funding Goal: ${widget.project.fundraisingGoal}',
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       color: Colors.white,
                                    //       fontWeight: FontWeight.w600,
                                    //       backgroundColor:
                                    //           Colors.black.withOpacity(.44)),
                                    // ),
                                  ])),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            widget.project.nonprofit!.name,
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(.44),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        widget.isForMatchScreen == false
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(29),
                                              topRight: Radius.circular(29))),
                                      width: 101,
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Support',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 40,
                                      width: 101,
                                      child: TwoSideRoundedButton(
                                        press: () {
                                          context.go(
                                              '/npProjectDetails',
                                              extra:
                                                  NonProfitProjectDetailArguments(
                                                      project: widget.project,
                                                      profile: widget.profile));
                                        },
                                        text: 'Learn',
                                      ))
                                ],
                              )
                            : const SizedBox()
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
