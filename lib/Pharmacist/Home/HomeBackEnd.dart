import 'package:drift/drift.dart';
import 'package:prescripto/data/database.dart';
import 'package:prescripto/Pharmacist/services/prescription_utils.dart' as pu;

class HomeBackend {
  final AppDatabase db;
  HomeBackend(this.db);

  /// Fetch all prescriptions with patient & physician names
  Future<List<Map<String, dynamic>>> getAllPrescriptions() async {
    final physicianAlias = db.users.createAlias('physician');

    final rows = await (db.select(db.prescriptions)).join([
      leftOuterJoin(db.users, db.users.id.equalsExp(db.prescriptions.patientId)),
      leftOuterJoin(
          physicianAlias, physicianAlias.id.equalsExp(db.prescriptions.physicianId)),
    ]).get();

    return rows.map((row) {
      final p = row.readTable(db.prescriptions);
      final patient = row.readTable(db.users);
      final physician = row.readTable(physicianAlias);

      return {
        'prescriptionId': p.prescriptionId,
        'firstName': patient.firstName,
        'lastName':  patient.lastName,
        'physicianName': '${physician.firstName} ${physician.lastName}',
        'status': p.status,
      };
    }).toList();
  }

  /// Delegate to shared helper
  Future<bool> updatePrescriptionStatus(int prescriptionId, String status) {
    return pu.updatePrescriptionStatus(db, prescriptionId, status);
  }
}
