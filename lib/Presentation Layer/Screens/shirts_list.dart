import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/category_selector.dart';

class ShirtList extends StatefulWidget {
  final Profile profile;

  const ShirtList({super.key, required this.profile});
  @override
  State<ShirtList> createState() => _ShirtListState();
}

class _ShirtListState extends State<ShirtList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
              color: Colors.black,
            ),
            title: const Text(
              'Altrue Tees',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            BlocConsumer<ShirtBloc, ShirtState>(
                buildWhen: (p, c) => p.shirtlist != c.categoryShirtList,
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state.categoryShirtList.isNotEmpty) {
                    return buildShirtListByCateogory(state);
                  } else if (state.categoryShirtList.isEmpty &&
                      state.shirtlist.isNotEmpty) {
                    return buildShirtList(state);
                  }
                  {
                    return buildShirtList(state);
                  }
                })
          ],
        ));
  }

  Expanded buildShirtList(ShirtState state) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GridView.builder(
              itemCount: state.shirtlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 27,
                  mainAxisSpacing: 13,
                  childAspectRatio: .75,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => ShirtCard(
                  shirt: state.shirtlist[index],
                  press: () => context.go('/userActionScreen/ShirtDetail',
                      extra: ShirtDetailArguments(
                          shirt: state.shirtlist[index],
                          profile: widget.profile))))),
    );
  }

  Expanded buildShirtListByCateogory(ShirtState state) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GridView.builder(
          itemCount: state.categoryShirtList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 27,
              mainAxisSpacing: 13,
              childAspectRatio: .75,
              crossAxisCount: 2),
          itemBuilder: (context, index) => ShirtCard(
              shirt: state.categoryShirtList[index],
              press: () => context.go('/userActionScreen/ShirtDetail',
                  extra: ShirtDetailArguments(
                      shirt: state.categoryShirtList[index],
                      profile: widget.profile)))),
    ));
  }
}

class ShirtCard extends StatelessWidget {
  final Shirt shirt;
  final Function press;

  const ShirtCard({super.key, required this.shirt, required this.press});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(
              shirt.shirtImage!,
              scale: .7,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              shirt.name!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            shirt.price.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
