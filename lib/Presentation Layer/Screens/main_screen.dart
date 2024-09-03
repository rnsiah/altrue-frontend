import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/home_screen.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/nonprofit_project_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/np_projects_list.dart';
import 'package:lovelovelove/Presentation%20Layer/Screens/user_profile_screen.dart';


class MainScreen extends StatefulWidget {
  final User user;
  final CartBloc cartBloc;

   MainScreen({required this.user, required this.cartBloc,});


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
    HomePage(cartBloc: widget.cartBloc, user: widget.user,),
    HomePage(cartBloc: widget.cartBloc, user: widget.user,),
    HomePage(cartBloc: widget.cartBloc, user: widget.user,),
    HomePage(cartBloc: widget.cartBloc, user: widget.user,),
  ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.amber),
          Icon(Icons.money, size: 30, color: Colors.amber),
          
          Icon(Icons.heat_pump_rounded, size: 30, color: Colors.amber),
          Icon(Icons.person, size: 30, color: Colors.amber),
          
        ],
        color: Colors.transparent,
        buttonBackgroundColor: Colors.amber,
        backgroundColor: Colors.transparent,
        height: 60.0,
        animationDuration: Duration(milliseconds: 300),
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