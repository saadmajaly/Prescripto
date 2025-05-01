import 'package:prescripto/data/database.dart';
import 'package:drift/drift.dart';

/// Data model that holds the count of patients, prescriptions, and the fetch timestamp.
class HomeStats {
  final int patientCount;
  final int prescriptionCount;
  final DateTime fetchedAt;

  HomeStats({
    required this.patientCount,
    required this.prescriptionCount,
    required this.fetchedAt,
  });
}

/// Backend service for the physician home page.
/// Provides statistics and recent activity from the database.
class HomeBackend {
  final AppDatabase _db;

  /// Optionally accepts a test database, otherwise uses the singleton instance.
  HomeBackend([AppDatabase? db]) : _db = db ?? AppDatabase();

  /// Returns general statistics including total patients and prescriptions.
  Future<HomeStats> fetchStats() async {
    final patients = await _db.getAllPatients();
    final prescriptions = await _db.GetAllPrescriptions();

    return HomeStats(
      patientCount: patients.length,
      prescriptionCount: prescriptions.length,
      fetchedAt: DateTime.now(),
    );
  }

  /// Fetches all prescriptions sorted from newest to oldest.
  Future<List<Prescription>> fetchRecentPrescriptions() async {
    return (await _db.GetAllPrescriptions())
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Returns a list of prescription counts for the past 7 days.
  /// Each index represents one day, ordered from oldest to newest.
  Future<List<int>> fetchWeeklyPrescriptionCounts() async {
    final now = DateTime.now();
    final allPrescriptions = await _db.GetAllPrescriptions();

    List<int> dailyCounts = List.filled(7, 0);

    for (final p in allPrescriptions) {
      final created = p.createdAt;
      final dayDiff = now.difference(DateTime(created.year, created.month, created.day)).inDays;

      // Only consider prescriptions created within the last 7 days
      if (dayDiff >= 0 && dayDiff <= 6) {
        dailyCounts[6 - dayDiff] += 1; // Store in reverse order: oldest → newest
      }
    }

    return dailyCounts;
  }
}
