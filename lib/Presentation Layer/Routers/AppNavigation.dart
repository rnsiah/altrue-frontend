import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/websocket_bloc/bloc/web_socket_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_donation_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Forms/user_login_form.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/all_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/cause2.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/cause_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/companies_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_donations_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_home.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/company_rewards_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/confirmation_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/create_company_rewards_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/credit_card_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/edit_my_profile_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/error_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/featured_shirts.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/main_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/new_posts.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/non_profit_detail.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_list_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_project_detail.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/np_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/qr_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/quiz_list_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/quiz_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/rewardsHome.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/shirt_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/shirts_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/splash_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/supporters.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/thankyou_purchase_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/userProfile_fillScreen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_actions_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_nonprofitsList.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_presentation_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Intro_Slider/intro_slider.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/company_detail_page.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet.dart';

class AppNavigation {
  AppNavigation._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final _shellNavigatorRewards =
      GlobalKey<NavigatorState>(debugLabel: 'shellRewards');
  static final _shellNavigatorCommunity =
      GlobalKey<NavigatorState>(debugLabel: 'shellFeed');
  static final _shellNavigatorSupport =
      GlobalKey<NavigatorState>(debugLabel: 'shellSupport');

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/intro',
        builder: (context, state) => const IntroductionSlider(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPageUp(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
        routes: [
          GoRoute(
            path: 'confirm',
            builder: (context, state) => ConfirmationScreen(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MultiBlocListener(
            listeners: [
              BlocListener<WebSocketBloc, WebSocketState>(
                listener: (context, state) {
                  if (state is WebsocketShowSnackbar) {
                    final scaffolMessegner = ScaffoldMessenger.maybeOf(context);
                    if (scaffolMessegner != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 250,
                              right: 13,
                              left: 13),
                          action: SnackBarAction(
                              label: 'Go Check it out',
                              onPressed: () => context.go('/userActionScreen')),
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.greenAccent),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Action: ${state.message}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: state.color,
                          duration: const Duration(seconds: 6),
                        ),
                      );
                    }
                  }
                },
              ),
              BlocListener<SessionBLoc, SessionState>(
                listener: (context, state) {
                  if (state is AuthenticatedWithProfile) {
                    final userId = state.user.altid;
                    context.read<WebSocketBloc>().add(WebsocketConnect(
                        url:
                            'wss://3e2f-2601-2c6-500-16f0-4d5f-6af6-5b47-3b45.ngrok-free.app/ws/rewards/$userId/'));
                  }
                },
              ),
            ],
            child: BlocBuilder<SessionBLoc, SessionState>(
              builder: (context, state) {
                if(state is AuthenticatedWithProfile){
                  return MainScreen(navigationShell: navigationShell);
                }
                return IntroductionSlider();
              },
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return BlocBuilder<SessionBLoc, SessionState>(
                    builder: (context, state) {
                      if (state is AuthenticatedWithProfile) {
                        return HomePage(
                            user: state.user,
                            cartBloc: context.read<CartBloc>());
                      } else if (state is Authenticated) {
                        return UserProfileComplete(
                          user: state.user,
                          userId: state.user.altid.toString(),
                        );
                      }
                      return const IntroductionSlider();
                    },
                  );
                },
                routes: [
                  GoRoute(
                    path: 'usernonprofits',
                    builder: (context, state) {
                      final profileState = context.read<ProfileBloc>().state;

                      if (profileState.profile != null) {
                        return UserNonProfits(profile: profileState.profile!);
                      } else {
                        context.read<ProfileBloc>().add(const FetchProfile());
                        return BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state.status == ProfileStatus.initial ||
                                state.status == ProfileStatus.updating) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state.status ==
                                ProfileStatus.successfull) {
                              return UserNonProfits(profile: state.profile!);
                            } else if (state.status == ProfileStatus.failure) {
                              return ErrorScreen(
                                  message: state.message ??
                                      'Profile could not be loaded.');
                            } else {
                              return const ErrorScreen(
                                  message: 'Unknown error occurred');
                            }
                          },
                        );
                      }
                    },
                  ),

                  // Add additional routes for the home branch if needed
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: [
              GoRoute(
                  path: '/userProfile',
                  builder: (context, state) {
                    // Access ProfileBloc to check the current state
                    final profileState = context.read<ProfileBloc>().state;

                    if (profileState.profile != null) {
                      // Profile is already available and matches the requested profileId
                      return ProfileScreen(profile: profileState.profile!);
                    } else {
                      // Dispatch event to fetch the profile if it's not available
                      context.read<ProfileBloc>().add(const FetchProfile());

                      // Return a loading screen while the profile is being fetched
                      return BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state.status == ProfileStatus.initial ||
                              state.status == ProfileStatus.updating) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state.status ==
                              ProfileStatus.successfull) {
                            return ProfileScreen(profile: state.profile!);
                          } else if (state.status == ProfileStatus.failure) {
                            return ErrorScreen(
                                message: state.message ??
                                    'Profile could not be loaded.');
                          } else {
                            return const ErrorScreen(
                                message: 'Unknown error occurred');
                          }
                        },
                      );
                    }
                  },
                  routes: [
                    GoRoute(
                      path: 'supporters',
                      builder: (context, state) {
                        final profileState = context.read<ProfileBloc>().state;

                        if (profileState.profile != null ) {
                          return SupporterPage(profile: profileState.profile!);
                        } else {
                          context.read<ProfileBloc>().add(FetchProfile());
                          return BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, state) {
                              if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state.status == ProfileStatus.successfull ) {
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
                      path: 'editmyprofile',
                      builder: (context, state) {
                        final profile =
                            context.read<ProfileBloc>().state.profile!;
                        return ProfileEditScreen(profile: profile);
                      },
                    ),
                    GoRoute(
                      path: 'myQrCode',
                      builder: (context, state) {
                        final profileState = context.read<ProfileBloc>().state;

                        if (profileState.profile != null) {
                          return MyQrScreen(profile: profileState.profile!);
                        } else {
                          context.read<ProfileBloc>().add(FetchProfile());
                          return BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, state) {
                              if (state.status == ProfileStatus.initial ||
                                  state.status == ProfileStatus.updating) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state.status ==
                                  ProfileStatus.successfull) {
                                return MyQrScreen(profile: state.profile!);
                              } else if (state.status ==
                                  ProfileStatus.failure) {
                                return ErrorScreen(
                                    message: state.message ??
                                        'Profile could not be loaded.');
                              } else {
                                return const ErrorScreen(
                                    message: 'Unknown error occurred');
                              }
                            },
                          );
                        }
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
                      path: 'companyDonations',
                      builder: (context, state) {
                        final args= state.extra as CompanyHomeArguments;
                            return BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, profileState) {
                                if (profileState.status == ProfileStatus.initial ||
                                    profileState.status == ProfileStatus.updating) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (profileState.status == ProfileStatus.successfull 
                                    ) {
                                  return CompanyDonationScreen(
                                    company: args.company,
                                    profile: profileState.profile!,
                                  );
                                } else if (profileState.status == ProfileStatus.failure) {
                                  return ErrorScreen(message: profileState.message ?? 'Profile could not be loaded.');
                                } else {
                                  return const ErrorScreen(message: 'Unknown error occurred');
                                }
                              },
                            );
                          },
                        ),
                    GoRoute(
                      path: 'creditCardDetails',
                      builder: (context, state) {
                        return const CreditCardPage();
                      },
                      ),
                      GoRoute(
                        path: 'payment',
                        builder: (context, state) {
                          return const PaymentScreen();
                        },
                      ),
                      GoRoute(
                        path: 'companyRewards',
                        builder: (context, state) {
                          final args = state.extra as CompanyHomeArguments; // Expect the arguments as a custom object

                        
                            return CompanyRewardsScreen(
                              profile: args.profile,
                              company: args.company,
                            );
                          
                        },
                      ),
                      GoRoute(path: 'createCompanyReward',
                      builder: (context, state){
                        final args = state.extra as CompanyHomeArguments;
                        return CreateRewardsScreen(company: args.company, profile: args.profile);
                      })
                  ]),

            ],
          ),
          StatefulShellBranch(navigatorKey: _shellNavigatorSupport, routes: [
            GoRoute(


                path: '/allNpProjects',
                builder: (context, state) {
                  final profile = context.read<ProfileBloc>().state.profile!;
                  return AllNPProjects(profile: profile);
                },
                routes: [

                  GoRoute(path: 'allProjectsList',
                builder: (context, state) {
                  final profile = context.read<ProfileBloc>().state.profile!;
                  return AllProjectsList(profile: profile);
                }),
                  GoRoute(
                    path: 'atrocities',
                    builder: (context, state) {
                      final argument = state.extra as AtrocityListArguments;
                      return AtrocityList(profile: argument.profile);
                    },
                  ),
                  GoRoute(
                    path: 'atrocityView',
                    builder: (context, state) {
                      final argument = state.extra as AtrocityDetailArguments;

                      return AtrocityDetails(
                        atrocityId: argument.atrocity.id.toString(),
                        atrocity: argument.atrocity,
                        profile: argument.profile,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'causes',
                    builder: (context, state) {
                      final argument = state.extra as CauseListArguments;
                      return CauseList(profile: argument.profile);
                    },
                  ),
                  GoRoute(
                    path: 'causeView',
                    builder: (context, state) {

                      final argument = state.extra as CategoryArguments;

                      return CauseDetails2(
                        causeId: argument.category.id.toString(),
                        cause: argument.category,
                        profile: argument.profile,
                      );
                    },
                  ),
                  GoRoute(
                    path:'quizlist',
                    builder:(context, state){
                      final args = state.extra as QuizListScreenArguments;
                      return QuizListScreen(quizes: args.quizes, profile: args.profile);
                    }
                  ),
                  GoRoute(
                    path: 'quizpage',
                    builder: (context, state) {
                      final args = state.extra as QuizPageArguments;

                      return QuizPage(
                        quizId: args.quiz.id.toString(),
                        quiz: args.quiz, // Make sure you handle this accordingly if needed
                        profile: args.profile,
                      );
                    },
                    ),
                    GoRoute(
                      path: 'npProjectDetails',
                      builder: (context, state) {
                        final args = state.extra as NonProfitProjectDetailArguments;

                        return NonProjectDetail(
                          project: args.project,
                          profile: args.profile,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'nonprofits',
                      builder: (context, state) {
                        final profile = context.read<ProfileBloc>().state.profile!;
                        return NonProfitList(profile: profile);
                      },
                    ),
                    GoRoute(
                      path: 'nonProfitView',
                      builder: (context, state) {
                        final argument = state.extra as NonProfitDetailArguments;
                        return NonProfitDetails(
                          nonProfit: argument.nonProfit,
                          profile: argument.profile,
                        );
                      },
                    ),
                  
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _shellNavigatorRewards, routes: [
            GoRoute(
                path: '/userActionScreen',
                builder: (context, state) {
                  return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return UserActionRewardScreen(
                        profile: state.profile!,
                      );
                    },
                  );
                },
                routes: [
                  GoRoute(path: 'rewardhome',
                  builder: (context, state){
                    return BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return RewardsHomeScreen(profile: context.read<ProfileBloc>().state.profile!);
                      },
                    );
                  }),
                  GoRoute(
                    path: 'shirts',
                    builder: (context, state) {
                      final profileState = context.read<ProfileBloc>().state;

                      if (profileState.profile != null) {
                        return ShirtList(profile: profileState.profile!);
                      } else {
                        context.read<ProfileBloc>().add(const FetchProfile());
                        return BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state.status == ProfileStatus.initial ||
                                state.status == ProfileStatus.updating) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state.status ==
                                ProfileStatus.successfull) {
                              return ShirtList(profile: state.profile!);
                            } else if (state.status == ProfileStatus.failure) {
                              return ErrorScreen(
                                  message: state.message ??
                                      'Profile could not be loaded.');
                            } else {
                              return const ErrorScreen(
                                  message: 'Unknown error occurred');
                            }
                          },
                        );
                      }
                    },
                  ),
                  GoRoute(
                    path: 'ShirtDetail',
                    builder: (context, state) {
                      // Retrieve the ID from the URL

                      // Try to get the shirt object from the arguments, if passed
                      final shirtDetailArguments =
                          state.extra as ShirtDetailArguments?;
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
                  path: 'featuredShirts',
                  builder: (context, state) {
                    final profile = state.extra as Profile;

                    return FeaturedShirtScreen(
                      profile: profile,
                    );
                    },
                  ),
                  GoRoute(
                      path: 'thankyou',
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
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _shellNavigatorCommunity, routes: [
            GoRoute(
              path: '/newPosts',
              builder: (context, state) {
                final profileState = context.read<ProfileBloc>().state;

                if (profileState.profile != null) {
                  return NewPostsScreen(profile: profileState.profile!);
                } else {
                  context.read<ProfileBloc>().add(FetchProfile());
                  return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state.status == ProfileStatus.initial ||
                          state.status == ProfileStatus.updating) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.status == ProfileStatus.successfull) {
                        return NewPostsScreen(profile: state.profile!);
                      } else if (state.status == ProfileStatus.failure) {
                        return ErrorScreen(
                            message: state.message ??
                                'Profile could not be loaded.');
                      } else {
                        return const ErrorScreen(
                            message: 'Unknown error occurred');
                      }
                    },
                  );
                }
              },
              routes: [
                GoRoute(
                  path: 'companyDetails',
                  builder: (context, state) {
                    
                    final company = state.extra as ForProfitCompany; // Assuming the company object is passed via extra
                    return CompanYDetailPage(company: company);
                  },
                ),GoRoute(
                  path: 'userProfilePage',
                  builder: (context, state) {
                    final profile = state.extra as Profile;
                    return ProfilePresentationScreen(profile: profile);
                  },
                ),
                  GoRoute(
                    path: 'findfriends',
                    builder: (context, state) {
                      final profileState = context.read<ProfileBloc>().state;

                      if (profileState.profile != null) {
                        return FindFriends(profile: profileState.profile!);
                      } else {
                        context.read<ProfileBloc>().add(FetchProfile());
                        return BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state.status == ProfileStatus.initial || state.status == ProfileStatus.updating) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state.status == ProfileStatus.successfull) {
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
                    path: 'companies',
                    builder: (context, state) {
                      final argument = state.extra as CompaniesListArguments;
                      return CompaniesListScreen(
                        profile: argument.profile,
                        companies: argument.companies,
                      );
                    },
                  ),


              ]
            ),
          ])
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/login',
        builder: (context, state) => LoginPageUp(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/signup',
        builder: (context, state) => SignUpScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(message: state.error.toString()),
    // redirect: (context, state) {
    //   final validationState = context.read<ValidationCubit>().state;
    //   print(validationState);
    //   print('Redirecting to route based on validation state: $validationState');

    //   switch (validationState) {
    //     case ValidationState.intro:
    //       return '/intro';
    //     case ValidationState.login:
    //       return '/login';
    //     case ValidationState.signUpWithOutConfirmation:
    //       return '/signup';
    //     case ValidationState.signup:
    //       return '/signup';
    //     case ValidationState.confirmSignUp:
    //       return '/signup/confirm';
    //     default:
    //       return null; // No redirect if the state is not known
    //   }
    // },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyOnChange(stream);
  }

  void notifyOnChange(Stream<dynamic> stream) {
    stream.listen((event) {
      notifyListeners(); // Triggers GoRouter to refresh
    });
  }
}
