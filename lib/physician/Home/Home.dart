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
          // Sidebar Menu
          Container(
            width: 200,
        color: const Color.fromARGB(255, 0, 150, 136),  // #009688

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('New Prescriptions'),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Patients()));
            },
          ),
                  
                
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('Feedback'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Log out'),
                  onTap: () {
                    // Clear user data if needed
                    // Then navigate to login screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WebLoginPage ()),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                     
                    ],
                  ),

                  const SizedBox(height: 20),


                  const SizedBox(height: 20),

                  // Charts and Task
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side with Progress and Skills
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildPlaceholder(height: 180, label: 'Progress Graph'),
                           
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Right side with Productivity and Tasks
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildPlaceholder(height: 180, label: 'Productivity Chart'),
                           
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  }

  Widget _buildPlaceholder({required double height, required String label}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text(label, style: const TextStyle(color: Colors.grey))),
    );
  }

