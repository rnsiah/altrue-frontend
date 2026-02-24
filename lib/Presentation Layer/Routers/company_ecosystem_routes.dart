import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/company_campaigns_bloc/company_campaigns_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/company_impact_bloc/company_impact_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/matching_bloc/matching_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_rewards_bloc/user_rewards_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/altrue_wallet_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_owner_dashboard.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_impact_screen.dart';

/// Extension routes for Company Ecosystem Phase 1
/// Add these routes to your main GoRouter configuration

List<RouteBase> getCompanyEcosystemRoutes() {
  return [
    // Altrue Wallet Screen
    GoRoute(
      path: '/wallet',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final profile = extra?['profile'] as Profile?;
        
        if (profile != null) {
          return BlocProvider(
            create: (context) => UserRewardsBloc()..add(const FetchUserRewards()),
            child: AltrueWalletScreen(profile: profile),
          );
        }
        
        // Fallback to fetching profile
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState.status == ProfileStatus.successfull && profileState.profile != null) {
              return BlocProvider(
                create: (context) => UserRewardsBloc()..add(const FetchUserRewards()),
                child: AltrueWalletScreen(profile: profileState.profile!),
              );
            } else if (profileState.status == ProfileStatus.failure) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${profileState.message}'),
                ),
              );
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    ),
    
    // Company Owner Dashboard (Read-Only)
    GoRoute(
      path: '/companyDashboard',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final company = extra?['company'] as ForProfitCompany?;
        final profile = extra?['profile'] as Profile?;
        
        if (company != null && profile != null) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CompanyImpactBloc()
                  ..add(FetchCompanyDashboard(company: company)),
              ),
            ],
            child: CompanyOwnerDashboard(
              company: company,
              profile: profile,
            ),
          );
        }
        
        return const Scaffold(
          body: Center(
            child: Text('Company data not provided'),
          ),
        );
      },
    ),
    
    // User Impact Screen
    GoRoute(
      path: '/userImpact',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final profile = extra?['profile'] as Profile?;
        
        if (profile != null) {
          return BlocProvider(
            create: (context) => CompanyImpactBloc()
              ..add(const FetchUserImpactStats()),
            child: UserImpactScreen(profile: profile),
          );
        }
        
        // Fallback to fetching profile
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState.status == ProfileStatus.successfull && profileState.profile != null) {
              return BlocProvider(
                create: (context) => CompanyImpactBloc()
                  ..add(const FetchUserImpactStats()),
                child: UserImpactScreen(profile: profileState.profile!),
              );
            } else if (profileState.status == ProfileStatus.failure) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${profileState.message}'),
                ),
              );
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    ),
  ];
}

/// Provider wrapper for company home screen with campaigns bloc
Widget wrapCompanyHomeWithBlocs({
  required Widget child,
  required ForProfitCompany company,
}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CompanyCampaignsBloc()
          ..add(FetchCompanyCampaigns(company: company, activeOnly: true)),
      ),
      BlocProvider(
        create: (context) => CompanyImpactBloc(),
      ),
    ],
    child: child,
  );
}

/// Provider wrapper for donation screen with matching bloc
Widget wrapDonationScreenWithMatchingBloc({required Widget child}) {
  return BlocProvider(
    create: (context) => MatchingBloc(),
    child: child,
  );
}
