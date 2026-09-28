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
import '../../theme/glassmorphism_theme.dart';
import '../../widgets/glass/glass_card.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: isDark
          ? GlassmorphismTheme.darkPrimary
          : GlassmorphismTheme.darkPrimary,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ]
                : [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary
                  ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(GlassmorphismTheme.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with gold accent title
                Padding(
                  padding: const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                  child: Text(
                    'Nonprofit Organizations',
                    style: GlassmorphismTheme.h1Style.copyWith(
                      color: GlassmorphismTheme.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Glass search/filter section
                GlassCard(
                  margin: const EdgeInsets.only(bottom: GlassmorphismTheme.lg),
                  hasGoldBorder: true,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      return CategorySelector(
                        onCategorySelected: (category) {},
                        isProject: false,
                        isNonProfit: true,
                        isAtrocity: false,
                        isCompany: false,
                        isShirt: false,
                        categoryList: state.categoryList,
                      );
                    },
                  ),
                ),

                // Expanded list content
                Expanded(
                  child: BlocConsumer<NonprofitBloc, NonprofitState>(
                    listener: (context, state) {
                      if (state.status == NonProfitStatus.initial) {
                        context.read<NonprofitBloc>().add(FetchNonProfitList());
                      }
                    },
                    buildWhen: (p, c) =>
                        p.nonprofitList != c.categoryNonProfitList,
                    builder: (context, state) {
                      if (state.categoryNonProfitList.isNotEmpty) {
                        return buildCategoryNonProfitList(state);
                      } else if (state.categoryNonProfitList.isEmpty &&
                          state.nonprofitList.isNotEmpty) {
                        return buildNonProfitList(state);
                      }
                      return buildNonProfitList(state);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNonProfitList(NonprofitState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
      child: GridView.builder(
        itemCount: state.nonprofitList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: GlassmorphismTheme.lg,
          mainAxisSpacing: GlassmorphismTheme.lg,
          childAspectRatio: 0.75,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => NonProfitSquare(
          profile: widget.profile,
          nonProfit: state.nonprofitList[index],
        ),
      ),
    );
  }

  Widget buildCategoryNonProfitList(NonprofitState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
      child: GridView.builder(
        itemCount: state.categoryNonProfitList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: GlassmorphismTheme.lg,
          mainAxisSpacing: GlassmorphismTheme.lg,
          childAspectRatio: 1,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => NonProfitSquare(
          profile: widget.profile,
          nonProfit: state.categoryNonProfitList[index],
        ),
      ),
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
    return GlassCard(
      onTap: () {
        context
            .read<NonprofitBloc>()
            .add(FetchNonProfitItem(nonProfit: nonProfit));
        context.go('/allNpProjects/nonProfitView',
            extra: NonProfitDetailArguments(
                nonProfit: nonProfit, profile: profile));
      },
      hasGoldBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo container with glass effect
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(GlassmorphismTheme.md),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius:
                    BorderRadius.circular(GlassmorphismTheme.radiusMd),
              ),
              child: Image.network(
                nonProfit.logo,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    color: GlassmorphismTheme.gold.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(GlassmorphismTheme.radiusMd),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: GlassmorphismTheme.gold,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.sm),
          // Organization name
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
            child: Text(
              nonProfit.name,
              style: GlassmorphismTheme.h3Style.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: GlassmorphismTheme.xs),
        ],
      ),
    );
  }
}
