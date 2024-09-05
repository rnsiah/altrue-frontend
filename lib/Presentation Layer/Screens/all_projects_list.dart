import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/np_projects_bloc/bloc/np_projects_bloc.dart';

import '../../Data Layer/Models/user_model.dart';
import '../Widgets/card_for_all_projectsList.dart';
import '../Widgets/category_selector.dart';

class AllProjectsList extends StatefulWidget {
  final Profile profile;
  const AllProjectsList({super.key, required this.profile});

  @override
  State<AllProjectsList> createState() => _AllProjectsListState();
}

class _AllProjectsListState extends State<AllProjectsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
          title: const Image(
            image: AssetImage('images/Altrue Logo White.png'),
          ),
          backgroundColor: Colors.black),
      body: SafeArea(
          child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<CategoryBloc>(),
          ),
          BlocProvider.value(value: context.read<NpProjectsBloc>())
        ],
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16, top: 7, bottom: 5),
                child: Text(
                  'Global Causes',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return CategorySelector(
                    isNonProfit: false,
                    isAtrocity: false,
                    isCompany: false,
                    isShirt: false,
                    isProject: true,
                    categoryList: state.categoryList,
                  );
                },
              ),
            ),
            BlocConsumer<NpProjectsBloc, NpProjectsState>(
              listener: (context, state) {},
              buildWhen: (p, c) => p.projects != p.categoryNonProfitProjectList,
              builder: (context, state) {
                if (state.categoryNonProfitProjectList.isNotEmpty) {
                  return buildCategoryProjectList(state);
                } else if (state.categoryNonProfitProjectList.isEmpty &&
                    state.projects.isNotEmpty) {
                  return buildProjectList(state);
                }
                return buildProjectList(state);
              },
            ),
          ],
        ),
      )),
    );
  }

  Expanded buildProjectList(NpProjectsState state) {
    return Expanded(
        child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 12,
          mainAxisSpacing: 3,
          childAspectRatio: .65,
          crossAxisCount: 2),
      itemCount: state.projects.length,
      itemBuilder: (context, int index) {
        return AllNpProjectsCard(
          profile: widget.profile,
          project: state.projects[index],
        );
      },
    ));
  }

  Expanded buildCategoryProjectList(NpProjectsState state) {
    return Expanded(
        child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 7,
          childAspectRatio: .7,
          crossAxisCount: 2),
      itemCount: state.categoryNonProfitProjectList.length,
      itemBuilder: (context, int index) {
        return AllNpProjectsCard(
          profile: widget.profile,
          project: state.categoryNonProfitProjectList[index],
        );
      },
    ));
  }
}
