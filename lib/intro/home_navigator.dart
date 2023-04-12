// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:revivetest2/home/graph.dart';
import 'package:revivetest2/home/home.dart';
import 'package:revivetest2/home/sensor.dart';
import 'package:revivetest2/home/settings.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      UserHome(),
      UserSensor(),
      UserGraph(),
      UserSettings(),
    ];
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          color: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 500),
          tabBackgroundColor: Colors.grey.shade800,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.sensors_rounded,
              text: 'Sensors',
            ),
            GButton(
              icon: Icons.monitor_heart_rounded,
              text: 'Graphs',
            ),
            GButton(
              icon: Icons.person,
              text: 'Account',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: _navigateBottomBar,
        ),
      ),
    );
  }
}
