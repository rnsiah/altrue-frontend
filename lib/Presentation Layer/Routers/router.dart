import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_group_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Forms/user_login_form.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/all_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/altrue_actions_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/cause2.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/cause_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/comp_dashboard_donate.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/companies_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_dashboard.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_donations_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_home.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_rewards_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_signup.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/confirmation_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/create_link.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/credit_card_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/edit_my_profile_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/email_verification_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/error_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/featured_shirts.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/leaderboard_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/mynonprofit_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/newProject.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/new_posts.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/non_profit_detail.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_donation_management_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_list_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_project_detail.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_project_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_signup.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/np_matching_info_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/np_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/profile_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/qr_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/quiz_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/shirt_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/shirtgroup_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/shirts_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/supporters.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/test_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/thankyou_purchase_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/userProfile_fillScreen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_actions_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_nonprofitsList.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_presentation_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Intro_Slider/intro_slider.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/company_detail_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dontation_form.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet.dart';



class AppRouter {
  final UserRepository userRepository = UserRepository();
  
  static final _rootNavigatorKey= GlobalKey<NavigatorState>();
  
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/intro',
    routes: <RouteBase>[
      // GoRoute(
      //   path: '/userActionScreen',
      //   builder: (context, state) {
      //   return const UserActionRewardScreen();
      //   },
      // ),
      GoRoute(
        path: '/intro',
        builder: (context, state) {
        return  IntroductionSlider();
        },
      ),
      GoRoute(
  path: '/email-verified',
  builder: (context, state) {
    return const EmailVerifiedScreen();
  },
),
GoRoute(
  path: '/signUp',
  builder: (context, state) {
    return const SignUpScreen();
  },
),
GoRoute(
  path: '/home',
  
  builder: (context, state) {
    final cartBloc = context.read<CartBloc>(); // Assuming CartBloc is provided
    final user = context.read<ProfileBloc>().state.user; // Assuming UserBloc is provided
    return HomePage(cartBloc: cartBloc, user: user!);
  },
),
GoRoute(
  path: '/userProfile/:user',
  builder: (context, state) {
    final profileId = state.pathParameters['user']!;

    // Access ProfileBloc to check the current state
    final profileState = context.read<ProfileBloc>().state;

    if (profileState.profile != null && profileState.profile!.user == int.parse(profileId)) {
      // Profile is already available and matches the requested profileId
      return ProfileScreen(profile: profileState.profile!);
    } else {
      // Dispatch event to fetch the profile if it's not available
      context.read<ProfileBloc>().add(const FetchProfile());

      // Return a loading screen while the profile is being fetched
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.successfull && state.profile?.user == int.parse(profileId)) {
            return ProfileScreen(profile: state.profile!);
          } else if (state.status == ProfileStatus.failure) {
            return ErrorScreen(message: state.message ?? 'Profile could not be loaded.');
          } else {
            return const ErrorScreen(message: 'Unknown error occurred');
          }
        },
      );
    }
  },
),
GoRoute(
  path: '/usernonprofits/:profileId',
  builder: (context, state) {
    final profileId = state.pathParameters['profileId']!;
    final profileState = context.read<ProfileBloc>().state;

    if (profileState.profile != null && profileState.profile!.user == int.parse(profileId)) {
      return UserNonProfits(profile: profileState.profile!);
    } else {
      context.read<ProfileBloc>().add(const FetchProfile());
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.successfull && state.profile?.user == int.parse(profileId)) {
            return UserNonProfits(profile: state.profile!);
          } else if (state.status == ProfileStatus.failure) {
            return ErrorScreen(message: state.message ?? 'Profile could not be loaded.');
          } else {
            return const ErrorScreen(message: 'Unknown error occurred');
          }
        },
      );
    }
  },
),
GoRoute(
  path: '/myQrCode',
  builder: (context, state) {
    final profileId = state.pathParameters['profileId']!;
    final profileState = context.read<ProfileBloc>().state;

    if (profileState.profile != null && profileState.profile!.user == int.parse(profileId)) {
      return MyQrScreen(profile: profileState.profile!);
    } else {
      context.read<ProfileBloc>().add(FetchProfile());
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.successfull && state.profile?.user == int.parse(profileId)) {
            return MyQrScreen(profile: state.profile!);
          } else if (state.status == ProfileStatus.failure) {
            return ErrorScreen(message: state.message ?? 'Profile could not be loaded.');
          } else {
            return const ErrorScreen(message: 'Unknown error occurred');
          }
        },
      );
    }
  },
),
GoRoute(
  path: '/newPosts/:profileId',
  builder: (context, state) {
    final profileId = state.pathParameters['profileId']!;
    final profileState = context.read<ProfileBloc>().state;

    if (profileState.profile != null && profileState.profile!.user == int.parse(profileId)) {
      return NewPostsScreen(profile: profileState.profile!);
    } else {
      context.read<ProfileBloc>().add(FetchProfile());
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.successfull && state.profile?.user == int.parse(profileId)) {
            return NewPostsScreen(profile: state.profile!);
          } else if (state.status == ProfileStatus.failure) {
            return ErrorScreen(message: state.message ?? 'Profile could not be loaded.');
          } else {
            return const ErrorScreen(message: 'Unknown error occurred');
          }
        },
      );
    }
  },
),
// GoRoute(
//   path: '/companyDonations/:companyId',
//   builder: (context, state) {
    

