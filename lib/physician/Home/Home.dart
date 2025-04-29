import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';
import 'package:prescripto/physician/Home/HomeBackEnd.dart';
import 'package:prescripto/data/database.dart';

class physicianHome extends StatelessWidget {
  const physicianHome({super.key});

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
                  onTap: () {},
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
                  onTap: () {},
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

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Stat Cards
                  const Row(
                    children: [
                      StatCard(
                        title: 'Number of patient',
                        value: '222',
                        footnote: 'as of today',
                        topRightIcon: Icons.people,
                      ),
                      SizedBox(width: 20),
                      StatCard(
                        title: 'Prescriptions ',
                        value: '45',
                        footnote: 'updated hourly',
                        topRightIcon: Icons.medical_services,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Graph and Prescription List
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildPlaceholder(
                            height: 180,
                            label: 'Progress Graph',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: _buildPlaceholder(
                            height: 180,
                            label: 'Productivity Chart',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Prescription List
                  const Expanded(
                    flex: 2,
                    child: RecentPrescriptions(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder widget
Widget _buildPlaceholder({
  required double height,
  required String label,
}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Center(
      child: Text(
        label,
        style: const TextStyle(color: Colors.grey),
      ),
    ),
  );
}

// StatCard widget
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String footnote;
  final IconData topRightIcon;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.footnote,
    required this.topRightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(topRightIcon, size: 20, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            footnote,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// Prescription list widget
class RecentPrescriptions extends StatelessWidget {
  const RecentPrescriptions({super.key});

  @override
  Widget build(BuildContext context) {
    final prescriptions = [
      {'id': '#220365', 'date': '2 days ago'},
      {'id': '#193625', 'date': '4 days ago'},
      {'id': '#186325', 'date': '1 week ago'},
      {'id': '#175635', 'date': '3 weeks ago'},
      {'id': '#171963', 'date': '1 month ago'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search prescriptions',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 16),

          // List
          Expanded(
            child: ListView.builder(
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                final item = prescriptions[index];
                return ListTile(
                  leading: const Icon(Icons.description, color: Colors.indigo),
                  title: Text(item['id']!),
                  subtitle: Text('Created ${item['date']}'),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
