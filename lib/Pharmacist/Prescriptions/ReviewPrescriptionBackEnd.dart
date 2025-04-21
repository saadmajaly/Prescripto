import 'package:drift/drift.dart';
import '../../data/database.dart';

class ReviewBackend {
  final AppDatabase db;

  ReviewBackend(this.db);

  /// Get prescription details including patient, physician, and medications
  Future<Map<String, dynamic>?> getPrescriptionDetails(int prescriptionId) async {
    // Create alias for physician user
    final physicianAlias = db.users.createAlias('physician');

    final prescriptionQuery = await (db.select(db.prescriptions)
      ..where((p) => p.prescriptionId.equals(prescriptionId)))
        .join([
      leftOuterJoin(db.users, db.users.id.equalsExp(db.prescriptions.patientId)),
      leftOuterJoin(physicianAlias, physicianAlias.id.equalsExp(db.prescriptions.physicianId)),
    ]).getSingleOrNull();

    if (prescriptionQuery == null) return null;

    final patient = prescriptionQuery.readTable(db.users);
    final physician = prescriptionQuery.readTable(physicianAlias);

    final medicines = await (db.select(db.prescriptionItems)
      ..where((pi) => pi.prescriptionId.equals(prescriptionId)))
        .join([
      leftOuterJoin(db.medications,
          db.medications.medicationId.equalsExp(db.prescriptionItems.medicationId))
    ]).get();

    List<Map<String, dynamic>> medicineList = medicines.map((row) {
      final med = row.readTable(db.medications);
      final item = row.readTable(db.prescriptionItems);

      return {
        'name': med.name,
        'dosage': item.dosage,
        'price': 20.0, // Static price; replace with inventory logic if needed
      };
    }).toList();

    return {
      'prescriptionId': prescriptionId,
      'patientFirstName': patient.firstName,
      'patientLastName': patient.lastName,
      'physicianName': '${physician.firstName} ${physician.lastName}',
      'instructions': prescriptionQuery.readTable(db.prescriptions).instructions,
      'medicines': medicineList,
      'totalPrice': medicineList.fold<double>(0.0, (sum, med) => sum + (med['price'] as double)),
    };

  }

  /// Update prescription status
  Future<bool> updatePrescriptionStatus(int prescriptionId, String status) async {
    final affectedRows = await (db.update(db.prescriptions)
      ..where((p) => p.prescriptionId.equals(prescriptionId)))
        .write(PrescriptionsCompanion(status: Value(status)));

    return affectedRows > 0;
  }
}
