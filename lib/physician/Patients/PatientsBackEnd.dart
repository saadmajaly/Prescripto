import 'package:prescripto/data/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class PatientsService {
  /// Fetches a list of patients from the Users table where the role is 'patient'
  static Future<List<Map<String, dynamic>>> fetchPatients(AppDatabase db) async {
    try {
      // Use the 'users' table from the database and filter by role 'patient'
      final query = await (db.select(db.users)
        ..where((u) => u.role.equals('patient'))) // Make sure the role value matches your DB
          .get();

      // Map each user record to a map containing 'id' and a concatenated 'name'
      return query.map((user) {
        return {
          'id': user.id,
          'name': '${user.firstName} ${user.lastName}',
        };
      }).toList();
    } catch (e) {
      debugPrint('Error fetching patients: ${e.toString()}');
      return [];
    }
  }
}

