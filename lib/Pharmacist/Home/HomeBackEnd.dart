import 'package:drift/drift.dart';
import 'package:prescripto/data/database.dart';

class HomeBackend {
  final AppDatabase db;

  HomeBackend(this.db);

  /// Fetch all pending prescriptions along with patient & physician names
  Future<List<Map<String, dynamic>>> getPendingPrescriptions() async {
    // Create an alias for the physician table
    final physicianAlias = db.users.createAlias('physician');

    final query = await (db.select(db.prescriptions)
      ..where((p) => p.status.equals('pending')))
        .join([
      // Join with the users table to get patient details
      leftOuterJoin(db.users, db.users.id.equalsExp(db.prescriptions.patientId)),

      // Join with the alias for the users table to get physician details
      leftOuterJoin(physicianAlias, physicianAlias.id.equalsExp(db.prescriptions.physicianId)),
    ]).get();

    return query.map((row) {
      final patient = row.readTable(db.users);
      final physician = row.readTable(physicianAlias); // Use the alias

      return {
        'prescriptionId': row.readTable(db.prescriptions).prescriptionId,
        'firstName': patient.firstName,
        'lastName': patient.lastName,
        'physicianName': '${physician.firstName} ${physician.lastName}',
        'status': row.readTable(db.prescriptions).status,
      };
    }).toList();
  }

  /// Update prescription status (Dispensed or Rejected)
  Future<bool> updatePrescriptionStatus(int prescriptionId, String status) async {
    final affectedRows = await (db.update(db.prescriptions)
      ..where((p) => p.prescriptionId.equals(prescriptionId)))
        .write(PrescriptionsCompanion(status: Value(status)));

    return affectedRows > 0;
  }
}
