import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';  // your existing drift DB

/// Holds one prescription plus its list of controlled‐substance meds
class ControlledPrescription {
  final int id;
  final String patientName;
  final String physicianName;
  final DateTime createdAt;
  final String status;
  final List<String> meds;

  ControlledPrescription({
    required this.id,
    required this.patientName,
    required this.physicianName,
    required this.createdAt,
    required this.status,
    required this.meds,
  });
}

class ControlledPrescriptionsPage extends StatefulWidget {
  const ControlledPrescriptionsPage({Key? key}) : super(key: key);

  @override
  _ControlledPrescriptionsPageState createState() => _ControlledPrescriptionsPageState();
}

class _ControlledPrescriptionsPageState extends State<ControlledPrescriptionsPage> {
  final db = AppDatabase();
  late Future<List<ControlledPrescription>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchControlledPrescriptions();
  }

  Future<List<ControlledPrescription>> _fetchControlledPrescriptions() async {
    final rows = await db.customSelect(
        '''
SELECT
  p.prescription_id   AS pid,
  pat.first_name || ' ' || pat.last_name   AS patient_name,
  phy.first_name || ' ' || phy.last_name   AS physician_name,
  p.created_at        AS created_at,
  p.status            AS status,
  m.name              AS med_name
FROM prescriptions AS p
  JOIN prescription_items AS pi ON pi.prescription_id = p.prescription_id
  JOIN medications AS m       ON m.medication_id   = pi.medication_id
  JOIN users AS pat           ON pat.id          = p.patient_id
  JOIN users AS phy           ON phy.id          = p.physician_id
WHERE m.controlled_substance = 1
ORDER BY p.prescription_id;
'''
    ).get();

    // Group rows by prescription ID
    final Map<int, ControlledPrescription> map = {};
    for (final row in rows) {
      final pid = row.data['pid'] as int;
      final med = row.data['med_name'] as String;
      if (map.containsKey(pid)) {
        map[pid]!.meds.add(med);
      } else {
        map[pid] = ControlledPrescription(
          id: pid,
          patientName: row.data['patient_name'] as String,
          physicianName: row.data['physician_name'] as String,
          createdAt: row.data['created_at'] as DateTime,
          status: row.data['status'] as String,
          meds: [med],
        );
      }
    }
    return map.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controlled Prescriptions')),
      body: FutureBuilder<List<ControlledPrescription>>(
        future: _future,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final list = snap.data ?? [];
          if (list.isEmpty) {
            return const Center(
              child: Text('No prescriptions with controlled substances found.'),
            );
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (ctx, i) {
              final p = list[i];
              return ListTile(
                title: Text('Prescription #${p.id} — ${p.status}'),
                subtitle: Text(
                  'Patient: ${p.patientName}\n'
                      'Physician: ${p.physicianName}\n'
                      'Date: ${p.createdAt}\n'
                      'Meds: ${p.meds.join(', ')}',
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
