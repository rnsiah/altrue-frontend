import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/category_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/category_selector.dart';

class NonProfitList extends StatefulWidget {
  final Profile profile;

  const NonProfitList({super.key, required this.profile});

  @override
  State<NonProfitList> createState() => _NonProfitListState();
}

class _NonProfitListState extends State<NonProfitList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
      ),
      body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => CategoryRepository()),
          ],
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return CategorySelector(
                    isProject: false,
                    isNonProfit: true,
                    isAtrocity: false,
                    isCompany: false,
                    isShirt: false,
                    categoryList: state.categoryList,
                  );
                },
              ),
              BlocConsumer<NonprofitBloc, NonprofitState>(
                listener: (context, state) {
                  if (state.status == NonProfitStatus.initial) {
                    context.read<NonprofitBloc>().add(FetchNonProfitList());
                  }
                },
                buildWhen: (p, c) => p.nonprofitList != c.categoryNonProfitList,
                builder: (context, state) {
                  if (state.categoryNonProfitList.isNotEmpty) {
                    return buildCategoryNonProfitList(state);
                  } else if (state.categoryNonProfitList.isEmpty &&
                      state.nonprofitList.isNotEmpty) {
                    return buildNonProfitList(state);
                  }
                  return buildNonProfitList(state);
                },
              )
            ],
          )),
    );
  }

  Widget buildNonProfitList(NonprofitState state) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GridView.builder(
              itemCount: state.nonprofitList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 27,
                  mainAxisSpacing: 18,
                  childAspectRatio: .75,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => NonProfitSquare(
                  profile: widget.profile,
                  nonProfit: state.nonprofitList[index]))),
    );
  }

  Widget buildCategoryNonProfitList(NonprofitState state) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GridView.builder(
              itemCount: state.categoryNonProfitList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 27,
                  mainAxisSpacing: 18,
                  childAspectRatio: 1,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => NonProfitSquare(
                  profile: widget.profile,
                  nonProfit: state.categoryNonProfitList[index]))),
    );
  }
}

class NonProfitSquare extends StatelessWidget {
  const NonProfitSquare(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  final NonProfit nonProfit;
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<NonprofitBloc>()
            .add(FetchNonProfitItem(nonProfit: nonProfit));
        context.go('/allNpProjects/nonProfitView',
            extra: NonProfitDetailArguments(
                nonProfit: nonProfit, profile: profile));
      },
      child: Card(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(
                nonProfit.logo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                nonProfit.name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