//     // Instantiate CompanyService
//     final companyService = CompanyRepository();

//     // Fetch company data
    
    

//         // Fetch profile from ProfileBloc
//         return BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, profileState) {
//             if (profileState.status == ProfileStatus.initial ||
//                 profileState.status == ProfileStatus.updating) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (profileState.status == ProfileStatus.successfull 
//                 ) {
//               return CompanyDonationScreen(
//                 company: company,
//                 profile: profileState.profile!,
//               );
//             } else if (profileState.status == ProfileStatus.failure) {
//               return ErrorScreen(message: profileState.message ?? 'Profile could not be loaded.');
//             } else {
//               return const ErrorScreen(message: 'Unknown error occurred');
//             }
//           },
//         );
//       },
    
  
// ),
GoRoute(
  path: '/supporters/:profileId',
  builder: (context, state) {
    final profileId = state.pathParameters['profileId']!;
    final profileState = context.read<ProfileBloc>().state;

    if (profileState.profile != null && profileState.profile!.user == int.parse(profileId)) {
      return SupporterPage(profile: profileState.profile!);
    } else {
      context.read<ProfileBloc>().add(FetchProfile());
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.successfull && state.profile?.user == int.parse(profileId)) {
            return SupporterPage(profile: state.profile!);
          } else if (state.status == ProfileStatus.failure) {
            return ErrorScreen(message: state.message ?? 'Profile could not be loaded.');
          } else {
            return const ErrorScreen(message: 'Unknown error occurred');
          }
        },
      );
    }
  },
),
GoRoute(
  path: 'shirts',
  builder: (context, state) {
    
    final profileState = context.read<ProfileBloc>().state;

    if (profileState.profile != null) {
      return ShirtList(profile: profileState.profile!);
    } else {
      context.read<ProfileBloc>().add(FetchProfile());
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.successfull) {
            return ShirtList(profile: state.profile!);
          } else if (state.status == ProfileStatus.failure) {
            return ErrorScreen(message: state.message ?? 'Profile could not be loaded.');
          } else {
            return const ErrorScreen(message: 'Unknown error occurred');
          }
        },
      );
    }
  },
),
GoRoute(
  path: '/ShirtDetail/:id',
  builder: (context, state) {
    // Retrieve the ID from the URL
    final shirtId = state.pathParameters['id']!;
    // Try to get the shirt object from the arguments, if passed
    final shirtDetailArguments = state.extra as ShirtDetailArguments?;
    final shirt = shirtDetailArguments?.shirt;
    final profile = shirtDetailArguments?.profile;

    if (shirt != null && profile != null) {
      // If the shirt object was passed, use it directly
      return ShirtDetails(shirt: shirt, profile: profile);
    } 
    // else {
    //   // Otherwise, you may need to fetch the shirt using the ID
    //   // Example:
    //   // final fetchedShirt = await fetchShirtById(shirtId);
    //   // return ShirtDetails(shirt: fetchedShirt, profile: profile);

    //   // Placeholder return while fetching logic is implemented
    //   return FutureBuilder<Shirt>(
    //     future: fetchShirtById(shirtId), // Implement your fetch logic here
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const CircularProgressIndicator();
    //       } else if (snapshot.hasError) {
    //         return const ErrorScreen(message: 'No Shirt Found',);
    //       } else if (snapshot.hasData) {
    //         return ShirtDetails(
    //           shirt: snapshot.data!,
    //           profile: profile!,
    //         );
    //       } else {
    //         return const ErrorScreen(message: 'No shirt found',);
    //       }
    //     },
    //   );
    // }
    return const ErrorScreen(message: 'No Shirt Found');
  },
),
GoRoute(
  path: '/thankyou',
  builder: (context, state) {
    // Extract the arguments
    final ThankYouScreenArguments args = state.extra as ThankYouScreenArguments;

    return ThankYouPurchaseScreen(
      isNonProfit: args.isNonProfit,
      isPurchase: args.isPurchase,
      isAtrocity: args.isAtrocity,
      isProject: args.isProject,
    );
  },
),
GoRoute(
  path: '/editmyprofile',
  builder: (context, state) {
    final profile = context.read<ProfileBloc>().state.profile!;
    return ProfileEditScreen(profile: profile);
  },
),

