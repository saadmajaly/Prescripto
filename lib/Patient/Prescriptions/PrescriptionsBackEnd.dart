import 'package:drift/drift.dart';

import '../../data/database.dart';

class PrescriptionsBackEnd {
  final AppDatabase db = AppDatabase();

  // get the prescriptions from database
  Future<Map<String, List<Map<String, dynamic>>>> getPrescriptions(String nationalId) async {
    final user = await db.getUserByNatID(nationalId);
    if (user == null) return {"active": [], "past": []}; // Return empty if user not found

    // Get the user prescriptions
    final prescriptions = await (db.select(db.prescriptions)
      ..where((p) => p.patientId.equals(user.id) & p.status.equals('pending')))
        .get();

    List<Map<String, dynamic>> activePrescriptions = [];
    List<Map<String, dynamic>> pastPrescriptions = [];

    //get prescription items
    for (var prescription in prescriptions) {
      final items = await (db.select(db.prescriptionItems)
        ..where((p) => p.prescriptionId.equals(prescription.prescriptionId)))
          .get();

      // get meds details
      for (var item in items) {
        final medication = await (db.select(db.medications)
          ..where((m) => m.medicationId.equals(item.medicationId)))
            .getSingleOrNull();

        if (medication != null) {
          final Map<String, dynamic> prescriptionData = {
            "id":prescription.prescriptionId,
            "name": "${medication.name} ${item.dosage ?? ''}",
            "instructions": prescription.instructions ?? "No instructions",
            "expiredDate": prescription.createdAt.add(Duration(days: 30)), // Assuming a 30-day validity
          };

          // Sort into active or past
          if (DateTime.now().isAfter(prescriptionData["expiredDate"])) {
            pastPrescriptions.add(prescriptionData);
          } else {
            activePrescriptions.add(prescriptionData);
          }
        }
      }
    }

    return {"active": activePrescriptions, "past": pastPrescriptions};
  }

}
