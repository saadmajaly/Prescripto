import '../../data/database.dart';

class TrackerBackEnd {
  final AppDatabase db = AppDatabase();

  // get today scheduled meds
  Future<List<Map<String, dynamic>>> getTodaysSchedule(String nationalId) async {
    final prescriptions = await db.GetUserPrescriptions(nationalId);
    List<Map<String, dynamic>> schedule = [];

    for (var prescription in await prescriptions.get()) {
      final prescriptionItems = await (db.select(db.prescriptionItems)
        ..where((p) => p.prescriptionId.equals(prescription.prescriptionId)))
          .get();

      for (var item in prescriptionItems) {
        final medication = await (db.select(db.medications)
          ..where((m) => m.medicationId.equals(item.medicationId)))
            .getSingleOrNull();

        if (medication != null) {
          schedule.add({
            'name': medication.name,
            'time': "10:00 AM", // You can modify to retrieve the actual time if available
            'status': "scheduled", // Default status
          });
        }
      }
    }
    return schedule;
  }

  // Get medication log (taken or skipped)
  Future<List<Map<String, dynamic>>> getMedicationLog(String nationalId) async {
    final prescriptions = await db.GetUserPrescriptions(nationalId);
    List<Map<String, dynamic>> log = [];

    for (var prescription in await prescriptions.get()) {
      final prescriptionItems = await (db.select(db.prescriptionItems)
        ..where((p) => p.prescriptionId.equals(prescription.prescriptionId)))
          .get();

      for (var item in prescriptionItems) {
        final medication = await (db.select(db.medications)
          ..where((m) => m.medicationId.equals(item.medicationId)))
            .getSingleOrNull();

        if (medication != null) {
          log.add({
            'name': medication.name,
            'status': "Taken at 10:30 AM", // Example log status
          });
        }
      }
    }
    return log;
  }
}