GoRoute(
  path: '/payment',
  builder: (context, state) {
    return const PaymentScreen();
  },
),



GoRoute(
  path: '/nonprofits',
  builder: (context, state) {
    final profile = context.read<ProfileBloc>().state.profile!;
    return NonProfitList(profile: profile);
  },
),
GoRoute(
  path: '/nonProfitView',
  builder: (context, state) {
    final argument = state.extra as NonProfitDetailArguments;
    return NonProfitDetails(
      nonProfit: argument.nonProfit,
      profile: argument.profile,
    );
  },
),

GoRoute(
  path: '/allProjectsList',
  builder: (context, state) {
    final profile = context.read<ProfileBloc>().state.profile!;
    return AllProjectsList(profile: profile);
  },
),
GoRoute(
  path: '/atrocities',
  builder: (context, state) {
    final argument = state.extra as AtrocityListArguments;
    return AtrocityList(profile: argument.profile);
  },
),
GoRoute(
  path: '/atrocityView/:atrocityId',
  builder: (context, state) {
    final atrocityId = state.pathParameters['atrocityId']!;
    final argument = state.extra as AtrocityDetailArguments;

    return AtrocityDetails(
      atrocityId: atrocityId,
      atrocity: argument.atrocity,
      profile: argument.profile,
    );
  },
),
GoRoute(
  path: '/causes',
  builder: (context, state) {
    final argument = state.extra as CauseListArguments;
    return CauseList(profile: argument.profile);
  },
),GoRoute(
  path: '/causeView/:causeId',
  builder: (context, state) {
    final causeId = state.pathParameters['causeId']!;
    final argument = state.extra as CategoryArguments;

    return CauseDetails2(
      causeId: causeId,
      cause: argument.category,
      profile: argument.profile,
    );
  },
),
GoRoute(
  path: '/companies',
  builder: (context, state) {
    final argument = state.extra as CompaniesListArguments;
    return CompaniesListScreen(
      profile: argument.profile,
      companies: argument.companies,
    );
  },
),

GoRoute(
  path: '/findfriends/:profileId',
  builder: (context, state) {
    final profileId = state.pathParameters['profileId']!;
    final profileState = context.read<ProfileBloc>().state;

    if (profileState.profile != null && profileState.profile!.user == int.parse(profileId)) {
      return FindFriends(profile: profileState.profile!);
    } else {
      context.read<ProfileBloc>().add(FetchProfile());
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.successfull && state.profile?.user == int.parse(profileId)) {
            return FindFriends(profile: state.profile!);
          } else if (state.status == ProfileStatus.failure) {
            return ErrorScreen(message: state.message ?? 'Profile could not be loaded.');
          } else {
            return const ErrorScreen(message: 'Unknown error occurred');
          }
        },
      );
    }
  },
),
GoRoute(
  path: '/companyDetails/:companyId',
  builder: (context, state) {
    final companyId = state.pathParameters['companyId']!;
    final company = state.extra as ForProfitCompany; // Assuming the company object is passed via extra
    return CompanYDetailPage(company: company);
  },
),

GoRoute(
  path: '/editprofile/:userId',
  builder: (context, state) {
    final userId = state.pathParameters['userId']!;
    final user = state.extra as User; // Expect the user object as extra data
    return UserProfileComplete(user: user, userId: userId,);
  },
),

