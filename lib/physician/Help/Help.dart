import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Home/Home.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';

/// A Help page that guides the physician through the main app features with sidebar navigation.
class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.indigo[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/PrescriptoLogo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => physicianHome()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('New Prescriptions'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPrescription()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Patients'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Patients()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('Feedback'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help'),
                  onTap: () {}, // Already on Help page
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Log out'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WebLoginPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),

          // Main Help Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    'Welcome to Prescripto!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // 1. Home Page Section
                  ExpansionTile(
                    leading: const Icon(Icons.home),
                    title: const Text('1. Home Page'),
                    children: const [
                      ListTile(
                        title: Text(
                          '• • View today’s patient count and  prescription count.\n'
                          '• Tap any card to see details, or use the bottom nav bar to switch pages.\n'
                          '• At the bottom is a search bar: enter prescription IDs or keywords to filter the list.\n'
                          '• Above it, view all prescriptions \n'
                          '• Scroll through the list or refine your search.',
                        ),
                      ),
                    ],
                  ),

                  // 2. Patients Section
                  ExpansionTile(
                    leading: const Icon(Icons.person),
                    title: const Text('2. Patients'),
                    children: const [
                      ListTile(
                        title: Text(
                          '• Find all registered patients in a searchable list.\n'
                          '• Use the search bar to locate a patient by name.\n'
                          
                        ),
                      ),
                    ],
                  ),
                  //New Prescription 
                      ExpansionTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('3. New Prescription'),
                    children: const [
                      ListTile(
                        title: Text(
                          '• Select the patient. .\n'
                          '• Write the prescription.\n'
                          '• Recommend a pharmacy to the patient.',
                          
                        ),
                      ),
                    ],
                  ),
                  
                  // 3. Feedback Section
                  ExpansionTile(
                    leading: const Icon(Icons.feedback),
                    title: const Text('3. Feedback'),
                    children: const [
                      ListTile(
                        title: Text(
                          '• Allow the physician to provide feedback on the site..\n'
                         
                        ),
                      ),
                    ],
                  ),

                  // 4. Help & Support Section
               
                  const SizedBox(height: 24),
                  Text(
                    'Tips & Best Practices',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Keep the app updated to the latest version.\n'
                    '• Log out when finished, especially on shared devices.\n'
         
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
