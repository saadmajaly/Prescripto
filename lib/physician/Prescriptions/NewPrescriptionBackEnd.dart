import 'package:prescripto/data/database.dart';
import 'package:drift/drift.dart';
import 'package:prescripto/services/InfuraService.dart';
import 'package:prescripto/AuthLogic/AuthProvider.dart';

class PrescriptionService {
  static final InfuraService _infura = InfuraService();

  /// Fetch patients with role = 'patient'
  static Future<List<Map<String, dynamic>>> fetchPatients(AppDatabase db) async {
    final query = await (db.select(db.users)..where((u) => u.role.equals('patient'))).get();
    return query
        .map((user) => {'id': user.id, 'name': '${user.firstName} ${user.lastName}'})
        .toList();
  }

  /// Submit a new prescription with multiple medications
  static Future<bool> submitPrescription(
      AppDatabase db, {
        required int patientId,
        required String instructions,
        required List<Map<String, dynamic>> medications,
        required bool includesControlled,
      }) async {
    try {
      // Identify current physician
      final auth = AuthProvider(db);
      final natId = await auth.getLoggedInNationalID();
      final physician = (await db.getUserByNatID(natId!))!;

      // Insert prescription header
      final prescriptionId = await db.into(db.prescriptions).insert(
        PrescriptionsCompanion.insert(
          patientId: patientId,
          physicianId: physician.id,
          status: Value('pending'),
        ),
      );

      // Optionally log on blockchain
      if (includesControlled) {
        try {
          final txHash = await _infura.logPrescriptionOnChain(
            prescriptionId: prescriptionId,
            patientId: patientId,
            includesControlled: true,
            from: '',
          );
          await db.into(db.blockchainTransactions).insert(
            BlockchainTransactionsCompanion.insert(
              prescriptionId: prescriptionId,
              transactionHash: txHash,
            ),
          );
        } catch (e) {
          print('Blockchain logging failed: \$e');
        }
      }

      // Loop through medications list
      for (final med in medications) {
        // Determine medication ID (reuse or insert)
        int medId;
        if (med['medicationId'] != null) {
          medId = med['medicationId'] as int;
        } else {
          final existing = await (db.select(db.medications)
            ..where((m) => m.name.equals(med['name'] as String)))
              .getSingleOrNull();
          if (existing != null) {
            medId = existing.medicationId;
          } else {
            medId = await db.into(db.medications).insert(
              MedicationsCompanion.insert(
                name: med['name'] as String,
                description: Value("kk"),
                controlledSubstance: Value(includesControlled),
              ),
            );
          }
        }

        // Insert the prescription item
        await db.into(db.prescriptionItems).insert(
          PrescriptionItemsCompanion.insert(
            prescriptionId: prescriptionId,
            medicationId: medId,
            dosage: Value(med['dosage'] as String),
            frequency: Value(med['frequency'] as String),
            quantity: Value(med['quantity'] as int),
          ),
        );
      }

      return true;
    } catch (e) {
      print('Error in submitPrescription: $e');
      return false;
    }
  }
}
