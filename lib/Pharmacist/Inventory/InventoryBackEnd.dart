import 'package:drift/drift.dart';
import 'package:prescripto/data/database.dart';

/// Backend service for fetching all inventory items.
class InventoryBackend {
  final AppDatabase db;
  InventoryBackend(this.db);

  /// Retrieves all inventory items joined with medication details.
  Future<List<Map<String, dynamic>>> getInventoryItems() async {
    final inv = db.inventory;
    final med = db.medications;

    // Select every inventory row and join to medications
    final rows = await (db.select(inv)
        .join([
      leftOuterJoin(
        med,
        med.medicationId.equalsExp(inv.medicationId),
      ),
    ]))
        .get();

    // Map each joined row into a simple map
    return rows.map((row) {
      final i = row.readTable(inv);
      final m = row.readTable(med);
      return {
        'inventoryId': i.inventoryId,
        'medicationName': m.name,
        'quantity': i.quantity,
        'price': i.price,
        'reorderThreshold': i.reorderThreshold,
      };
    }).toList();
  }
}
