// import 'package:flutter/material.dart';
// import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
// import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
// import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/shirt_group_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
// import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/altrue_actions_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_details.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_list.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/cause_list.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/companies_list.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/company_dashboard.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/company_donations_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/company_home.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/company_match_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/company_signup.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/create_link.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/credit_card_page.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/leaderboard_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/mynonprofit_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/newProject.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/non_profit_detail.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_list_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_signup.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/profile_page.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/qr_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/quiz_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/shirt_details.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/shirts_list.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/supporters.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/test_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/thankyou_purchase_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/userProfile_fillScreen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/user_actions_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/user_nonprofitsList.dart';
// import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';
// import 'package:lovelovelove/Presentation%20Layer/Widgets/company/company_detail_page.dart';
// import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet.dart';

// import '../../Data Layer/Models/post_model.dart';
// import '../../Data Layer/Models/quiz_model.dart';
// import '../Screens/all_projects_list.dart';
// import '../Screens/cause2.dart';
// import '../Screens/comp_dashboard_donate.dart';
// import '../Screens/company_rewards_screen.dart';
// import '../Screens/create_company_rewards_screen.dart';
// import '../Screens/edit_my_profile_screen.dart';
// import '../Screens/email_verification_screen.dart';
// import '../Screens/featured_shirts.dart';
// import '../Screens/new_posts.dart';
// import '../Screens/nonprofit_donation_management_screen.dart';
// import '../Screens/nonprofit_project_detail.dart';
// import '../Screens/nonprofit_project_list.dart';
// import '../Screens/np_matching_info_screen.dart';
// import '../Screens/np_projects_list.dart';
// import '../Screens/quiz_list_screen.dart';
// import '../Screens/quiz_results_screen.dart';
// import '../Screens/shirtgroup_list.dart';
// import '../Screens/user_profile_presentation_screen.dart';
// import '../Widgets/company_dontation_form.dart';

// Widget makeRoute(
//     {required BuildContext context,
//     required String routeName,
//     Object? arguments}) {
//   final Widget child =
//       _buildRoute(context: context, routeName: routeName, arguments: arguments);
//   return child;
// }

// Widget _buildRoute(
//     {required BuildContext context,
//     required String routeName,
//     Object? arguments}) {
//   switch (routeName) {
//     case '/userActionScreen':
//     Profile profile = arguments as Profile;
//     return  UserActionRewardScreen(profile: profile,);
//     case'/testscreen':
//     User user = arguments as User;
//     return TestScreen(user: user);

//     case '/email-verified':
//       return const EmailVerifiedScreen();

//     case '/signUp':
//       return const SignUpScreen();
//     case '/home':
//       HomeArguments homearguments = arguments as HomeArguments;
//       return HomePage(
//         cartBloc: homearguments.cartBloc,
//         user: homearguments.user,
//       );
//     case '/userProfile':
//       Profile profile = arguments as Profile;

//       return ProfileScreen(
//         profile: profile,
//       );
//     case '/signup':
//       return const SignUpScreen();
//     case '/usernonprofits':
//       Profile profile = arguments as Profile;
//       return UserNonProfits(
//         profile: profile,
//       );
//     case '/myQrCode':
//       Profile profile = arguments as Profile;
//       return MyQrScreen(
//         profile: profile,
//       );

