import 'package:flutter/material.dart';

import '../../data/database.dart';
import 'ReviewPrescriptionBackEnd.dart';

class ReviewPrescriptionScreen extends StatefulWidget {
  final int prescriptionId;

  const ReviewPrescriptionScreen({super.key, required this.prescriptionId});

  @override
  _ReviewPrescriptionScreenState createState() =>
      _ReviewPrescriptionScreenState();
}

class _ReviewPrescriptionScreenState extends State<ReviewPrescriptionScreen> {
  Map<String, dynamic>? prescription;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPrescriptionDetails();
  }

  /// Fetch prescription details based on `prescriptionId`
  Future<void> fetchPrescriptionDetails() async {
    final reviewBackend = ReviewBackend(AppDatabase());

    final data =
        await reviewBackend.getPrescriptionDetails(widget.prescriptionId);
    if (data != null) {
      setState(() {
        prescription = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prescription not found')),
      );
    }
  }

  /// Update prescription status (Dispense/Reject)
  Future<void> updatePrescriptionStatus(String status) async {
    final reviewBackend = ReviewBackend(AppDatabase());
    bool success = await reviewBackend.updatePrescriptionStatus(
        widget.prescriptionId, status);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Prescription marked as $status')),
      );
      Navigator.pop(context); // Return to home screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update prescription')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (prescription == null) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: const Center(child: Text('No prescription found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Review Prescription'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Information
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${prescription!['patientFirstName']} ${prescription!['patientLastName']}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Physician: ${prescription!['physicianName']}',
                        style: const TextStyle(color: Colors.grey)),
                    Text('Prescription ID: ${prescription!['prescriptionId']}',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Medicines Section
            const Text(
              'Medicines',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),

            Column(
              children: prescription!['medicines'].map<Widget>((medicine) {
                return _buildMedicineItem(
                    medicine['name'], medicine['dosage'], medicine['price']);
              }).toList(),
            ),

            const Divider(height: 24),

            // Total Cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '\$${prescription!['totalPrice'].toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Doctor's Instructions
            const Text(
              "Doctor's instructions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            if (prescription!['instructions'] != null)
              Text(
                prescription!['instructions'],
                style: const TextStyle(color: Colors.grey),
              )
            else
              const Text(
                'No instructions provided.',
                style: TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 12),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  onPressed: () {
                    updatePrescriptionStatus('rejected');
                  },
                  child: const Text(
                    'Reject',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  onPressed: () {
                    updatePrescriptionStatus('dispensed');
                  },
                  child: const Text(
                    'Dispense',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Medicine List Item
  Widget _buildMedicineItem(String name, String dosage, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(dosage, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Text('\$${price.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
