import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/find_friends_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/new_posts.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_project_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/np_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_actions_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  final CartBloc cartBloc;
  final ProfileBloc profileBloc;

  MainScreen(
      {required this.user, required this.cartBloc, required this.profileBloc});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    widget.profileBloc.add(FetchProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        cartBloc: widget.cartBloc,
        user: widget.user,
      ),
      BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profile != null) {
            return AllNPProjects(profile: state.profile!);
          }
          return HomePage(
            cartBloc: widget.cartBloc,
            user: widget.user,
          );
        },
      ),
      BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profile != null) {
            return UserActionRewardScreen(
              profile: state.profile!,
            );
          }
          return HomePage(
            cartBloc: widget.cartBloc,
            user: widget.user,
          );
        },
      ),
      BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if(state.profile!=null){
            return NewPostsScreen(profile: state.profile!);
          }
          return HomePage(
            cartBloc: widget.cartBloc,
            user: widget.user,
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          CustomNavItem(icon: Icons.home, label: 'home', color: Colors.amber),
          CustomNavItem(
              icon: Icons.present_to_all, label: 'home', color: Colors.amber),
          CustomNavItem(
              icon: Icons.monetization_on, label: 'home', color: Colors.amber),
          CustomNavItem(icon: Icons.home, label: 'home', color: Colors.amber),
        ],
        color: Colors.transparent,
        buttonBackgroundColor: Colors.grey[900],
        backgroundColor: Colors.transparent,
        height: 60.0,

        animationDuration:
            Duration(milliseconds: 400), // Duration of the animation
        animationCurve: Curves.easeInOut,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const CustomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: color),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
