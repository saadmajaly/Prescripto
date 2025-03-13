import '../../data/database.dart';

class HomeBackEnd {
  final AppDatabase db = AppDatabase();

  // Fetch user by national ID
  Future<User?> getUser(String nationalId) async {
    try {
      return await db.getUserByNatID(nationalId);
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  // Fetch prescriptions for a specific patient (user)
  Future<List<Prescription>> getUserPrescriptions(int userId) async {
    try {
      return await (db.select(db.prescriptions)
        ..where((tbl) => tbl.patientId.equals(userId)))
          .get();
    } catch (e) {
      print('Error fetching prescriptions: $e');
      return [];
    }
  }

  // Fetch next medication reminder (for example, based on first prescription)
  Future<Map<String, dynamic>> getNextMedicationReminder(int userId) async {
    try {
      final prescriptions = await getUserPrescriptions(userId);
      if (prescriptions.isNotEmpty) {
        // Example logic: take first prescription as reminder (You can enhance this logic)
        final prescription = prescriptions.first;
        return {
          'name': 'Lisinopril', // Example fixed name, can be dynamic later
          'time': '8:00 AM',   // Example fixed time, can be linked to prescription
          'instructions': prescription.instructions ?? 'No instructions',
          'image': 'assets/HomeMobile.png'
        };
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching medication reminder: $e');
      return {};
    }
  }

  // Fetch active prescriptions as medicine info (You can customize as needed)
  Future<List<Map<String, String>>> getActiveMedications(int userId) async {
    try {
      final prescriptionItems = await (db.select(db.prescriptionItems)
        ..where((tbl) => tbl.prescriptionId.isInQuery(
            db.select(db.prescriptions)..where((p) => p.patientId.equals(userId)))))
          .get();

      final medications = <Map<String, String>>[];

      for (var item in prescriptionItems) {
        final medication = await (db.select(db.medications)
          ..where((m) => m.medicationId.equals(item.medicationId)))
            .getSingleOrNull();
        if (medication != null) {
          medications.add({
            'name': medication.name,
            'dosage': item.dosage ?? 'No dosage',
            'image': 'assets/MedicineLogo.jpg' // Static image, can be dynamic if available
          });
        }
      }

      return medications;
    } catch (e) {
      print('Error fetching active medications: $e');
      return [];
    }
  }
}
