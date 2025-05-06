// lib/Admin/AdminHomeScreen.dart

import 'package:flutter/material.dart';
import 'package:prescripto/Admin/ControlledPrescriptions.dart';
import 'package:prescripto/Admin/EmergencyAccess.dart';
import 'package:prescripto/Admin/Reports.dart';
import 'package:provider/provider.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/AuthLogic/AuthProvider.dart';
import 'package:prescripto/Admin/AdminHome.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _currentIndex = 0;

  // Your four admin panels:
  final List<Widget> _screens = const [
    AdminHomePage(),
    EmergencyAccessRequestsPage(),
    AdminReportsPage(),
    ControlledPrescriptionsPage(),
  ];

  void _onDestinationSelected(int index) {
    setState(() => _currentIndex = index);
  }

  Future<void> _logout() async {
    // Call your AuthProvider to clear session
    await context.read<AuthProvider>().logout();
    // Push login screen and remove everything else
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WebLoginPage()),
          (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
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
                Icons.admin_panel_settings,
                size: 40,
                color: Colors.indigo[800],
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.people_outline, size: 32),
                selectedIcon: Icon(Icons.people, size: 36),
                label: Text('Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.pending_actions, size: 32),
                selectedIcon: Icon(Icons.pending_actions_outlined, size: 36),
                label: Text('Requests'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart, size: 32),
                selectedIcon: Icon(Icons.bar_chart, size: 36),
                label: Text('Reports'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.medication_outlined, size: 32),
                selectedIcon: Icon(Icons.medication, size: 36),
                label: Text('Controlled prescriptions'),
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

/// Temporary placeholder for pages you haven’t built yet
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title\n(coming soon)',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
