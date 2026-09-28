import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/altrue_statistics_bloc/bloc/altrue_statistics_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/feed_bloc/bloc/feed_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/leaderboard_bloc/bloc/leaderboard_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/np_projects_bloc/bloc/np_projects_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/payment_bloc/bloc/payment_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/promoted_actions_bloc/bloc/promoted_actions_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_event_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_completed_orders_bloc/bloc/completed_userorders_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/websocket_bloc/bloc/web_socket_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/notification_service.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/all_users_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/atrocity_repositories.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/category_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonprofit_proj_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/order_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Forms/user_login_form.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/AppNavigation.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/main_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/signup_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/Intro_Slider/intro_slider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'Data Layer/Blocs/order_status_bloc/bloc/order_status_bloc.dart';
import 'Data Layer/Blocs/shirt_group_bloc/bloc/shirtgroup_bloc.dart';
import 'Data Layer/Repositories/shirt_groups_repository.dart';
import 'Presentation Layer/Screens/userProfile_fillScreen.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  // ignore: override_on_non_overriding_member
  void onNewEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('an event happened in $bloc the event is $event');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("this $bloc has been created");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initialize();
  await requestIOSPermissions();

  Stripe.publishableKey = 'pk_test_osCkw6g4MDSTjwXhs0RzOwL0';
  Bloc.observer = SimpleBlocDelegate();
  runApp(RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider<SessionBLoc>(
        create: (context) {
          final userRepository = context.read<UserRepository>();
          return SessionBLoc(userRepository: userRepository)..add(Apploaded());
        },
        child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => ShirtRepository(),
              ),
              RepositoryProvider(
                create: (context) => NonProfitRespository(),
              ),
              RepositoryProvider(
                create: (context) => AtrocityRepository(),
              ),
              RepositoryProvider(
                create: (context) => OrderRepository(),
              ),
              RepositoryProvider(create: (context) => CategoryRepository()),
              RepositoryProvider(create: (context) => ShirtGroupRepository()),
              RepositoryProvider(create: (context) => CompanyRepository()),
              RepositoryProvider(create: (context) => AllUsersRepository()),
              RepositoryProvider(
                  create: (context) => NonprofitProjectRepository())
            ],
            child: BlocProvider<SessionBLoc>(
              create: (context) {
                final userRepository = context.read<UserRepository>();
                return SessionBLoc(userRepository: userRepository)
                  ..add(Apploaded());
              },
              child: MyApp(),
            )),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // List<dynamic> _actions = [];

  Future<void> getPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print('path:$documentsDirectory');
  }

  // Future<void> initAppLinks(BuildContext context) async {
  //   AppLinks appLinks = AppLinks();

  //   final Uri? initialUri = await appLinks.getInitialAppLink();
  //   if (initialUri != null) {
  //     _handleDeepLink(initialUri);
  //   }

  //   final _sub = appLinks.uriLinkStream.listen((Uri uri) {
  //     if (uri != null) {
  //       _handleDeepLink( uri);
  //     }
  //   });
  // }

  // void _handleDeepLink(Uri uri ) {
  //   BuildContext context;
  //   if (uri.toString() ==
  //       'https://962c-2601-2c6-500-16f0-7df8-a440-cb4c-da0e.ngrok-free.app/email-verified') {
  //     Navigator.pushNamed( contet ,'/emailVerificationScreen');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<WebSocketBloc>(create: (context) => WebSocketBloc()),
          BlocProvider<PaymentBlocBloc>(
            create: (context) => PaymentBlocBloc(),
          ),
          BlocProvider<OrderStatusBloc>(
            create: (context) => OrderStatusBloc(),
          ),
          BlocProvider.value(
            value: context.read<SessionBLoc>(),
          ),
          BlocProvider<CompletedUserordersBloc>(
              create: (context) => CompletedUserordersBloc(
                  orderRepository: context.read<OrderRepository>(),
                  userRepository: context.read<UserRepository>())),
          BlocProvider<AtrocityBlocBloc>(
            create: (context) => AtrocityBlocBloc(
                atrocityRepository: context.read<AtrocityRepository>()),
          ),
          BlocProvider<ShirtOrderBlocBloc>(
            create: (context) => ShirtOrderBlocBloc(),
          ),
          BlocProvider(
            create: (context) => FeedBloc()..add(FetchFeed()),
          ),
          BlocProvider(
            create: (context) =>
                ShirtBloc(shirtRepository: context.read<ShirtRepository>()),
          ),
          BlocProvider<PromotedActionsBloc>(
            create: (context) =>
                PromotedActionsBloc()..add(FetchPromotedActions()),
          ),
          BlocProvider<NonprofitBloc>(
            create: (context) => NonprofitBloc(
                nonProfitRespository: context.read<NonProfitRespository>()),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
                categoryRepository: context.read<CategoryRepository>())
              ..add(FetchCategory()),
          ),
          BlocProvider<AltrueStatisticsBloc>(
            create: (context) =>
                AltrueStatisticsBloc()..add(FetchAltrueStatistics()),
          ),
          BlocProvider<ShirtgroupBloc>(
            create: (context) => ShirtgroupBloc(
                shirtGroupRepository: context.read<ShirtGroupRepository>()),
          ),
          BlocProvider<UserProfileEditBloc>(
            create: (context) =>
                UserProfileEditBloc(sessionBLoc: context.read<SessionBLoc>()),
          ),
          BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                    userRepository: context.read<UserRepository>(),
                  )..add(const FetchProfile())),
          BlocProvider<CompanyListBloc>(create: (context) => CompanyListBloc()),
          BlocProvider<AllUsersBloc>(
              create: (context) => AllUsersBloc(
                    allUsersRepository: context.read<AllUsersRepository>(),
                  )),
          BlocProvider<ShirtOrderBlocBloc>(
            create: (context) => ShirtOrderBlocBloc(),
          ),
          BlocProvider(create: (context) => CartBloc()),
          BlocProvider(
              create: (context) => NpProjectsBloc(
                  nonprofitProjectRepository:
                      context.read<NonprofitProjectRepository>())),
          BlocProvider(
              create: (context) => LeaderboardBloc()..add(FetchLeaderboard())),
        ],
        child: BlocProvider(
          create: (context) => ValidationCubit(
              userRepository: context.read<UserRepository>(),
              sessionBloc: context.read<SessionBLoc>(),
              userProfileEditBloc: context.read<UserProfileEditBloc>()),
          child: MaterialApp.router(
            routerDelegate: AppNavigation.router.routerDelegate,
            routeInformationParser: AppNavigation.router.routeInformationParser,
            routeInformationProvider:
                AppNavigation.router.routeInformationProvider,
          ),
        ));
  }
}

Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // Handle notification tapped logic hererr
}

Future<void> requestIOSPermissions() async {
  final IOSFlutterLocalNotificationsPlugin? iOSPlatformSpecifics =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();

  if (iOSPlatformSpecifics != null) {
    await iOSPlatformSpecifics.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
