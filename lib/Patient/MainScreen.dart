import 'package:flutter/material.dart';
import 'package:prescripto/Patient/Home/Home.dart';

import 'Prescriptions/Prescriptions.dart';
import 'Settings/Settings.dart';
import 'Tracker/Tracker.dart';

void main(){
  runApp(MainScreen());
}
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // This will keep track of the currently selected tab.
  int _currentIndex = 0;

  // You could have different widget screens for each tab.
  final List<Widget> _screens = [
    const Home(),
    const Prescriptions(),
    const Tracker(),
    const Settings(),
  ];

  // When an item in the bottom nav is tapped, update the current index.
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show the currently selected tab's widget:
      body: _screens[_currentIndex],

      // The bottom navigation bar itself:
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,  // Highlight color
        unselectedItemColor: Colors.grey, // Unselected icon/text color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // This is just an example icon; you can change to match your design.
            icon: Icon(Icons.receipt_long),
            label: 'Prescriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}