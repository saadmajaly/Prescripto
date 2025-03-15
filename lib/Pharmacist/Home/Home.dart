// import '../../AuthLogic/AuthProvider.dart';
import 'package:flutter/material.dart';

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

class PharmacistHome extends StatelessWidget {
  const PharmacistHome({super.key});

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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                _buildSidebarItem('Home', isActive: true),
                _buildSidebarItem('Inventory'),
                _buildSidebarItem('Reports'),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: [
                  const Text(
                    'Prescriptions',
                    style:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'New prescriptions awaiting review',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Pending Prescriptions
                  _buildPrescriptionCard('Amoxicillin', '100 mg, 1 tablet, oral, twice daily for 10 days', 'Review'),
                  _buildPrescriptionCard('Ibuprofen', '200 mg, 1 tablet, oral, twice daily for 10 days', 'Review'),
                  _buildPrescriptionCard('Clindamycin', '5 mL, 1 bottle, topical, twice daily for 7 days', 'Review'),

                  const SizedBox(height: 32),

                  // Dispensed Prescriptions Header
                  const Text(
                    'Dispensed Prescriptions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),

                  // Dispensed Prescriptions
                  _buildDispensedItem('Acetaminophen', '100 mg. 1 tablet, oral, twice daily for 10 days'),
                  _buildDispensedItem('Ibuprofen', '200 mg. 1 tablet, oral, twice daily for 10 days'),
                  _buildDispensedItem('Clindamycin', '5 mL, 1 bottle, topical, twice daily for 7 days'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar item
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

  // Prescription card with Review button
  Widget _buildPrescriptionCard(String name, String details, String actionText) {
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
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(details),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black,
          ),
          onPressed: () {},
          child: Text(actionText),
        ),
      ),
    );
  }

  // Dispensed prescriptions row
  Widget _buildDispensedItem(String name, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(details, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Text(
            'Dispensed',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

