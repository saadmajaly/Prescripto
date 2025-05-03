import 'package:drift/drift.dart';
import 'package:prescripto/data/database.dart';

/// Helper to update a prescription's status in the database.
Future<bool> updatePrescriptionStatus(
    AppDatabase db,
    int prescriptionId,
    String status,
    ) async {
  final affectedRows = await (db.update(db.prescriptions)
    ..where((p) => p.prescriptionId.equals(prescriptionId)))
      .write(PrescriptionsCompanion(
    status: Value(status),
  ));
  return affectedRows > 0;
}
