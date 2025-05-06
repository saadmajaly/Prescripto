import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';

class EmergencyAccessRequestsPage extends StatefulWidget {
  const EmergencyAccessRequestsPage({Key? key}) : super(key: key);

  @override
  _EmergencyAccessRequestsPageState createState() => _EmergencyAccessRequestsPageState();
}

class _EmergencyAccessRequestsPageState extends State<EmergencyAccessRequestsPage> {
  final db = AppDatabase();
  late Future<List<EmergencyAccessRequest>> _futureRequests;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  void _loadRequests() {
    setState(() {
      _futureRequests = db.getAllEmergencyAccessRequests();
    });
  }

  Future<void> _changeStatus(int id, String status) async {
    await db.updateEmergencyAccessRequestStatus(id, status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request $id $status')),
    );
    _loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Access Requests')),
      body: FutureBuilder<List<EmergencyAccessRequest>>(
        future: _futureRequests,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final requests = snap.data ?? [];
          if (requests.isEmpty) {
            return const Center(child: Text('No emergency requests.'));
          }
          return ListView.separated(
            itemCount: requests.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (ctx, i) {
              final r = requests[i];
              return ListTile(
                title: Text('Request #${r.id} — ${r.status}'),
                subtitle: Text(
                  'Patient ID: ${r.patientId}\n'
                      'Physician ID: ${r.physicianId}\n'
                      'Reason: ${r.reason}\n'
                      'At: ${r.createdAt}',
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: r.status == 'pending'
                          ? () => _changeStatus(r.id, 'approved')
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: r.status == 'pending'
                          ? () => _changeStatus(r.id, 'rejected')
                          : null,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
