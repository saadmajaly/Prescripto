// File: ReviewPrescriptionScreen.dart
import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';
import 'ReviewPrescriptionBackEnd.dart';

class ReviewPrescriptionScreen extends StatefulWidget {
  final int prescriptionId;
  const ReviewPrescriptionScreen({Key? key, required this.prescriptionId}) : super(key: key);

  @override
  _ReviewPrescriptionScreenState createState() => _ReviewPrescriptionScreenState();
}

class _ReviewPrescriptionScreenState extends State<ReviewPrescriptionScreen> {
  Map<String, dynamic>? prescription;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    final backend = ReviewBackend(AppDatabase());
    final data = await backend.getPrescriptionDetails(widget.prescriptionId);
    if (data != null) {
      setState(() {
        prescription = data;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not found')));
    }
  }

  Future<void> _updateStatus(String status, [String? reason]) async {
    final backend = ReviewBackend(AppDatabase());
    final ok = await backend.updatePrescriptionStatus(widget.prescriptionId, status);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Marked $status')));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Update failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (prescription == null) {
      return const Scaffold(
        body: Center(child: Text('No prescription found')),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Review Prescription'),
        centerTitle: true,
        backgroundColor: Colors.indigo[200],
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text("Patient: ${prescription!['patientFirstName']} ${prescription!['patientLastName']}", style: const TextStyle(fontSize: 18)),
            Text("Physician: ${prescription!['physicianName']}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text("Medications:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...List.generate((prescription!['medicines'] as List).length, (i) {
              final item = prescription!['medicines'][i];
              return ListTile(
                title: Text("${item['name']}"),
                subtitle: Text("Dosage: ${item['dosage']}, Price: \$${item['price'].toStringAsFixed(2)}"),
              );
            }),
            const SizedBox(height: 20),
            Text("Instructions: ${prescription!['instructions'] ?? 'No instructions'}"),
            const SizedBox(height: 20),
            Text("Total Price: \$${prescription!['totalPrice'].toStringAsFixed(2)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => _updateStatus('dispensed'),
                  icon: const Icon(Icons.check),
                  label: const Text("Dispense"),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final reason = await showDialog<String>(
                      context: context,
                      builder: (ctx) {
                        String input = '';
                        return AlertDialog(
                          title: const Text("Reject Prescription"),
                          content: TextField(
                            onChanged: (val) => input = val,
                            decoration: const InputDecoration(hintText: "Enter reason"),
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
                            TextButton(onPressed: () => Navigator.pop(ctx, input), child: const Text("Reject")),
                          ],
                        );
                      },
                    );
                    if (reason != null && reason.trim().isNotEmpty) {
                      await _updateStatus('rejected', reason);
                    }
                  },
                  icon: const Icon(Icons.close),
                  label: const Text("Reject"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
