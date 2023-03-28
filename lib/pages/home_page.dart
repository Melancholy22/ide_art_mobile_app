import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ide_art_mobile_app/features/pages/UserCreate.dart';
import 'package:ide_art_mobile_app/features/pages/UserHome.dart';
import 'package:ide_art_mobile_app/features/pages/UserNotifis.dart';
import 'package:ide_art_mobile_app/features/pages/UserProfile.dart';
import 'package:ide_art_mobile_app/features/pages/UserSearch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    UserHome(),
    UserSearch(),
    UserCreate(),
    UserNotifs(),
    UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
              gap: 0,
              iconSize: 24,
              backgroundColor: Colors.blue,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Color.fromARGB(255, 67, 170, 255),
              padding: EdgeInsets.all(16),
              onTabChange: (index) {
                _navigateBottomNavBar(index);
              },
              tabs: [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.search, text: 'Search'),
                GButton(icon: Icons.mode, text: 'Create'),
                GButton(icon: Icons.circle_notifications, text: 'Notifs'),
                GButton(icon: Icons.person, text: 'Me'),
              ]),
        ),
      ),
    );
  }
}
