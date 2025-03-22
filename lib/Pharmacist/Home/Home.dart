import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prescripto/Pharmacist/Prescriptions/ReviewPrescription.dart';
import 'dart:convert';

import '../../data/database.dart';
import 'HomeBackEnd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PharmacistHome(),
    );
  }
}

class PharmacistHome extends StatefulWidget {
  const PharmacistHome({super.key});

  @override
  _PharmacistHomeState createState() => _PharmacistHomeState();
}

class _PharmacistHomeState extends State<PharmacistHome> {
  List<dynamic> prescriptions = [];

  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
    final homeBackend = HomeBackend(AppDatabase());

    final prescriptions = await homeBackend.getPendingPrescriptions();
    setState(() {
      this.prescriptions = prescriptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Prescripto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                _buildSidebarItem('Home', isActive: true),
                _buildSidebarItem('Inventory'),
                _buildSidebarItem('Feedback'),
                _buildSidebarItem('Help'),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prescriptions',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'New prescriptions awaiting review',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Patient List
                  Expanded(
                    child: ListView.builder(
                      itemCount: prescriptions.length,
                      itemBuilder: (context, index) {
                        var prescription = prescriptions[index];
                        return _buildPrescriptionCard(
                          prescription['id'],
                          prescription['firstName'],
                          prescription['lastName'],
                          prescription['physicianName'],
                          prescription['status'],
                          context,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar Item
  Widget _buildSidebarItem(String title, {bool isActive = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: isActive ? Colors.grey[300] : Colors.transparent,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isActive ? Colors.black : Colors.grey[700],
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Prescription Card
  Widget _buildPrescriptionCard(
      int prescriptionId,
      String firstName,
      String lastName,
      String physicianName,
      String status,
      BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue[800],
          ),
          child: const Icon(Icons.medical_services, color: Colors.white),
        ),
        title: Text("$firstName $lastName",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text(physicianName, style: const TextStyle(color: Colors.grey)),
        trailing: status == 'pending'
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  // Navigate to Review Prescription Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPrescriptionScreen(
                          prescriptionId: prescriptionId),
                    ),
                  );
                },
                child: const Text('Review'),
              )
            : const Text(
                'Dispensed',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
