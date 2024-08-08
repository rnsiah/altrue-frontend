import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/np_projects_bloc/bloc/np_projects_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/myNpProjects_card.dart';

import '../../Data Layer/Models/user_model.dart';
import '../Widgets/np_project_card.dart';
import '../Widgets/two_sided_rounded_button.dart';

class AllNPProjects extends StatefulWidget {
  final Profile profile;
  const AllNPProjects({super.key, required this.profile});

  @override
  State<AllNPProjects> createState() => _AllNPProjectsState();
}

class _AllNPProjectsState extends State<AllNPProjects> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      // ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              transform: Matrix4.translationValues(0.0, -20, 0.0),
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(''),
                      alignment: Alignment.topLeft,
                      fit: BoxFit.fitWidth)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: 'Support A \nProject',
                                    style: TextStyle(color: Colors.amber)),
                                TextSpan(
                                    text: ' Today',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))
                              ]),
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.amber,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/allProjectsList',
                              arguments: widget.profile);
                        },
                        child: const Text(
                          'All Projects',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: size.height * .32,
                    width: double.infinity,
                    child: Expanded(
                      child: BlocProvider.value(
                        value: context.read<NpProjectsBloc>(),
                        child: BlocBuilder<NpProjectsBloc, NpProjectsState>(
                          builder: (context, state) {
                            return ListView.builder(
                                itemCount:
                                    state.featuredNonProfitProjects.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => NpProjectCard(
                                      profile: widget.profile,
                                      project: state
                                          .featuredNonProfitProjects[index],
                                      isForMatchScreen: false,
                                    ));
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: Colors.amber, fontSize: 25),
                                      children: [
                                    TextSpan(text: "Project of the "),
                                    TextSpan(
                                      text: "Day",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ])),
                            ],
                          )
                        ]),
                  ),
                  BlocProvider.value(
                    value: context.read<NpProjectsBloc>(),
                    child: BlocBuilder<NpProjectsBloc, NpProjectsState>(
                      builder: (context, state) {
                        return projectOfTheDayCard(
                            size, context, state.projects[1]);
                      },
                    ),
                  ),
                  // BlocProvider.value(
                  //   value: context.read<NpProjectsBloc>(),
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(children: [
                  //       NpProjectCard(
                  //         project: widget.project,
                  //       ),
                  //       NpProjectCard(
                  //         project: widget.project,
                  //       )
                  //     ]),
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 90,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.profile.projectsFollowing!.length,
                  itemBuilder: (context, index) => ProjectsFollowingCard(
                      project: widget.profile.projectsFollowing![index])),
            ),
          ],
        ),
      ),
    );
  }

  // Container myProjectsCard(NonProfitProject project){

  // }

  Padding projectOfTheDayCard(
      Size size, BuildContext context, NonProfitProject project) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/npProjectDetails',
              arguments: NonProfitProjectDetailArguments(
                  profile: widget.profile, project: project));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: size.width * .9,
          height: 205,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 24,
                    top: 24,
                    right: size.width * .35,
                  ),
                  height: 205,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      image: DecorationImage(
                          image: NetworkImage(project.projectImage!),
                          fit: BoxFit.cover)),
                  // BoxDecoration(
                  //   color: Colors.black,
                  //   borderRadius: BorderRadius.circular(29),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          project.nonprofit!.name,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      Text(
                        project.title,
                        style: TextStyle(
                            backgroundColor: Colors.black.withOpacity(.15),
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Text(
                        'Funding Goal: ${project.fundraisingGoal.toString()}',
                        style: const TextStyle(
                            color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                project.information!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor:
                                        Colors.black.withOpacity(.15)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: -10,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  )),
              Positioned(
                width: 70,
                height: 70,
                right: 0,
                top: -10,
                child: Image.network(
                  project.nonprofit!.logo,
                  width: size.width * .37,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  height: 45,
                  width: size.width * .3,
                  child: TwoSideRoundedButton(
                    text: "Read",
                    radious: 24,
                    press: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
