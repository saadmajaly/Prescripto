// lib/PharmacistHomeScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/Pharmacist/Home/Home.dart';
import 'package:prescripto/Pharmacist/Inventory/Inventory.dart';
import 'package:prescripto/Pharmacist/Help/Help.dart';
import 'package:prescripto/Pharmacist/FeedBack/FeedBack.dart';
import 'package:prescripto/data/database.dart';
import 'package:prescripto/AuthLogic/AuthProvider.dart';


class PrescriptoApp extends StatelessWidget {
  const PrescriptoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prescripto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.indigo.shade50,
      ),
      home: const WebLoginPage(),
    );
  }
}

class PharmacistHomeScreen extends StatefulWidget {
  const PharmacistHomeScreen({Key? key}) : super(key: key);

  @override
  State<PharmacistHomeScreen> createState() => _PharmacistHomeScreenState();
}

class _PharmacistHomeScreenState extends State<PharmacistHomeScreen> {
  int _currentIndex = 0;

  static const _screens = [
    PharmacistHome(),
    InventoryScreen(),
    HelpScreen(),
    FeedBackScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            // Wider rail
            minWidth: 120,
            backgroundColor: Colors.indigo[200],
            selectedIndex: _currentIndex,
            onDestinationSelected: _onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            // Remove indicator background
            indicatorColor: Colors.transparent,
            // Icon theming
            selectedIconTheme: IconThemeData(
              color: Colors.indigo[800],
              size: 36,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey.shade700,
              size: 32,
            ),
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(
                'assets/PrescriptoLogo.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory),
                selectedIcon: Icon(Icons.inventory_2),
                label: Text('Inventory'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.help_outline),
                selectedIcon: Icon(Icons.help),
                label: Text('Help'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.feedback),
                selectedIcon: Icon(Icons.feedback_outlined),
                label: Text('Feedback'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          // Display selected screen
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
    );
  }
}
