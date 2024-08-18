import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:app_links/app_links.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
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
import 'package:path_provider/path_provider.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
                  nonprofitProjectRepository: projectsRepository))
        ],
        child: MaterialApp(home:
            BlocBuilder<SessionBLoc, SessionState>(builder: (context, state) {
          if (state is AuthenticatedWithProfile) {
            return BlocProvider.value(
              value: context.read<ProfileBloc>(),
              child: HomePage(
                cartBloc: context.read<CartBloc>(),
                user: state.user,
              ),
            );
          } else if (state is Authenticated) {
            return UserProfileComplete(
              user: state.user,
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
