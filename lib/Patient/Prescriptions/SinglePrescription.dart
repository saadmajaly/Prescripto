import 'package:flutter/material.dart';

import '../../data/database.dart';

// Replace these imports with wherever your AppDatabase,
// Prescription, PrescriptionItem, and Medication classes are defined.
// import 'package:your_app/database/app_database.dart';

// Helper class to combine a PrescriptionItem with its Medication info
class PrescriptionItemWithMedication {
  final PrescriptionItem item;
  final Medication medication;

  PrescriptionItemWithMedication(this.item, this.medication);
}

class SinglePrescription extends StatefulWidget {
  final int prescriptionId; // Assuming your DB uses int IDs

  const SinglePrescription({
    Key? key,
    required this.prescriptionId,
  }) : super(key: key);

  @override
  _SinglePrescriptionState createState() => _SinglePrescriptionState();
}

class _SinglePrescriptionState extends State<SinglePrescription> {
  late Future<Prescription> _prescriptionFuture;
  late Future<List<PrescriptionItemWithMedication>> _prescriptionItemsFuture;

  @override
  void initState() {
    super.initState();
    final db = AppDatabase();
    _prescriptionFuture = db.GetPrescription(widget.prescriptionId);
    _prescriptionItemsFuture = _fetchItemsWithMedication(widget.prescriptionId);
  }

  Future<List<PrescriptionItemWithMedication>> _fetchItemsWithMedication(int prescriptionId) async {
    final db = AppDatabase();
    final items = await db.GetPrescriptionItems(prescriptionId);

    // For each PrescriptionItem, also fetch the Medication info
    final results = <PrescriptionItemWithMedication>[];
    for (final item in items) {
      final medication = await db.GetMedicationInfo(item.medicationId);
      results.add(PrescriptionItemWithMedication(item, medication));
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prescription',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Prescription>(
        future: _prescriptionFuture,
        builder: (context, prescriptionSnapshot) {
          if (prescriptionSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (prescriptionSnapshot.hasError) {
            return Center(child: Text('Error: ${prescriptionSnapshot.error}'));
          } else if (!prescriptionSnapshot.hasData) {
            return const Center(child: Text('No prescription found.'));
          }

          final prescription = prescriptionSnapshot.data!;

          // Now fetch the items (and their medication info)
          return FutureBuilder<List<PrescriptionItemWithMedication>>(
            future: _prescriptionItemsFuture,
            builder: (context, itemsSnapshot) {
              if (itemsSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (itemsSnapshot.hasError) {
                return Center(child: Text('Error: ${itemsSnapshot.error}'));
              } else if (!itemsSnapshot.hasData || itemsSnapshot.data!.isEmpty) {
                return const Center(child: Text('No items for this prescription.'));
              }

              final itemList = itemsSnapshot.data!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                    Icon(Icons.person, size: 28, color: Colors.grey.shade700),
                    // Doctor name (assuming you store it in 'doctorName')
                    Text(
                      'Dr. John', //${prescription.doctorName}
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),]),
                    const SizedBox(height: 16),

                    // List of prescription items
                    Expanded(
                      child: ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          final itemWithMed = itemList[index];
                          final medication = itemWithMed.medication;
                          final item = itemWithMed.item;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                            children: [
                                Icon(Icons.medication, color: Colors.blue, size: 28),
                                // Medication name
                                Text(
                                  medication.name, // e.g. 'Amoxicillin 500mg'
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                  ]
                                ),
                                const SizedBox(height: 4),

                                // Dosage instructions from the item
                                Text(
                                  'Take ',// ${item.dosageInstructions}
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Quantity info (e.g. '15 tablets')
                                Text(
                                  '${item.quantity} tablets',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Disclaimers (hard-coded or fetched from DB)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        'Do not skip or stop Amoxicillin early unless instructed by your doctor.\n'
                            'Avoid alcohol if taking Panadol.\n'
                            'If you experience allergic reactions (rash, swelling, difficulty breathing), seek medical help immediately.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // "Send to pharmacy" button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle sending to pharmacy here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Send to pharmacy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