GoRoute(
  path: '/companyRewards/:companyId',
  builder: (context, state) {
    final companyId = state.pathParameters['companyId']!;
    final args = state.extra as CompanyHomeArguments; // Expect the arguments as a custom object

    if (args.company.id.toString() == companyId) {
      return CompanyRewardsScreen(
        profile: args.profile,
        company: args.company,
      );
    } else {
      return const ErrorScreen(message: 'Company data is not valid.');
    }
  },
),
GoRoute(
  path: '/quizpage/:quizId',
  builder: (context, state) {
    final quizId = state.pathParameters['quizId']!;
    final args = state.extra as QuizPageArguments;

    return QuizPage(
      quizId: quizId,
      quiz: args.quiz, // Make sure you handle this accordingly if needed
      profile: args.profile,
    );
  },
),
GoRoute(
  path: '/profilepage',
  builder: (context, state) {
    final profile = state.extra as Profile;
    return ProfilePage(profile: profile);
  },
),
GoRoute(
  path: '/userProfilePage',
  builder: (context, state) {
    final profile = state.extra as Profile;
    return ProfilePresentationScreen(profile: profile);
  },
),

GoRoute(
  path: '/nonprofitRegister',
  builder: (context, state) {
    final profile = state.extra as Profile;
    return NonProfitSignUp(profile: profile);
  },
),

GoRoute(
  path: '/companyRegister',
  builder: (context, state) {
    final profile = state.extra as Profile;
    return CompanySignupPage(profile: profile);
  },
),

GoRoute(
  path: '/creditCardDetails',
  builder: (context, state) {
    return const CreditCardPage();
  },
),
GoRoute(
  path: '/nonprofitProjectList/:nonProfitId',
  builder: (context, state) {
    final nonProfitId = state.pathParameters['nonProfitId']!;
    final args = state.extra as NonProfitProjectListArguments;

    return NonProfitProjectList(
      nonprofitId: args.nonProfit.id.toString(),
      profile: args.profile,
      nonprofit: args.nonProfit, // You need to fetch nonprofit if needed using nonProfitId
    );
  },
),
GoRoute(
  path: '/shirtGroupList/:shirtGroupId',
  builder: (context, state) {
    final shirtGroupId = state.pathParameters['shirtGroupId']!;
    final args = state.extra as ShirtGroupArguments;

    return ShirtGroupListPage(
      profile: args.profile,
      shirtGroupId: args.shirtGroup.id.toString(),
      shirtGroup: args.shirtGroup, // You need to fetch shirtGroup if needed using shirtGroupId
    );
  },
),GoRoute(
  path: '/companyDashboard',
  builder: (context, state) {
    final args = state.extra as DashBoardScreenArguments;

    return MyDiaryScreen(
      profile: args.profile,
    );
  },
),
GoRoute(
  path: '/mynonprofit/:nonprofitId',
  builder: (context, state) {
    final nonprofitId = state.pathParameters['nonprofitId']!;
    final args = state.extra as MyNonProfitDetailArgments;

    return MyNonProfitHome(
      profile: args.profile,
      nonprofit: args.nonprofit, // You may need to fetch nonprofit if necessary
    );
  },
),
GoRoute(
  path: '/allNpProjects',
  builder: (context, state) {
    final profile = state.extra as Profile;

    return AllNPProjects(
      profile: profile,
    );
  },
),

GoRoute(
  path: '/npMatchinginfo/:nonprofitId',
  builder: (context, state) {
    final nonprofitId = state.pathParameters['nonprofitId']!;
    final nonprofit = state.extra as NonProfit; // Fetch nonprofit if necessary

    return NpMatchingInfo(
      nonprofit: nonprofit,
    );
  },
),
GoRoute(
  path: '/altrueActionsScreen',
  builder: (context, state) {
    final profile = state.extra as Profile;

    return AltrueActionsScreen(
      profile: profile,
    );
  },
),
GoRoute(
  path: '/leaderboard',
  builder: (context, state) {
    return const LeaderboardScreen();
  },
),
GoRoute(
  path: 'CompanyHome',
  builder: (context, state) {
    final args = state.extra as CompanyHomeArguments;

    return MyCompanyHome(
      profile: args.profile,
      company: args.company,
    );
  },
),
GoRoute(
  path: '/createProject',
  builder: (context, state) {
    final args = state.extra as CreateProjectArguments;

    return NewProject(
      nonprofit: args.nonprofit,
      profile: args.profile,
    );
  },
),
GoRoute(
  path: '/npDonationManagement/:nonprofitId',
  builder: (context, state) {
    final nonprofitId = state.pathParameters['nonprofitId']!;
    final nonprofit = state.extra as NonProfit; // Fetch nonprofit if necessary

    return NonProfitDonationManagementScreen(
      nonprofit: nonprofit,
    );
  },
),
GoRoute(
  path: '/createNPLink/:nonprofitId',
  builder: (context, state) {
    final nonprofitId = state.pathParameters['nonprofitId']!;
    final nonprofit = state.extra as NonProfit; // Fetch nonprofit if necessary

    return CreateLink(
      nonprofit: nonprofit,
    );
  },
),
GoRoute(
  path: '/featuredShirts',
  builder: (context, state) {
    final profile = state.extra as Profile;

    return FeaturedShirtScreen(
      profile: profile,
    );
  },
),GoRoute(
  path: '/exampledonation',
  builder: (context, state) {
    return const CompanyDonationForm();
  },
),
GoRoute(
  path: '/npProjectDetails/:projectId',
  builder: (context, state) {
    final args = state.extra as NonProfitProjectDetailArguments;

    return NonProjectDetail(
      project: args.project,
      profile: args.profile,
    );
  },
),



      // ... other routes
    ],
  );
  
}
   


