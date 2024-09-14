import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_cubit.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/session_state.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/new_posts.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_project_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/np_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_actions_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';

class MainScreen extends StatefulWidget {
  StatefulNavigationShell navigationShell;
  MainScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int selectedIndex;
  

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


    setState(() {
    });
    return BlocBuilder<SessionBLoc, SessionState>(
      builder: (context, state) {
        if(state is !AuthenticatedWithProfile){
          return Scaffold(backgroundColor: Colors.transparent,
          body: SizedBox.expand(child: widget.navigationShell,),);
        }
        return Scaffold(
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
        );
      },
    );
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
