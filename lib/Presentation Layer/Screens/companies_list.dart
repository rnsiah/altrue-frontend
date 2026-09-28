import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/category_selector.dart';
import 'package:lovelovelove/Theme/glassmorphism_theme.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/glassmorphism_widgets.dart';

class CompaniesListScreen extends StatefulWidget {
  final Profile profile;
  final List<ForProfitCompany>? companies;
  const CompaniesListScreen({super.key, required this.profile, this.companies});

  @override
  State<CompaniesListScreen> createState() => _CompaniesListScreenState();
}

class _CompaniesListScreenState extends State<CompaniesListScreen> {
  String _selectedFilter = 'All';
  Category? _selectedCause;
  String _searchQuery = '';

  final List<String> _filters = ['All', 'Active Matching', 'Has Campaign'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
                    Colors.blueGrey,
                    GlassmorphismTheme.lightSecondary,
                  ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: GlassmorphismTheme.xl + kToolbarHeight),

            // Search Bar
            _buildSearchBar(),

            // Filter Chips
            _buildFilterChips(),

            // Category Selector
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return CategorySelector(
                  isNonProfit: false,
                  isAtrocity: false,
                  isCompany: true,
                  categoryList: state.categoryList,
                  isShirt: false,
                  isProject: false,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCause = category;
                    });
                  },
                );
              },
            ),

            const SizedBox(height: GlassmorphismTheme.sm),

            // Results Count
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.md),
              child: BlocBuilder<CompanyListBloc, CompanyListState>(
                builder: (context, state) {
                  final filteredCount = _getFilteredCompanies(state).length;
                  return GlassCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GlassmorphismTheme.md,
                      vertical: GlassmorphismTheme.sm,
                    ),
                    child: Text(
                      '$filteredCount Companies',
                      style: TextStyle(
                        color: GlassmorphismTheme.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: GlassmorphismTheme.bodySize,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: GlassmorphismTheme.sm),

            // Company Grid
            Expanded(
              child: BlocConsumer<CompanyListBloc, CompanyListState>(
                buildWhen: (p, c) => p.companies != c.companies,
                builder: (context, state) {
                  final filteredCompanies = _getFilteredCompanies(state);

                  if (filteredCompanies.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildCompanyGrid(filteredCompanies);
                },
                listener: (context, state) => {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(GlassmorphismTheme.md),
      child: GlassTextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        hintText: 'Search companies...',
        prefixIcon: const Icon(Icons.search, color: GlassmorphismTheme.gold),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.xs),
            child: GlassChip(
              label: filter,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
          );
        },
      ),
    );
  }

  List<ForProfitCompany> _getFilteredCompanies(CompanyListState state) {
    List<ForProfitCompany> companies = state.companies;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      companies = companies.where((company) {
        return company.name.toLowerCase().contains(_searchQuery) ||
            (company.mission?.toLowerCase().contains(_searchQuery) ?? false) ||
            (company.description?.toLowerCase().contains(_searchQuery) ??
                false);
      }).toList();
    }

    // Apply category filter
    if (_selectedCause != null) {
      companies = companies.where((company) {
        return company.categories?.any((cat) => cat.id == _selectedCause!.id) ??
            false;
      }).toList();
    }

    // Apply main filter
    switch (_selectedFilter) {
      case 'Active Matching':
        companies = companies.where((company) {
          return company.atrocityMatchRelationships?.isNotEmpty == true ||
              company.nonprofitMatchRelationships?.isNotEmpty == true;
        }).toList();
        break;
      case 'Has Campaign':
        // This would require checking if company has active campaigns
        // For now, we'll check if they have matching relationships
        companies = companies.where((company) {
          return company.atrocityMatchRelationships?.isNotEmpty == true ||
              company.nonprofitMatchRelationships?.isNotEmpty == true;
        }).toList();
        break;
    }

    return companies;
  }

  Widget _buildCompanyGrid(List<ForProfitCompany> companies) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GlassmorphismTheme.sm),
      child: GridView.builder(
        itemCount: companies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: GlassmorphismTheme.md,
          childAspectRatio: .70,
          mainAxisSpacing: GlassmorphismTheme.md,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => CompanyCard(
          company: companies[index],
          press: () =>
              context.go('/newPosts/companyDetails', extra: companies[index]),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business,
            color: Colors.amber.withOpacity(0.5),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'No companies found',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final ForProfitCompany company;
  final Function press;

  const CompanyCard({super.key, required this.company, required this.press});

  bool get hasActiveMatching =>
      company.atrocityMatchRelationships?.isNotEmpty == true ||
      company.nonprofitMatchRelationships?.isNotEmpty == true;

  String? getMatchBadge() {
    if (!hasActiveMatching) return null;

    // Check for campaign match
    final hasCampaign = company.atrocityMatchRelationships
            ?.any((r) => r.match != null && r.match! > 100) ??
        false;

    if (hasCampaign) return '2x Campaign';

    // Check base match percentage
    final baseMatch =
        company.nonprofitMatchRelationships?.firstOrNull?.matchLevel ??
            company.atrocityMatchRelationships?.firstOrNull?.match;

    if (baseMatch != null && baseMatch > 0) {
      return '${baseMatch.toInt()}% Match';
    }

    return 'Matching';
  }

  @override
  Widget build(BuildContext context) {
    final badge = getMatchBadge();

    return GestureDetector(
      onTap: () => press(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo Container
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: company.logo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          company.logo!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.business,
                                color: Colors.grey, size: 48),
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.business,
                        color: Colors.grey,
                        size: 48,
                      ),
              ),
            ),

            // Info Section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Causes chips
                    if (company.categories != null &&
                        company.categories!.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        children: company.categories!.take(2).map((cat) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              cat.name!,
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 9,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    const Spacer(),

                    // Badge
                    if (badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: badge.contains('2x')
                                ? [Colors.purple, Colors.purple.shade800]
                                : [Colors.green, Colors.green.shade800],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              badge.contains('2x')
                                  ? Icons.star
                                  : Icons.favorite,
                              color: Colors.white,
                              size: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              badge,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
