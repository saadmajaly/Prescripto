// lib/Pharmacist/Prescriptions/ReviewPrescriptionBackEnd.dart
import 'package:drift/drift.dart';
import 'package:prescripto/data/database.dart';
import 'package:prescripto/Pharmacist/services/prescription_utils.dart' as pu;

class ReviewBackend {
  final AppDatabase db;
  ReviewBackend(this.db);

  Future<Map<String, dynamic>?> getPrescriptionDetails(int prescriptionId) async {
    final physicianAlias = db.users.createAlias('physician');

    final q = await (db.select(db.prescriptions)
      ..where((p) => p.prescriptionId.equals(prescriptionId)))
        .join([
      leftOuterJoin(db.users, db.users.id.equalsExp(db.prescriptions.patientId)),
      leftOuterJoin(
          physicianAlias, physicianAlias.id.equalsExp(db.prescriptions.physicianId)),
    ]).getSingleOrNull();

    if (q == null) return null;
    final pres   = q.readTable(db.prescriptions);
    final patient= q.readTable(db.users);
    final doc    = q.readTable(physicianAlias);

    final meds = await (db.select(db.prescriptionItems)
      ..where((pi) => pi.prescriptionId.equals(prescriptionId)))
        .join([
      leftOuterJoin(db.medications,
          db.medications.medicationId.equalsExp(db.prescriptionItems.medicationId)),
    ]).get();

    final List<Map<String, dynamic>> medicineList = meds.map((row) {
      final m   = row.readTable(db.medications);
      // TODO: replace with real inventory lookup once pharmacy context is known
      return {'name': m.name, 'dosage': row.readTable(db.prescriptionItems).dosage, 'price': 20.0};
    }).toList();

    final total = medicineList.fold<double>(0.0, (sum, e) => sum + (e['price'] as double));

    return {
      'prescriptionId':  prescriptionId,
      'patientFirstName': patient.firstName,
      'patientLastName':  patient.lastName,
      'physicianName':    '${doc.firstName} ${doc.lastName}',
      'instructions':     pres.instructions,
      'medicines':        medicineList,
      'totalPrice':       total,
    };
  }

  Future<bool> updatePrescriptionStatus(int prescriptionId, String status) {
    return pu.updatePrescriptionStatus(db, prescriptionId, status);
  }
}
