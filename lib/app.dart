import 'package:flutter/material.dart';
import '../../data/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  await db.populateTestData(); // Ensure data is loaded

  final prescriptions = await db.select(db.prescriptions).get();

  for (var p in prescriptions) {
    print('Prescription ID: ${p.prescriptionId}, Patient ID: ${p.patientId}, Status: ${p.status}');
  }

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Text('Check console for prescription IDs'),
  ));
}
