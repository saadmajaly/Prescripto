import 'package:prescripto/data/database.dart';
import 'package:drift/drift.dart';

class PrescriptionSummary {
  final int id;
  final DateTime createdAt;
  final String formattedTime;
  final String? patientName;

  PrescriptionSummary({
    required this.id,
    required this.createdAt,
    required this.formattedTime,
    this.patientName,
  });
}

class HomeBackEnd {
  final AppDatabase db;

  HomeBackEnd(this.db);

  // Load prescriptions created by the physician (using their national ID)
  Future<List<PrescriptionSummary>> loadPrescriptions(String physicianNatId) async {
    final physician = await (db.select(db.users)
          ..where((u) => u.nationalId.equals(physicianNatId) & u.role.equals("physician")))
        .getSingleOrNull();

    if (physician == null) return [];
final query = db.select(db.prescriptions)
  ..where((p) => p.physicianId.equals(physician.id));

query.orderBy([
  (p) => OrderingTerm(expression: p.createdAt, mode: OrderingMode.desc),
]);

final presList = await query.get();


    // Get the related patient names
    final patientIds = presList.map((p) => p.patientId).toSet().toList();
    final patients = await (db.select(db.users)
          ..where((u) => db.users.id.isIn(patientIds)))
        .get();

    final patientMap = {
      for (var p in patients) p.id: '${p.firstName} ${p.lastName}'
    };

    return presList.map((p) {
      return PrescriptionSummary(
        id: p.prescriptionId,
        createdAt: p.createdAt,
        formattedTime: _relativeTime(p.createdAt),
        patientName: patientMap[p.patientId],
      );
    }).toList();
  }

  // Filter prescriptions by search text
  List<PrescriptionSummary> filterPrescriptions(
      List<PrescriptionSummary> all, String query) {
    final q = query.toLowerCase();
    return all.where((p) {
      return p.id.toString().contains(q) ||
          (p.patientName?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  // Helper to convert datetime into "2 days ago"
  String _relativeTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inDays >= 30) return 'Created 1 month ago';
    if (diff.inDays >= 7) return 'Created ${diff.inDays ~/ 7} week(s) ago';
    if (diff.inDays > 0) return 'Created ${diff.inDays} day(s) ago';
    if (diff.inHours > 0) return 'Created ${diff.inHours} hour(s) ago';
    return 'Created just now';
  }
}