import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/altrue_statistics_bloc/bloc/altrue_statistics_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/feed_bloc/bloc/feed_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/posts_bloc/bloc/posts_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Data%20Providers/notification_service.dart';
import 'package:lovelovelove/Data%20Layer/Models/altrue_statistics_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/atrocity_repositories.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/new_posts.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/cart_bottom_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/cart_icon.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/altrue_action_card.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/payment_sheet_profile_card_widget.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/weekly_featured_shirts.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Data Layer/Blocs/np_projects_bloc/bloc/np_projects_bloc.dart';
import '../../Data Layer/Blocs/session_event_bloc.dart';
import '../../Data Layer/Models/company_model.dart';
import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/post_model.dart';
import '../../Data Layer/Repositories/company_repository.dart';
import '../../Data Layer/Repositories/new_posts_repository.dart';
import '../../Data Layer/Repositories/nonProfit_repository.dart';

class HomePage extends StatefulWidget {
  final User user;
  final CartBloc cartBloc;

  const HomePage({Key? key, required this.user, required this.cartBloc, })
      : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  
  NotificationService notificationService = NotificationService();
  // StompClient? _stompClient;
  
  // late WebSocketChannel _channel;

  final PostRepository postRepository = PostRepository();
  final NonProfitRespository nonProfitRespository = NonProfitRespository();

  AtrocityRepository atrocityRepository = AtrocityRepository();
  ShirtRepository shirtRepository = ShirtRepository();
  final CompanyRepository companyRepository = CompanyRepository();

  final _advancedDrawerController = AdvancedDrawerController();
  // Future<List<Atrocity>> getAtrocities() async {
  //   List<Atrocity> atr = [];
  //   List<Atrocity> allAtro = await atrocityRepository.getFeaturedAtrocities();
  //   for (Atrocity atro in allAtro) {
  //     atr.add(atro);
  //   }
  //   return atr;
  // }
  // void showCart(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (_) {
  //         return DraggableScrollableSheet(builder: (_, controller) {});
  //       });
  // }


  // void connectToWebSocket() async {
  //       _stompClient = StompClient(
  //           config: StompConfig(
  //               url: 'wss://3e2f-2601-2c6-500-16f0-4d5f-6af6-5b47-3b45.ngrok-free.app/ws/rewards/',
  //               onConnect: (frame) {
  //                   print('Connected to WebSocket');
  //                   _stompClient?.subscribe(destination: 'queue/rewards', callback: (message) {
  //                       final data = jsonDecode(message.body!);
  //                       print('Received actions: $data');
  //                       setState(() {
                           
  //                           print('it is finally working');
                            
  //                       });
  //                   });
  //               },
  //           ),
  //       );
  //        _stompClient?.activate();
  //   }
  

  Future<List<Shirt>> getFeaturedShirts() async {
    List<Shirt> shir = [];
    List<Shirt> theshirts = await shirtRepository.featuredShirts();
    for (Shirt shirt in theshirts) {
      shir.add(shirt);
    }
    return shir;
  }



  Future<void> updateCart(CartBloc cartBloc) async {
    cartBloc.add(CartBeingLoaded());
  }
   void testNotification() {
       NotificationService().showNotification('Test Title', 'Test Body');
}

  @override
  void initState() {
    // _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8000/ws/socket-server/'));
    widget.cartBloc.add(CartBeingLoaded());
   
    
    // updateProfileState(widget.profileBloc, widget.profile);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    updateCart(widget.cartBloc);

    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    testNotification();


    
    // channel.stream.listen(
    //   (message) {
    //     print('Received message: $message'); // Debug output
    //     setState(() {});
    //   },
    //   onError: (error) {
    //     print('WebSocket Error: $error'); // Debug output for errors
    //   },
    //   onDone: () {
    //     print('WebSocket closed'); // Debug output for connection close
    //   },
    // );

    // connectToWebSocket();

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }


ListTile _buildDrawerItem({
  required IconData icon,
  required String text,
  required Color color,
  required BuildContext context,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    onTap: onTap,
  );
}


