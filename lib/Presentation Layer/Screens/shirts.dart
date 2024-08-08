import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/category_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/category_selector.dart';

class ShirtsList extends StatefulWidget {
  const ShirtsList({Key? key}) : super(key: key);

  @override
  _ShirtsListState createState() => _ShirtsListState();
}

class _ShirtsListState extends State<ShirtsList> {
  final ShirtRepository shirtRepository = ShirtRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => context.read<ShirtRepository>(),
        ),
        RepositoryProvider(create: (_) => context.read<CategoryRepository>()),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black,
                ),
                title: const Text(
                  'Altrue Tees',
                  style: TextStyle(fontSize: 22, color: Colors.amber),
                ),
                floating: true,
                expandedHeight: 80.0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                ]),
            SliverList(
                delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Global Causes',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return CategorySelector(
                    isProject: false,
                    isNonProfit: false,
                    isShirt: true,
                    isAtrocity: false,
                    isCompany: false,
                    categoryList: state.categoryList,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
