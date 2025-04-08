import '../../data/database.dart';

class HomeBackEnd {
  final AppDatabase db = AppDatabase();

  // Get user name by national ID
  Future<String?> getUserName(String nationalId) async {
    final user = await db.getUserByNatID(nationalId);
    return user?.firstName; // Return the user's first name
  } 

  // Get all prescriptions for a user
  Future<List<Prescription>> getUserPrescriptions(String nationalId) async {
    final query = await db.GetUserPrescriptions(nationalId);
    return query.get(); // Fetch prescriptions for the user
  }

  // Get the next medication reminder (first upcoming prescription)
  Future<Map<String, dynamic>?> getNextMedicationReminder(String nationalId) async {
    final prescriptions = await getUserPrescriptions(nationalId);
    if (prescriptions.isNotEmpty) {
      final prescription = prescriptions.first; // Get the first prescription

      // Retrieve prescription items for this prescription
      final items = await (db.select(db.prescriptionItems)
        ..where((p) => p.prescriptionId.equals(prescription.prescriptionId)))
          .get();

      if (items.isNotEmpty) {
        final firstItem = items.first;
        // Retrieve medication details
        final medication = await (db.select(db.medications)
          ..where((m) => m.medicationId.equals(firstItem.medicationId)))
            .getSingleOrNull();

        if (medication != null) {
          return {
            'name': medication.name,
            'time': '8:00 AM', // Placeholder for scheduling information
            'instructions': prescription.instructions ?? 'No instructions',
            'image': 'assets/HomeMobile.png'
          };
        }
      }
    }
    return null;
  }

  // Get active medications from the user's prescriptions
  Future<List<Map<String, String>>> getActiveMedications(String nationalId) async {
    final prescriptions = await getUserPrescriptions(nationalId);
    final List<Map<String, String>> activeMeds = [];

    for (var prescription in prescriptions) {
      final prescriptionItems = await (db.select(db.prescriptionItems)
        ..where((tbl) => tbl.prescriptionId.equals(prescription.prescriptionId)))
          .get();

      for (var item in prescriptionItems) {
        final medication = await (db.select(db.medications)
          ..where((m) => m.medicationId.equals(item.medicationId)))
            .getSingleOrNull();

        if (medication != null) {
          activeMeds.add({
            'name': medication.name,
            'dosage': item.dosage ?? 'No dosage available',
            'image': 'assets/MedicineLogo.jpg'
          });
        }
      }
    }
    return activeMeds;
  }
}
