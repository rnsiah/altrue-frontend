import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/category_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/glassmorphism_widgets.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({Key? key}) : super(key: key);

  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  @override
  void initState() {
    super.initState();
  }

  // _featuredCompaniesSelector(int index) {
  //   return BlocBuilder<CompanyListBloc, CompanyListState>(
  //     builder: (context, state) {
  //       if (state is ) {
  //         return AnimatedBuilder(
  //           animation: _pageController,
  //           builder: (BuildContext context, Widget? widget) {
  //             double value = 2;
  //             if (_pageController.position.haveDimensions) {
  //               value = _pageController.page! - index;
  //               value = (1 - (value.abs() * 0.3) + 0.6).clamp(0, 1);
  //             }
  //             return Center(
  //               child: SizedBox(
  //                 height: Curves.easeInOut.transform(value) * 350,
  //                 width: Curves.easeInOut.transform(value) * 400,
  //                 child: widget,
  //               ),
  //             );
  //           },
  //           child: GestureDetector(
  //             onTap: () => Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (_) =>
  //                         CompanyDetails(company: state.companyList[index]))),
  //             child: Stack(
  //               children: [
  //                 Center(
  //                   child: Container(
  //                     margin:
  //                         EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Colors.black54,
  //                               offset: Offset(0, 4),
  //                               blurRadius: 10)
  //                         ]),
  //                     child: Center(
  //                       child: Hero(
  //                           tag: state.companyList[index].logo,
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(10),
  //                             child: Image(
  //                               image:
  //                                   NetworkImage(state.companyList[index].logo),
  //                               height: 220,
  //                               fit: BoxFit.fill,
  //                             ),
  //                           )),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                     left: 30,
  //                     bottom: 40,
  //                     child: Text(
  //                       state.companyList[index].name.toUpperCase(),
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                           fontSize: 16,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold),
  //                     ))
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
          height: 32,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(GlassmorphismTheme.radiusLg),
          bottomRight: Radius.circular(GlassmorphismTheme.radiusLg),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    GlassmorphismTheme.darkPrimary,
                    GlassmorphismTheme.darkSecondary,
                    GlassmorphismTheme.darkTertiary,
                  ]
                : [
                    GlassmorphismTheme.lightPrimary,
                    GlassmorphismTheme.lightSecondary,
                  ],
          ),
        ),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => CategoryRepository()),
            RepositoryProvider(create: (_) => CompanyRepository())
          ],
          child: Column(
            children: [
              const SizedBox(height: GlassmorphismTheme.xl + kToolbarHeight),
              BlocProvider(
                create: (context) => context.read<CompanyListBloc>(),
                child: BlocBuilder<CompanyListBloc, CompanyListState>(
                  builder: (context, state) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: GlassmorphismTheme.md),
                        child: GridView.builder(
                          itemCount: state.companies.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: GlassmorphismTheme.md,
                            mainAxisSpacing: GlassmorphismTheme.md,
                            childAspectRatio: .70,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) => CompanyCard(
                            company: state.companies[index],
                            press: () => Navigator.pushNamed(
                              context,
                              '/company_details',
                              arguments: state.companies[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final ForProfitCompany company;
  final Function press;

  const CompanyCard({super.key, required this.company, required this.press});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => press(),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo Container
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(GlassmorphismTheme.sm),
                decoration: BoxDecoration(
                  color: isDark
                      ? GlassmorphismTheme.darkSecondary
                      : GlassmorphismTheme.lightSecondary,
                  borderRadius:
                      BorderRadius.circular(GlassmorphismTheme.radiusMd),
                ),
                child: company.logo != null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(GlassmorphismTheme.radiusMd),
                        child: Image.network(
                          company.logo!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: isDark
                                ? GlassmorphismTheme.darkTertiary
                                : GlassmorphismTheme.lightTertiary,
                            child: Icon(
                              Icons.business,
                              color: isDark
                                  ? GlassmorphismTheme.textSecondary
                                  : GlassmorphismTheme.textSecondaryLight,
                              size: 48,
                            ),
                          ),
                        ),
                      )
                    : Icon(
                        Icons.business,
                        color: isDark
                            ? GlassmorphismTheme.textSecondary
                            : GlassmorphismTheme.textSecondaryLight,
                        size: 48,
                      ),
              ),
            ),

            // Info Section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(GlassmorphismTheme.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      company.name,
                      style: TextStyle(
                        fontSize: GlassmorphismTheme.bodySize,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? GlassmorphismTheme.textPrimary
                            : GlassmorphismTheme.textPrimaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (company.mission != null &&
                        company.mission!.isNotEmpty) ...[
                      const SizedBox(height: GlassmorphismTheme.xs),
                      Text(
                        company.mission!,
                        style: TextStyle(
                          fontSize: GlassmorphismTheme.captionSize,
                          color: isDark
                              ? GlassmorphismTheme.textSecondary
                              : GlassmorphismTheme.textSecondaryLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    // Matching badge if applicable
                    if (company.atrocityMatchRelationships?.isNotEmpty ==
                            true ||
                        company.nonprofitMatchRelationships?.isNotEmpty ==
                            true) ...[
                      const Spacer(),
                      _buildMatchBadge(context),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchBadge(BuildContext context) {
    final hasCampaign = company.atrocityMatchRelationships
            ?.any((r) => r.match != null && r.match! > 100) ??
        false;

    if (hasCampaign) {
      return GoldBadge(
        text: '2x Campaign',
        icon: Icons.star,
        isCampaign: true,
      );
    }

    // Check base match percentage
    final baseMatch =
        company.nonprofitMatchRelationships?.firstOrNull?.matchLevel ??
            company.atrocityMatchRelationships?.firstOrNull?.match;

    if (baseMatch != null && baseMatch > 0) {
      return GoldBadge(
        text: '${baseMatch.toInt()}% Match',
        icon: Icons.favorite,
      );
    }

    return GoldBadge(
      text: 'Matching',
      icon: Icons.favorite_border,
    );
  }
}
