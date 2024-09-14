import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/np_project_rating.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/two_sided_rounded_button.dart';

import '../../Data Layer/Models/user_model.dart';

class AllNpProjectsCard extends StatefulWidget {
  final Profile profile;
  final NonProfitProject project;
  final double contHeight = 245;
  final double contWidth = 202;
  const AllNpProjectsCard(
      {super.key, required this.project, required this.profile});

  @override
  State<AllNpProjectsCard> createState() => _AllNpProjectsCardState();
}

class _AllNpProjectsCardState extends State<AllNpProjectsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 10, right: 5),
      child: GestureDetector(
        onTap: () {
          context.go('/allProjectsList/npProjectDetails',
              extra: NonProfitProjectDetailArguments(
                  project: widget.project, profile: widget.profile));
        },
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width * .4,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 200,
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
                  top: 20,
                  left: 5,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: NetworkImage(widget.project.nonprofit!.logo),
                    ),
                  )),
              Positioned(
                  top: 150,
                  child: SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width * .40,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: RichText(
                                maxLines: 2,
                                text: TextSpan(
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "${widget.project.title}\n",
                                        style: TextStyle(
                                            fontSize: 14,
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
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              widget.project.nonprofit!.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor:
                                      Colors.black.withOpacity(.44),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                  )),
              Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(29),
                                topRight: Radius.circular(29))),
                        width: 75,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: const Text(
                          'Learn More',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ),
                    ),
                  
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
