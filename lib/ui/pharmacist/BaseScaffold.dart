import 'package:flutter/material.dart';

class PharmacistScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const PharmacistScaffold({
    super.key,
    required this.body,
    this.title = 'Pharmacist Portal',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Replace with your pharmacist logo asset
            Image.asset('assets/pharmacist_logo.png', height: 40),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
      drawer: PharmacistNavigationDrawer(),
      body: body,
    );
  }
}

class PharmacistNavigationDrawer extends StatelessWidget {
  const PharmacistNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Pharmacist Menu', style: TextStyle(fontSize: 20)),
          ),
          ListTile(
            title: const Text('Pending Prescriptions'),
            onTap: () {
              Navigator.pushNamed(context, '/pendingPrescriptions');
            },
          ),
          ListTile(
            title: const Text('Inventory'),
            onTap: () {
              Navigator.pushNamed(context, '/inventory');
            },
          ),
          ListTile(
            title: const Text('Past Dispensed'),
            onTap: () {
              Navigator.pushNamed(context, '/pastDispensed');
            },
          ),
          // Add additional pharmacist-specific menu items here.
        ],
      ),
    );
  }
}
