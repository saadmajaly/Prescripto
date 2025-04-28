import 'package:flutter/material.dart';
import 'package:prescripto/AuthLogic/AuthProvider.dart';
import 'package:prescripto/Patient/Auth/Login.dart';
import 'package:prescripto/data/database.dart';
import 'package:prescripto/Patient/Prescriptions/SendToPharmacy.dart';
import 'UpdateProfile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  // Example of a variable to display chosen language
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          // --- ACCOUNT SECTION ---
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Update profile'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UpdateProfile()),
              );
            },
          ),
          const Divider(),

          // --- CONTENT SECTION ---
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Content',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: Text(_language),
            onTap: () {
              // Handle language change
              // e.g. show a dialog or navigate to another screen
            },
          ),
          const Divider(),

          // --- NOTIFICATIONS SECTION ---
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Push Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Handle push notification settings
            },
          ),
          const Divider(),

          // --- ABOUT SECTION ---
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              // Handle navigation to Privacy Policy
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            onTap: () {
              // Handle navigation to Terms of Service
            },
          ),
          ListTile(
            title: const Text('Help Center'),
            onTap: () {
              // Handle navigation to Help Center
            },
          ),
          const Divider(),

          // --- LOG OUT & DELETE ACCOUNT ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Removes default corner radius
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                AppDatabase db = new AppDatabase();
                AuthProvider Auth = new AuthProvider(db);
                Auth.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: const Text(
                'Log out',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),

          ListTile(
            title: Center(
              child: Text(
                'Delete account',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              AppDatabase db = new AppDatabase();

            },
          )


        ],
      ),
    );
  }
}