class QuizResultsScreenArguments {
  Profile profile;
  int numOfCorrect;
  int numOfQuestions;
  double finalScore;
  Quiz quiz;

  QuizResultsScreenArguments(
      {required this.profile,
      required this.numOfCorrect,
      required this.numOfQuestions,
      required this.finalScore,
      required this.quiz});
}

class CompanyMatchScreenArguments {
  ForProfitCompany company;
  Profile profile;

  CompanyMatchScreenArguments({required this.profile, required this.company});
}

class ThankYouScreenArguments {
  bool? isNonProfit;
  bool? isPurchase;
  bool? isAtrocity;
  bool? isProject;

  ThankYouScreenArguments(
      {this.isAtrocity, this.isNonProfit, this.isProject, this.isPurchase});
}

class QuizListScreenArguments {
  List<Quiz> quizes;
  Profile profile;

  QuizListScreenArguments({required this.profile, required this.quizes});
}



class NonProfitProjectDetailArguments {
  NonProfitProject project;
  Profile profile;

  NonProfitProjectDetailArguments(
      {required this.project, required this.profile});
}

class NonProfitProjectListArguments {
  NonProfit nonProfit;
  Profile profile;
  NonProfitProjectListArguments(
      {required this.nonProfit, required this.profile});
}

class ShirtDetailArguments {
  Shirt shirt;
  Profile profile;
  ShirtDetailArguments({required this.shirt, required this.profile});
}

class CauseListArguments {
  Profile profile;
  CauseListArguments({required this.profile});
}

class ShirtGroupArguments {
  ShirtGroup shirtGroup;
  Profile profile;

  ShirtGroupArguments({required this.profile, required this.shirtGroup});
}

class CategoryArguments {
  Category category;
  Profile profile;

  CategoryArguments({required this.category, required this.profile});
}

class DashBoardScreenArguments {
  final Profile profile;

  DashBoardScreenArguments({required this.profile});
}

class NonProfitListArguments {
  final Profile profile;

  NonProfitListArguments({required this.profile});
}

class CreateProjectArguments {
  final Profile profile;
  final NonProfit nonprofit;

  CreateProjectArguments({required this.nonprofit, required this.profile});
}

class NonProfitDetailArguments {
  final Profile profile;
  final NonProfit nonProfit;

  NonProfitDetailArguments({required this.nonProfit, required this.profile});
}

class MyNonProfitDetailArgments {
  final Profile profile;
  final NonProfit nonprofit;
  MyNonProfitDetailArgments({required this.nonprofit, required this.profile});
}

class CompanyHomeArguments {
  final Profile profile;
  final ForProfitCompany company;

  CompanyHomeArguments({required this.company, required this.profile});
}

class AtrocityListArguments {
  final Profile profile;
  AtrocityListArguments({required this.profile});
}

class CompaniesListArguments {
  final Profile profile;
  final List<ForProfitCompany> companies;

  CompaniesListArguments({required this.companies, required this.profile});
}

class QuizPageArguments {
  final Profile profile;
  final Quiz quiz;

  QuizPageArguments({required this.quiz, required this.profile});
}

class AtrocityDetailArguments {
  final Profile profile;
  final Atrocity atrocity;

  AtrocityDetailArguments({required this.atrocity, required this.profile});
}

class HomeArguments {
  final CartBloc cartBloc;
  final Profile profile;
  final User user;
  HomeArguments(
      {required this.profile, required this.user, required this.cartBloc});
}