//     case '/newPosts':
//       Profile profile = arguments as Profile;
//       return NewPostsScreen(
//         profile: profile,
//       );
//     case '/companyDonations':
//       CompanyHomeArguments argument = arguments as CompanyHomeArguments;
//       return CompanyDonationScreen(
//           company: argument.company, profile: arguments.profile);
//     case '/companyaddDonation':
//       ForProfitCompany company = arguments as ForProfitCompany;
//       return const CompanyDonationPage();
//     case '/supporters':
//       Profile profile = arguments as Profile;
//       return SupporterPage(profile: profile);
//     case '/shirts':
//       Profile profile = arguments as Profile;
//       return ShirtList(
//         profile: profile,
//       );
//     case '/editmyprofile':
//       Profile profile = arguments as Profile;
//       return ProfileEditScreen(profile: profile);
//     case '/thankyou':
//       ThankYouScreenArguments argument = arguments as ThankYouScreenArguments;
//       return const ThankYouPurchaseScreen();
//     case '/payment':
//       return PaymentScreen();
//     case '/ShirtDetail':
//       ShirtDetailArguments argument = arguments as ShirtDetailArguments;
//       return ShirtDetails(
//         shirt: argument.shirt,
//         profile: argument.profile,
//       );
//     case '/nonprofits':
//       Profile profile = arguments as Profile;
//       return NonProfitList(
//         profile: profile,
//       );
//     case '/nonProfitView':
//       final argument = arguments as NonProfitDetailArguments;
//       return NonProfitDetails(
//         nonProfit: argument.nonProfit,
//         profile: argument.profile,
//       );
//     case '/allProjectsList':
//       Profile profile = arguments as Profile;
//       return AllProjectsList(
//         profile: profile,
//       );
//     case '/atrocities':
//       AtrocityListArguments argument = arguments as AtrocityListArguments;
//       return AtrocityList(profile: argument.profile);
//     case '/atrocityView':
//       AtrocityDetailArguments atrocity = arguments as AtrocityDetailArguments;
//       return AtrocityDetails(
//         atrocity: atrocity.atrocity,
//         profile: atrocity.profile,
//         atrocityId: atrocity.atrocity.id!.toString(),
//       );
//     case '/causes':
//       final CauseListArguments argument = arguments as CauseListArguments;
//       return CauseList(profile: argument.profile);
//     case '/causeView':
//       final argument = arguments as CategoryArguments;
//       return CauseDetails2(
//         cause: argument.category,
//         profile: argument.profile,
//         causeId: argument.category.id.toString(),
//       );
//     case '/companies':
//       final argument = arguments as CompaniesListArguments;
//       return CompaniesListScreen(
//           profile: argument.profile, companies: argument.companies);
//     case '/comapnyRewards':
//       final argument = arguments as CompanyHomeArguments;
//       return CompanyRewardsScreen(
//           profile: argument.profile, company: argument.company);
//     case '/createCompanyReward':
//       final argument = arguments as CompanyHomeArguments;
//       return CreateRewardsScreen(
//           profile: argument.profile, company: argument.company);
//     case '/companyDetails':
//       ForProfitCompany company = arguments as ForProfitCompany;
//       return CompanYDetailPage(company: company);
//     case '/editprofile':
//       User user = arguments as User;
//       return UserProfileComplete(user: user,userId: user.altid.toString(),);
//     case '/findfriends':
//       Profile profile = arguments as Profile;
//       return FindFriends(
//         profile: profile,
//       );
//     case '/quizpage':
//       QuizPageArguments argument = arguments as QuizPageArguments;
//       return QuizPage(quiz: argument.quiz, profile: argument.profile, quizId: argument.quiz.id.toString(),);
//     case '/quizResults':
//       QuizResultsScreenArguments argument =
//           arguments as QuizResultsScreenArguments;
//       return QuizResultsScreen(
//         profile: argument.profile,
//         numOfCorrect: argument.numOfCorrect,
//         numOfQuestions: argument.numOfQuestions,
//         finalScore: argument.finalScore,
//         quiz: argument.quiz,
//       );
//     case '/quizList':
//       QuizListScreenArguments argument = arguments as QuizListScreenArguments;
//       return QuizListScreen(quizes: argument.quizes, profile: argument.profile);

//     case '/profilepage':
//       Profile profile = arguments as Profile;
//       return ProfilePage(profile: profile);

//     case '/userProfilePage':
//       Profile profile = arguments as Profile;
//       return ProfilePresentationScreen(profile: profile);
//     case '/nonprofitRegister':
//       Profile profile = arguments as Profile;
//       return NonProfitSignUp(profile: profile);
//     case '/companyRegister':
//       Profile profile = arguments as Profile;
//       return CompanySignupPage(profile: profile);
//     case '/companymatch':
//       CompanyMatchScreenArguments argument =
//           arguments as CompanyMatchScreenArguments;
//       return CompanyMatchScreen(
//         company: argument.company,
//         profile: argument.profile,
//       );
//     case '/creditCardDetails':
//       return const CreditCardPage();
//     case '/nonprofitProjectList':
//       NonProfitProjectListArguments argument =
//           arguments as NonProfitProjectListArguments;
//       return NonProfitProjectList(
//         nonprofitId: argument.nonProfit.id.toString(),
//         profile: argument.profile,
//         nonprofit: argument.nonProfit,
//       );
//     case '/shirtGroupList':
//       final ShirtGroupArguments argument = arguments as ShirtGroupArguments;
//       return ShirtGroupListPage(
//         profile: argument.profile,
//         shirtGroupId: argument.shirtGroup.id.toString(),
//         shirtGroup: argument.shirtGroup,
//       );
//     case '/companyDashboard':
//       final argument = arguments as DashBoardScreenArguments;
//       return MyDiaryScreen(
//         profile: argument.profile,
//       );
//     case '/mynonprofit':
//       MyNonProfitDetailArgments argument =
//           arguments as MyNonProfitDetailArgments;
//       return MyNonProfitHome(
//         profile: argument.profile,
//         nonprofit: argument.nonprofit,
//       );
//     case '/allNpProjects':
//       Profile profile = arguments as Profile;
//       return AllNPProjects(
//         profile: profile,
//       );
//     case '/npMatchinginfo':
//       NonProfit nonprofit = arguments as NonProfit;
//       return NpMatchingInfo(nonprofit: nonprofit);
//     case '/altrueActionsScreen':
//       Profile profile = arguments as Profile;
//       return AltrueActionsScreen(
//         profile: profile,
//       );

