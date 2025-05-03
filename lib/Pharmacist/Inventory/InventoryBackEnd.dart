import 'package:drift/drift.dart';
import 'package:prescripto/data/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Backend service for fetching only the logged-in pharmacist’s inventory.
class InventoryBackend {
  final AppDatabase db;
  InventoryBackend(this.db);

  /// Looks up the current pharmacist’s NationalID in prefs,
  /// finds their user record, then returns only inventory rows
  /// for that pharmacyId.
  Future<List<Map<String, dynamic>>> getInventoryItems() async {
    // 1) Read the NationalID from prefs
    final prefs = await SharedPreferences.getInstance();
    final natId = prefs.getString('NationalID');
    if (natId == null) return [];

    // 2) Lookup the user record to get pharmacyId
    final user = await db.getUserByNatID(natId);
    if (user == null) return [];
    final pharmacyId = await (db.select(db.pharmacies)
      ..orderBy([
            (t) => OrderingTerm(
          expression: t.pharmacyId,
          mode: OrderingMode.asc,
        )
      ])
      ..limit(1))
        .getSingle();

    // 3) Join inventory → medications → pharmacies, filtering by pharmacyId
    final inv = db.inventory;
    final med = db.medications;
    final pharm = db.pharmacies;

    final query = (db.select(inv)
      ..where((tbl) => tbl.pharmacyId.equals(pharmacyId as int)))
        .join([
      leftOuterJoin(
        med,
        med.medicationId.equalsExp(inv.medicationId),
      ),
      leftOuterJoin(
        pharm,
        pharm.pharmacyId.equalsExp(inv.pharmacyId),
      ),
    ]);

    final rows = await query.get();
    return rows.map((row) {
      final i = row.readTable(inv);
      final m = row.readTable(med);
      final p = row.readTable(pharm);
      return {
        'inventoryId': i.inventoryId,
        'medicationName': m.name,
        'pharmacyName': p.name,
        'quantity': i.quantity,
        'price': i.price,
        'reorderThreshold': i.reorderThreshold,
      };
    }).toList();
  }
}
