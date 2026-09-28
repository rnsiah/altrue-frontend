import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Theme/glassmorphism_theme.dart';
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
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(
          'Altrue Tees',
          style: GlassTheme.textGold.copyWith(fontSize: 28, fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: GlassTheme.accentGold),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: GlassTheme.accentGold),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: GlassTheme.darkGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: GlassTheme.spacingXXL + GlassTheme.spacingLG), // Space for app bar
            Padding(
              padding: const EdgeInsets.only(left: GlassTheme.spacingLG),
              child: Text(
                'Global Causes',
                style: GlassTheme.textGold.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: GlassTheme.spacingMD),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return GlassCard(
                  margin: const EdgeInsets.symmetric(horizontal: GlassTheme.spacingMD),
                  padding: const EdgeInsets.all(GlassTheme.spacingSM),
                  child: CategorySelector(
                    onCategorySelected: (category) {},
                    isProject: false,
                    isNonProfit: false,
                    isShirt: true,
                    isAtrocity: false,
                    isCompany: false,
                    categoryList: state.categoryList,
                  ),
                );
              },
            ),
            const SizedBox(height: GlassTheme.spacingMD),
            Expanded(
              child: BlocConsumer<ShirtBloc, ShirtState>(
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
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildShirtList(ShirtState state) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GlassTheme.spacingMD),
          child: GridView.builder(
              itemCount: state.shirtlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: .75,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => ShirtCard(
                  shirt: state.shirtlist[index],
                  press: () => context.go('/rewardhome/ShirtDetail',
                      extra: ShirtDetailArguments(
                          shirt: state.shirtlist[index],
                          profile: widget.profile))))),
    );
  }

  Expanded buildShirtListByCateogory(ShirtState state) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: GlassTheme.spacingMD),
      child: GridView.builder(
          itemCount: state.categoryShirtList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: .75,
              crossAxisCount: 2),
          itemBuilder: (context, index) => ShirtCard(
              shirt: state.categoryShirtList[index],
              press: () => context.go('/rewardhome/ShirtDetail',
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
      child: GlassCard(
        padding: const EdgeInsets.all(GlassTheme.spacingSM),
        borderRadius: GlassTheme.radiusLG,
        borderColor: GlassTheme.accentGold.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(GlassTheme.radiusMD),
                child: Image.network(
                  shirt.shirtImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: GlassTheme.spacingSM),
            Text(
              shirt.name!,
              style: GlassTheme.textWhiteBold.copyWith(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: GlassTheme.spacingXS),
            Text(
              '\$${shirt.price.toString()}',
              style: GlassTheme.textGold.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
