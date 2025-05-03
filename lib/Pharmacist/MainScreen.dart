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

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(AppDatabase()),
      child: const PrescriptoApp(),
    ),
  );
}

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

  final List<Widget> _screens = const [
    PharmacistHome(),
    InventoryScreen(),
    HelpScreen(),
    FeedBackScreen(),
  ];

  void _onDestinationSelected(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.indigo[200],
            selectedIndex: _currentIndex,
            onDestinationSelected: _onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(
                Icons.medical_services,
                size: 40,
                color: Colors.indigo[800],
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home, size: 32),
                selectedIcon: Icon(Icons.home_filled, size: 36),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory, size: 32),
                selectedIcon: Icon(Icons.inventory_2, size: 36),
                label: Text('Inventory'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.help_outline, size: 32),
                selectedIcon: Icon(Icons.help, size: 36),
                label: Text('Help'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.feedback, size: 32),
                selectedIcon: Icon(Icons.feedback_outlined, size: 36),
                label: Text('Feedback'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
    );
  }
}
