import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/np_projects_bloc/bloc/np_projects_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';

class CategorySelector extends StatefulWidget {
  final List<Category> categoryList;
  final bool? isNonProfit;
  final bool? isCompany;
  final bool? isAtrocity;
  final bool? isShirt;
  final bool? isProject;

  const CategorySelector(
      {Key? key,
      required this.isShirt,
      required this.isProject,
      required this.categoryList,
      required this.isNonProfit,
      required this.isAtrocity,
      required this.isCompany})
      : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Column(
        children: [
          Text('Choose Category',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 35,
            child: ListView.builder(
              itemBuilder: (context, index) => buildCategory(index),
              itemCount: widget.categoryList.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(int index) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => context.read<NpProjectsBloc>(),
        ),
        BlocProvider(
          create: (context) => context.read<ShirtBloc>(),
        ),
        BlocProvider(
          create: (context) => context.read<NonprofitBloc>(),
        ),
        BlocProvider(create: (context) => context.read<AtrocityBlocBloc>()),
        BlocProvider(create: (context) => context.read<CompanyListBloc>())
      ],
      child: GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            if (widget.isNonProfit == true) {
              context.read<NonprofitBloc>().add(FetchNonProfitsByCategory(
                  category: widget.categoryList[index]));
            } else if (widget.isAtrocity == true) {
              context.read<AtrocityBlocBloc>().add(
                  AtrocityListFetchedByCategory(
                      category: widget.categoryList[index]));
            } else if (widget.isShirt == true) {
              context.read<ShirtBloc>().add(
                  FetchShirtByCategory(category: widget.categoryList[index]));
            } else if (widget.isCompany == true) {
              context.read<CompanyListBloc>().add(FetchCompanyListByCategory(
                  category: widget.categoryList[index]));
            } else if (widget.isProject == true) {
              context.read<NpProjectsBloc>().add(FetchNpProjectListByCategory(
                  category: widget.categoryList[index]));
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.categoryList[index].name!,
                  style: TextStyle(
                      fontSize: 16,
                      color:
                          selectedIndex == index ? Colors.black : Colors.amber),
                ),
                Container(
                  height: 2,
                  width: 28,
                  color: selectedIndex == index
                      ? Colors.black
                      : Colors.transparent,
                  margin: const EdgeInsets.only(top: 1.25),
                )
              ],
            ),
          )),
    );
  }
}