//     case '/leaderboard':
//     return const LeaderboardScreen();
//     case '/CompanyHome':
//       CompanyHomeArguments argument = arguments as CompanyHomeArguments;
//       return MyCompanyHome(
//         profile: argument.profile,
//         company: argument.company,
//       );

//     case '/createProject':
//       CreateProjectArguments argument = arguments as CreateProjectArguments;
//       return NewProject(
//         nonprofit: argument.nonprofit,
//         profile: argument.profile,
//       );

//     case '/npDonationManagement':
//       NonProfit nonprofit = arguments as NonProfit;
//       return NonProfitDonationManagementScreen(nonprofit: nonprofit);

//     case '/createNPLink':
//       NonProfit nonprofit = arguments as NonProfit;
//       return CreateLink(nonprofit: nonprofit);

//     case '/featuredShirts':
//       Profile profile = arguments as Profile;
//       return FeaturedShirtScreen(
//         profile: profile,
//       );

//     case '/exampledonation':
//       return const CompanyDonationForm();

//     case '/npProjectDetails':
//       NonProfitProjectDetailArguments argument =
//           arguments as NonProfitProjectDetailArguments;
//       return NonProjectDetail(
//           project: argument.project, profile: argument.profile);

//     default:
//       throw 'Route $routeName is not defined';
//   }
// }

// class QuizResultsScreenArguments {
//   Profile profile;
//   int numOfCorrect;
//   int numOfQuestions;
//   double finalScore;
//   Quiz quiz;

//   QuizResultsScreenArguments(
//       {required this.profile,
//       required this.numOfCorrect,
//       required this.numOfQuestions,
//       required this.finalScore,
//       required this.quiz});
// }

// class CompanyMatchScreenArguments {
//   ForProfitCompany company;
//   Profile profile;

//   CompanyMatchScreenArguments({required this.profile, required this.company});
// }

// class ThankYouScreenArguments {
//   bool? isNonProfit;
//   bool? isPurchase;
//   bool? isAtrocity;
//   bool? isProject;

//   ThankYouScreenArguments(
//       {this.isAtrocity, this.isNonProfit, this.isProject, this.isPurchase});
// }

// class QuizListScreenArguments {
//   List<Quiz> quizes;
//   Profile profile;

//   QuizListScreenArguments({required this.profile, required this.quizes});
// }



// class NonProfitProjectDetailArguments {
//   NonProfitProject project;
//   Profile profile;

//   NonProfitProjectDetailArguments(
//       {required this.project, required this.profile});
// }

// class NonProfitProjectListArguments {
//   NonProfit nonProfit;
//   Profile profile;
//   NonProfitProjectListArguments(
//       {required this.nonProfit, required this.profile});
// }

// class ShirtDetailArguments {
//   Shirt shirt;
//   Profile profile;
//   ShirtDetailArguments({required this.shirt, required this.profile});
// }

// class CauseListArguments {
//   Profile profile;
//   CauseListArguments({required this.profile});
// }

// class ShirtGroupArguments {
//   ShirtGroup shirtGroup;
//   Profile profile;

//   ShirtGroupArguments({required this.profile, required this.shirtGroup});
// }

// class CategoryArguments {
//   Category category;
//   Profile profile;

//   CategoryArguments({required this.category, required this.profile});
// }

// class DashBoardScreenArguments {
//   final Profile profile;

//   DashBoardScreenArguments({required this.profile});
// }

// class NonProfitListArguments {
//   final Profile profile;

//   NonProfitListArguments({required this.profile});
// }

// class CreateProjectArguments {
//   final Profile profile;
//   final NonProfit nonprofit;

//   CreateProjectArguments({required this.nonprofit, required this.profile});
// }

// class NonProfitDetailArguments {
//   final Profile profile;
//   final NonProfit nonProfit;

//   NonProfitDetailArguments({required this.nonProfit, required this.profile});
// }

// class MyNonProfitDetailArgments {
//   final Profile profile;
//   final NonProfit nonprofit;
//   MyNonProfitDetailArgments({required this.nonprofit, required this.profile});
// }

// class CompanyHomeArguments {
//   final Profile profile;
//   final ForProfitCompany company;

//   CompanyHomeArguments({required this.company, required this.profile});
// }

// class AtrocityListArguments {
//   final Profile profile;
//   AtrocityListArguments({required this.profile});
// }

// class CompaniesListArguments {
//   final Profile profile;
//   final List<ForProfitCompany> companies;

//   CompaniesListArguments({required this.companies, required this.profile});
// }

// class QuizPageArguments {
//   final Profile profile;
//   final Quiz quiz;

//   QuizPageArguments({required this.quiz, required this.profile});
// }

// class AtrocityDetailArguments {
//   final Profile profile;
//   final Atrocity atrocity;

//   AtrocityDetailArguments({required this.atrocity, required this.profile});
// }

// class HomeArguments {
//   final CartBloc cartBloc;
//   final Profile profile;
//   final User user;
//   HomeArguments(
//       {required this.profile, required this.user, required this.cartBloc});
// }
