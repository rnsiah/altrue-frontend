import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:app_links/app_links.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
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
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_event_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_completed_orders_bloc/bloc/completed_userorders_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/websocket_service/bloc/websocket_bloc.dart';
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
import 'package:lovelovelove/Presentation%20Layer/Routers/app_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/main_screen.dart';
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
        child: MultiRepositoryProvider(providers: [
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
          RepositoryProvider(create: (context) => NonprofitProjectRepository())
        ], child: const MyApp()),
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> _actions = [];

  final OrderRepository orders = OrderRepository();

  final ShirtGroupRepository shirtgroups = ShirtGroupRepository();

  final AtrocityRepository atrocity = AtrocityRepository();

  final ShirtRepository shirt = ShirtRepository();

  final NonProfitRespository nonprofit = NonProfitRespository();

  final CategoryRepository categoryRepository = CategoryRepository();

  final CompanyRepository companyRepository = CompanyRepository();

  final AllUsersRepository allUsersRepository = AllUsersRepository();

  final NonprofitProjectRepository projectsRepository =
      NonprofitProjectRepository();

  Future<void> getPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print('path:$documentsDirectory');
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> initAppLinks() async {
    AppLinks appLinks = AppLinks();

    final Uri? initialUri = await appLinks.getInitialAppLink();
    if (initialUri != null) {
      _handleDeepLink(initialUri);
    }

    final _sub = appLinks.uriLinkStream.listen((Uri uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    if (uri.toString() ==
        'https://962c-2601-2c6-500-16f0-7df8-a440-cb4c-da0e.ngrok-free.app/email-verified') {
      Navigator.pushNamed(context, '/emailVerificationScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<WebsocketBloc>(create: (context) => WebsocketBloc()),
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
                  orderRepository: orders,
                  userRepository: context.read<UserRepository>())),
          BlocProvider<AtrocityBlocBloc>(
            create: (context) => AtrocityBlocBloc(atrocityRepository: atrocity),
          ),
          BlocProvider<ShirtOrderBlocBloc>(
            create: (context) => ShirtOrderBlocBloc(),
          ),
          BlocProvider(create: (context) => FeedBloc(),),
          BlocProvider(
            create: (context) =>
                ShirtBloc(shirtRepository: context.read<ShirtRepository>()),
          ),
          BlocProvider<NonprofitBloc>(
            create: (context) => NonprofitBloc(
                nonProfitRespository: context.read<NonProfitRespository>()),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(categoryRepository: categoryRepository),
          ),
          BlocProvider<ShirtgroupBloc>(
            create: (context) =>
                ShirtgroupBloc(shirtGroupRepository: shirtgroups),
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
                    allUsersRepository: allUsersRepository,
                  )),
          BlocProvider<ShirtOrderBlocBloc>(
            create: (context) => ShirtOrderBlocBloc(),
          ),
          BlocProvider(create: (context) => CartBloc()),
          BlocProvider(
              create: (context) => NpProjectsBloc(
                  nonprofitProjectRepository: projectsRepository)),
          BlocProvider(create: (context)=> LeaderboardBloc())
        ],
        child: MaterialApp(home:
            BlocBuilder<SessionBLoc, SessionState>(builder: (context, state) {
          if (state is Authenticated) {
            final userId = state.user.altid;
            context.read<WebsocketBloc>().add(WebsocketConnect(
                url:
                    'wss://1488-2601-2c6-500-16f0-c53d-8305-278c-79f0.ngrok-free.app/ws/rewards/$userId/'));

            return BlocListener<WebsocketBloc, WebsocketState>(
              listener: (context, state) {
                if(state is WebsocketShowSnackbar){
                  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                  if(scaffoldMessenger!=null){
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message['data'].toString())
                    )
                    );
                  }
                  
                }
              },
              child: UserProfileComplete(
                user: state.user,
              ),
            );
          } else if (state is AuthenticatedWithProfile) {
            final userId = state.user.altid;
            context.read<WebsocketBloc>().add(WebsocketConnect(
                url:
                    'wss://1488-2601-2c6-500-16f0-c53d-8305-278c-79f0.ngrok-free.app/ws/rewards/$userId/'));
          }
          if (state is AuthenticatedWithProfile) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<ProfileBloc>(),
                ),
              ],
              child: BlocListener<WebsocketBloc, WebsocketState>(
                listener: (context, state) {
                 if(state is WebsocketShowSnackbar){
                  String jsonString = state.message['the message'];

                  Map<String, dynamic> messageMap = jsonDecode(jsonString);

// Access the data field
                Map<String, dynamic>? data = messageMap['data'];
                  // if(state.message[])
                  Future.delayed(Duration(seconds: 5), () {
                  
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        shape:  RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                          ),
                                           margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.height - 250,
                                            right: 20,
                                            left: 20),
                                        
                                        action: SnackBarAction(label: 'Go Check it out', onPressed: ()=>Navigator.of(context).pushNamed('/userActionScreen')),
                                        content: Text(
                                          'Action: ${data.toString()}',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                        ), 
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 6),
                                      )
      );
    });
                }},
                child: MainScreen(
                              cartBloc: context.read<CartBloc>(),
                              user: state.user,
                            ),
              ),
            );
          } else if (state is Authenticated) {
            return BlocProvider.value(
              value: context.read<WebsocketBloc>(),
              child: UserProfileComplete(
                user: state.user,
              ),
            );
          }
          return BlocProvider(
            create: (context) => ValidationCubit(
                sessionBloc: context.read<SessionBLoc>(),
                userProfileEditBloc: context.read<UserProfileEditBloc>(),
                userRepository: context.read<UserRepository>()),
            child: Builder(builder: (context) {
              return const AuthNavigator();
            }),
          );
        }), onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => makeRoute(
                context: context,
                routeName: settings.name!,
                arguments: settings.arguments),
          );
        }));
  }
}

Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // Handle notification tapped logic here
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
