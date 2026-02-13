import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/feed_bloc/bloc/feed_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_event_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/new_posts.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_project_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/np_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_actions_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/cart_bottom_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/cart_icon.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late int selectedIndex;
  final _advancedDrawerController = AdvancedDrawerController();

    final NonProfitRespository nonProfitRespository = NonProfitRespository();
    final CompanyRepository companyRepository = CompanyRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.navigationShell.currentIndex;
  }

  

  void _goBranch(int index) {

      // setState(() {
      //   selectedIndex = index; 
      // });
    print({'index':index});
    // selectedIndex = index;
    
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
       
    
     
  }

  @override
  Widget build(BuildContext context) {

    final List<IconData> _icons = [
       Icons.home,
    Icons.present_to_all,
    Icons.monetization_on,
    Icons.home, // Adjust as needed
    Icons.person_2,
    ];

     final List<String> _labels = [
    'home',
    'Support',
    'Rewards',
    'home', // Adjust as needed
    'Altrue',
  ];
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


    setState(() {
    });
    return BlocBuilder<SessionBLoc, SessionState>(
      builder: (context, state) {
        if(state is !AuthenticatedWithProfile){
          return Scaffold(backgroundColor: Colors.transparent,
          body: SizedBox.expand(child: widget.navigationShell,),);
        }
        return AdvancedDrawer(
          backdrop: Container(width: double.infinity,
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
                
                _buildDrawerItem(icon: Icons.people_alt_outlined, text: 'My Supporters', color: Colors.white, context: context, onTap: ()=> context.go('/userprofile/supporters', extra: state.profile),),
                
                _buildDrawerItem(icon: Icons.qr_code, text: 'My Altrue Code', color: Colors.white, context: context, onTap: () {
                     context.go('/userprofile/myQrCode');
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
          child: Scaffold(
            backgroundColor: Colors.grey[900],
            body: SizedBox.expand(
                child: widget
                    .navigationShell), // This is the current content, determined by the selected tab
            bottomNavigationBar: CurvedNavigationBar(
              color: Colors.grey[900]!,
              buttonBackgroundColor: Colors.grey[900],
              backgroundColor: Colors.grey[900]!,
              animationDuration:
                  const Duration(milliseconds: 400), // Duration of the animation
              animationCurve: Curves.easeInOut,
          
              index: selectedIndex,
              onTap: (index) {
            //     setState(() {
            //   selectedIndex = index;
            // });
                _goBranch(index);
                selectedIndex = index;
              print({"selectedIndex":selectedIndex});
                
              },
              items:List.generate(_icons.length,
              (index)=>CustomNavItem(icon: _icons[index], label:_labels[index], color: Colors.white, isSelected: selectedIndex ==index,))
              //  const [
                // CustomNavItem(
                //     icon: Icons.home, label: 'home', color: Colors.white),
                // CustomNavItem(
                //     icon: Icons.present_to_all,
                //     label: 'Support',
                //     color: Colors.white),
                // CustomNavItem(
                //     icon: Icons.monetization_on,
                //     label: 'Rewards',
                //     color: Colors.white),dveecfrf0-=
                // CustomNavItem(
                //     icon: Icons.home, label: 'home', color: Colors.white),
                // CustomNavItem(
                //     icon: Icons.person_2, label: 'Altrue', color: Colors.white)
                // Add more items if needed
              // ],
            ),
            appBar: builAppBar(),
          ),
        );
      },
    );
  }
  AppBar builAppBar() {
    return AppBar(
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
                          useSafeArea: true,
                          backgroundColor: Colors.grey[900],
                            isDismissible: true,
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                            builder: (_) {
                              return DraggableScrollableSheet(
                                snap: true,
                                expand: true,
                                maxChildSize: .85,
                                minChildSize: .75,
                                initialChildSize: .75,
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
            );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
  
}

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;

  const CustomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
     this.isSelected=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: isSelected? Colors.amber: color),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
  
}
