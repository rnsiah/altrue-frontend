import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/posts_bloc/bloc/posts_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/atrocity_repositories.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/atrocity_details.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/cart_bottom_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/cart_icon.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/altrue_action_card.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/weekly_featured_shirts.dart';

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

  const HomePage({Key? key, required this.user, required this.cartBloc})
      : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;

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

  @override
  void initState() {
    widget.cartBloc.add(CartBeingLoaded());
    // updateProfileState(widget.profileBloc, widget.profile);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    updateCart(widget.cartBloc);

    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
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
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AtrocityDetails(
                    profile: profile, atrocity: atrocities[index]))),
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
              Colors.amber,
              const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2)
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
          child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              // onTap: () async {
              //   try {
              //     await _getImage().then((value) => context
              //         .read<ProfileBloc>()
              //         .add(ChangeProfilePicture(profilePicture: value)));
              //   } catch (e) {
              //     print(e.toString());
              //   }
              // },
              child: Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 14.0,
                  bottom: 12.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  state.profile!.profilePicture!.url,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(children: [
              Align(
                child: Text(
                  state.profile!.username!,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Altrue Balance:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text('\$${state.profile!.balance}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ]),
              ),
            ]),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.amberAccent),
              title: const Text(
                'My Profile',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              onTap: () => Navigator.of(context)
                  .pushNamed('/userProfile', arguments: state.profile),
            ),
            BlocProvider<PostsBloc>(
              create: (context) => PostsBloc(),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.amberAccent),
                title: const Text(
                  'Altrue Updates',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                onTap: () async {
                  List<Post> posts = await postRepository.fetchNewPosts();
                  Navigator.of(context).pushNamed('/newPosts',
                      arguments: NewPostsScreenArguments(
                          postList: posts, profile: state.profile!));
                },
              ),
            ),
            ListTile(
                onTap: () => Navigator.of(context)
                    .pushNamed('/usernonprofits', arguments: state.profile!),
                leading: const Icon(Icons.favorite, color: Colors.white),
                title: const Text(
                  'My Non Profits',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
            ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed('/supporters', arguments: state.profile),
              leading: const Icon(Icons.people, color: Colors.amber),
              title: const Text(
                'My Supporters',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.camera, color: Colors.white),
                title: const Text(
                  'My Altrue Code',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/myQrCode', arguments: state.profile);
                }),
            ListTile(
              leading: const Icon(Icons.store, color: Colors.white),
              title: state.profile!.hasCompany!
                  ? const Text('My Company Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600))
                  : const Text('Register A Company',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600)),
              onTap: state.profile!.hasCompany!
                  ? () async {
                      ForProfitCompany company = await companyRepository
                          .fetchCompanyById(state.profile!.comp!.id);
                      Navigator.of(context).pushNamed('/CompanyHome',
                          arguments: CompanyHomeArguments(
                              company: company, profile: state.profile!));
                    }
                  : () {
                      Navigator.of(context).pushNamed('/companyRegister',
                          arguments: state.profile);
                    },
            ),
            ListTile(
              leading: const Icon(Icons.store, color: Colors.amber),
              title: state.profile!.hasNonProfit!
                  ? const Text('My NonProfit Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600))
                  : const Text('Register A NonProfit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600)),
              onTap: () async {
                if (state.profile!.hasNonProfit == true) {
                  NonProfit nonprofit = await nonProfitRespository
                      .fetchNonProfit(state.profile!.np!.id);
                  Navigator.of(context).pushNamed('/mynonprofit',
                      arguments: MyNonProfitDetailArgments(
                          nonprofit: nonprofit, profile: state.profile!));
                } else if (state.profile!.hasNonProfit != true) {
                  Navigator.of(context).pushNamed('/nonprofitRegister',
                      arguments: state.profile);
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                context.read<SessionBLoc>().add(LoggedOut());
              },
            )
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
                                Navigator.of(context).pushNamed('/atrocities',
                                    arguments: AtrocityListArguments(
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
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/allNpProjects',
                                                              arguments: context
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
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/nonprofits',
                                                            arguments: context
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
                                          Navigator.of(context).pushNamed(
                                              '/causes',
                                              arguments: CauseListArguments(
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
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/shirts',
                                                            arguments: context
                                                                .read<
                                                                    ProfileBloc>()
                                                                .state
                                                                .profile!);
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
                                                  Navigator.of(context)
                                                      .pushNamed('/shirts');
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

                                                Navigator.of(context).pushNamed(
                                                    '/companies',
                                                    arguments:
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
                                  Navigator.of(context).pushNamed(
                                      '/findfriends',
                                      arguments: context
                                          .read<ProfileBloc>()
                                          .state
                                          .profile!);
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
                        //       onPressed: () => Navigator.of(context).pushNamed(
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
                              onPressed: () => Navigator.of(context)
                                  .pushNamed('/creditCardDetails')),
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