  AnimationController? _animationController;

  _shirtSelector(int index, List<Atrocity> atrocities, Profile profile) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.3) + 0.6).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 350,
            width: Curves.easeInOut.transform(value) * 450,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
            context.go(
          '/allNpProjects/atrocityView/',
          extra: AtrocityDetailArguments(profile: profile, atrocity: atrocities[index],)
        );
        } ,
        child: Stack(
          children: [
            Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 4),
                          blurRadius: 6)
                    ]),
                child: Center(
                  child: Hero(
                      tag: atrocities[index].imageUrl!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: NetworkImage(atrocities[index].imageUrl!),
                          height: 220,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
              ),
            ),
            Positioned(
                left: 30,
                bottom: 40,
                child: Container(
                  color: Colors.black.withOpacity(.25),
                  width: 240,
                  child: Text(
                    atrocities[index].title.toUpperCase(),
                    softWrap: true,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }

 


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (_, state) {
        if (state.profile == null) {
          return Center(
            child: Container(
              child: const Text(
                'Loading',
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
            ),
          );
        }
        return openHomePageDrawer(state, context);
      },
    );
  }

  AdvancedDrawer openHomePageDrawer(ProfileState state, BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.amber.shade600,
              const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7)
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openRatio: .77,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: BorderRadius.all(Radius.circular(16))),
      drawer: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
               Container(
                padding: EdgeInsets.symmetric(vertical: 20),
               child: Column(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(state.profile!.profilePicture!.url),
                    foregroundImage:  NetworkImage(state.profile!.profilePicture!.url),
                    backgroundColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.amber.shade300, Colors.amber.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(height: 12),
                  Text(
                    state.profile!.username!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Altrue Balance: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          )),
                      Text('\$${state.profile!.balance}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
                
               ),
               ),
               Divider(color: Colors.white38,),
                _buildDrawerItem(
              icon: Icons.person,
              text: 'My Profile',
              color: Colors.amberAccent,
              context: context,
              onTap: () => context.go('/userprofile')
            ),
               
            
                BlocProvider.value(
                  value: context.read<FeedBloc>(),
                  child: _buildDrawerItem(icon: Icons.feed_outlined, text: 'My Feed', color: Colors.white, context: context, onTap: () async {
                      context.read<FeedBloc>().add(FetchFeed());
                      context.go('/newPosts',extra: state.profile
                        );
                    },)
                ),
                _buildDrawerItem(icon: Icons.house_outlined, text: 'My Non Profits', color: Colors.white, context: context, onTap: ()=> context.go('/home/usernonprofits')),
                
                _buildDrawerItem(icon: Icons.people_alt_outlined, text: 'My Supporters', color: Colors.white, context: context, onTap: ()=> context.go('/userProfile/supporters', extra: state.profile),),
                
                _buildDrawerItem(icon: Icons.qr_code, text: 'My Altrue Code', color: Colors.white, context: context, onTap: () {
                     context.go('/userProfile/myQrCode');
                    }),
              
                _buildDrawerItem(
              icon: Icons.store,
              text: state.profile!.hasCompany!
                  ? 'My Company Details'
                  : 'Register A Company',
              color: Colors.white,
              context: context,
              onTap: state.profile!.hasCompany!
                      ? () async {
                          ForProfitCompany company = await companyRepository
                              .fetchCompanyById(state.profile!.comp!.id);
                          context.go('/userProfile/CompanyHome',
                              extra: CompanyHomeArguments(
                                  company: company, profile: state.profile!));
                        }
                      : () {
                          context.go('/userProfile/companyRegister',
                              extra: state.profile);
                        },
            ),
               
                      _buildDrawerItem(
                    icon: Icons.store,
                    text: state.profile!.hasNonProfit!
                        ? 'My NonProfit Details'
                        : 'Register A NonProfit',
                    color: Colors.white,
                    context: context,
                    onTap: () async {
                    if (state.profile!.hasNonProfit == true) {
                      NonProfit nonprofit = await nonProfitRespository
                          .fetchNonProfit(state.profile!.np!.id);
                      context.go('/mynonprofit',
                          extra: MyNonProfitDetailArgments(
                              nonprofit: nonprofit, profile: state.profile!));
                    } else if (state.profile!.hasNonProfit != true) {
                      context.go('/nonprofitRegister',
                          extra: state.profile);
                    }
                  },
                  ),
                
                const Divider(color: Colors.white38),
                  _buildDrawerItem(
                      icon: Icons.logout_rounded,
                      text: 'Log Out',
                      color: Colors.redAccent,
                      context: context,
                      onTap: () {
                        context.read<SessionBLoc>().add(LoggedOut());
                      },
                    ),
                
              ],
            ),
          )),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: widget.cartBloc,
          ),
        ],
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Scaffold(
              // onDrawerChanged: (isOpened) {},
              backgroundColor: Colors.grey[900],
              // drawer: ProfileDrawer(profile: widget.profile),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: (_handleMenuButtonPressed),
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable: _advancedDrawerController,
                      builder: (_, value, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            color: Colors.white,
                            value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible),
                          ),
                        );
                      }),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                elevation: 0,
                title: Stack(children: [
                  const Image(
                    image: AssetImage('images/Altrue Logo White.png'),
                  ),
                  Positioned(
                      right: -22,
                      bottom: -12,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.orange,
                          ))),
                ]),
                actions: <Widget>[
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return CartIcon(
                        notificationCount: state.status == CartStatus.loaded
                            ? state.cart.length
                            : 0,
                        text: 'cart',
                        iconData: Icons.shopping_cart,
                        onTap: () async {
                          showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0)),
                              ),
                              builder: (_) {
                                return DraggableScrollableSheet(
                                  expand: false,
                                  maxChildSize: .65,
                                  minChildSize: .5,
                                  initialChildSize: .6,
                                  builder: (_, controller) => CartBottomScreen(
                                    controller: controller,
                                    cartList: state.cart,
                                  ),
                                );
                              });
                        },
                      );
                    },
                  )
                ],
              ),
              body: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  // if (state.status != ProfileStatus.successfull ||
                  //     state.profile == null) {
                  //   return CircularProgressIndicator();
                  // }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProfileBloc>().add(const FetchProfile());
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Welcome ${state.profile!.username}', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w600),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfilePaymentCard(profile: state.profile!, heightFactor: .18,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8, left: 15.0),
                              child: Text(
                                'Ongoing Atrocities Of The Week+',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<CategoryBloc>()
                                    .add(FetchCategory());
                                context.go('/allNpProjects/atrocities',
                                    extra: AtrocityListArguments(
                                        profile: context
                                            .read<ProfileBloc>()
                                            .state
                                            .profile!));
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 8, right: 15.0),
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            // // ElevatedButton(
                            // //     style: ElevatedButton.styleFrom(),
                            // //     child: Text(
                            // //       'All Atrocities',
                            // //       style: TextStyle(fontSize: 14, color: Colors.white),
                            // //     ),
                            //    ),
                          ],
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            // if (state.status != ProfileStatus.successfull ||
                            //     state.profile == null) {
                            //   return CircularProgressIndicator();
                            // }
                            return BlocBuilder<AtrocityBlocBloc,
                                AtrocityBlocState>(builder: (context, state) {
                              return SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: state.featuredAtrocities.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _shirtSelector(
                                          index,
                                          state.featuredAtrocities,
                                          context
                                              .read<ProfileBloc>()
                                              .state
                                              .profile!);
                                    }),
                              );
                            });
                          },
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            // if (state.status != ProfileStatus.successfull ||
                            //     state.profile == null) {
                            //   return CircularProgressIndicator();
                            // }
                            return BlocBuilder<ShirtBloc, ShirtState>(
                                builder: (context, state) {
                              return FeaturedShirts(
                                  profile: context
                                      .read<ProfileBloc>()
                                      .state
                                      .profile!,
                                  shirtlist: state.featuredShirts,
                                  title: "Altrue's collection of the week",
                                  imageHeight: 200,
                                  imageWidth: 170);
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Container(
                            child: Column(
                              children: [
                                BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, state) {
                                    // if (state.status !=
                                    //         ProfileStatus.successfull ||
                                    //     state.profile == null) {
                                    //   return CircularProgressIndicator();
                                    // }
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BlocBuilder<NpProjectsBloc,
                                                  NpProjectsState>(
                                              builder: (context, state) {
                                            if (state.status ==
                                                    NonProfitProjectListStatus
                                                        .initial ||
                                                state.status ==
                                                    NonProfitProjectListStatus
                                                        .loading) {
                                              return const CircularProgressIndicator(
                                                color: Colors.amber,
                                              );
                                            } else if (state.status ==
                                                NonProfitProjectListStatus
                                                    .success) {
                                              return Expanded(
                                                child: MaterialButton(
                                                    color: Colors.amber,
                                                    child: Text(
                                                      'projects: ${state.projects.length.toString()}',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {
                                                     context.go(
                                                              '/allNpProjects/allProjectsList',
                                                              extra: context
                                                                  .read<
                                                                      ProfileBloc>()
                                                                  .state
                                                                  .profile!);
                                                    }),
                                              );
                                            }
                                            return MaterialButton(
                                                onPressed: () {},
                                                child:
                                                    const Text('not loaded'));
                                          }),
                                          BlocBuilder<NonprofitBloc,
                                              NonprofitState>(
                                            builder: (context, state) {
                                              return Expanded(
                                                child: MaterialButton(
                                                  color: Colors.black,
                                                  child: Text(
                                                    state.nonprofitList.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<CategoryBloc>()
                                                        .add(FetchCategory());
                                                   context.go(
                                                            '/allNpProjects/nonprofits',
                                                            extra: context
                                                                .read<
                                                                    ProfileBloc>()
                                                                .state
                                                                .profile!);
                                                    // context.read<CategoryBloc>().add(FetchCategory());
                                                    // context.read<NonprofitBloc>().add(FetchNonProfitList());
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        color: Colors.black,
                                        onPressed: () {
                                          context
                                              .read<CategoryBloc>()
                                              .add(FetchCategory());
                                          context.go(
                                              '/allNpProjects/causes',
                                              extra: CauseListArguments(
                                                  profile: context
                                                      .read<ProfileBloc>()
                                                      .state
                                                      .profile!));
                                        },
                                        child: const Text(
                                          'Causes',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    BlocBuilder<ProfileBloc, ProfileState>(
                                      builder: (context, state) {
                                        // if (state.status !=
                                        //         ProfileStatus.successfull ||
                                        //     state.profile == null) {
                                        //   return CircularProgressIndicator();
                                        // }
                                        return Expanded(
                                          child: BlocBuilder<ShirtBloc,
                                              ShirtState>(
                                            builder: (context, state) {
                                              if (state.status ==
                                                  ShirtStatus.successful) {
                                                return MaterialButton(
                                                  color: Colors.green,
                                                  child: const Text(
                                                    'Shirts',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<CategoryBloc>()
                                                        .add(FetchCategory());
                                                    context.go('/userActionScreen/shirts');
                                                    // context.read<ShirtBloc>().add(FetchShirts());
                                                  },
                                                );
                                              }
                                              return MaterialButton(
                                                color: Colors.red,
                                                child: const Text(
                                                  'Shirts',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                 context.go('/userActionScreen/shirts', extra: Shirt);
                                                  // context.read<ShirtBloc>().add(FetchShirts());
                                                  // context.read<CategoryBloc>().add(FetchCategory());
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    BlocBuilder<ProfileBloc, ProfileState>(
                                      builder: (context, state) {
                                        // if (state.status !=
                                        //         ProfileStatus.successfull ||
                                        //     state.profile == null) {
                                        //   return CircularProgressIndicator();
                                        // }
                                        return Expanded(child: BlocBuilder<
                                                CompanyListBloc,
                                                CompanyListState>(
                                            builder: (context, state) {
                                          if (state.status ==
                                              CompanyListStatus.failed) {
                                            return MaterialButton(
                                              color: Colors.red,
                                              child: const Text('failed'),
                                              onPressed: () {},
                                            );
                                          }
                                          return MaterialButton(
                                              color: Colors.black,
                                              onPressed: () {
                                                context
                                                    .read<CategoryBloc>()
                                                    .add(FetchCategory());

                                                context
                                                    .read<CompanyListBloc>()
                                                    .add(FetchCompanyList(
                                                        user: widget.user));

                                                context.go(
                                                    '/newPosts/companies',
                                                    extra:
                                                        CompaniesListArguments(
                                                            companies:
                                                                state.companies,
                                                            profile: context
                                                                .read<
                                                                    ProfileBloc>()
                                                                .state
                                                                .profile!));
                                              },
                                              child: Text(
                                                  state.companies.length
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white)));
                                        }));
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            // if (state.status != ProfileStatus.successfull ||
                            //     state.profile == null) {
                            //   return CircularProgressIndicator();
                            // }
                            return SizedBox(
                              height: 130,
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: context
                                      .read<ProfileBloc>()
                                      .state
                                      .profile!
                                      .requirementsForNextLevel!
                                      .length,
                                  itemBuilder: (context, index) =>
                                      AltrueActionCard(
                                        levelNumber: context
                                                .read<ProfileBloc>()
                                                .state
                                                .profile!
                                                .altrueLevel!
                                                .levelNumber +
                                            1,
                                        action: context
                                            .read<ProfileBloc>()
                                            .state
                                            .profile!
                                            .requirementsForNextLevel![index],
                                      )),
                            );
                          },
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state.status != ProfileStatus.successfull) {
                              return CircularProgressIndicator();
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: MaterialButton(
                                color: Colors.black,
                                onPressed: () {
                                  context
                                      .read<AllUsersBloc>()
                                      .add(FetchFindUserList());
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>FindFriends(profile:state.profile!))
                                  );
                                },
                                child: const Text(
                                  'Find Friends',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 8.0, right: 8),
                        //   child: MaterialButton(
                        //       color: Colors.black,
                        //       child: const Text('User DashBoard',
                        //           style: TextStyle(color: Colors.white)),
                        //       onPressed: () => context.go(
                        //           '/companyDashboard',
                        //           arguments:
                        //               DashBoardScreenArguments(profile: widget.profile))),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: MaterialButton(
                              color: Colors.black,
                              child: const Text(
                                'Payment Details',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () =>context.go('/userProfile/creditCardDetails')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: MaterialButton(
                              color: Colors.black,
                              child: const Text(
                                'Example',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => Navigator.of(context)
                                  .pushNamed('/exampledonation')),
                        ),
                        ElevatedButton(onPressed: (){
                          context.go('/testscreen', extra: widget.user);
                        }, child: const Text('test screen')),
                        ElevatedButton(onPressed: (){
                          context.go('/leaderboard');
                        }, child: const Text('LeaderBoard')),
                      ElevatedButton(onPressed: (){
                        context.read<AltrueStatisticsBloc>().add(FetchAltrueStatistics());
                        context.go('/userActionScreen/rewardhome');
                      }, child: const Text('rewardHome'))
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
