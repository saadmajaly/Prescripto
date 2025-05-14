import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';
import 'HomeBackEnd.dart';
import 'package:prescripto/Pharmacist/Prescriptions/ReviewPrescription.dart';
import 'package:prescripto/Pharmacist/MainScreen.dart';


class PharmacistHome extends StatefulWidget {
  const PharmacistHome({Key? key}) : super(key: key);
  @override
  _PharmacistHomeState createState() => _PharmacistHomeState();
}

class _PharmacistHomeState extends State<PharmacistHome> {
  List<dynamic> pendingPrescriptions = [];
  List<dynamic> dispensedPrescriptions = [];
  bool _testDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchPrescriptions();
  }

  Future<void> _fetchPrescriptions() async {
    final db = AppDatabase();
    final homeBackend = HomeBackend(db);

    if (!_testDataLoaded) {
      await db.populateTestData();
      _testDataLoaded = true;
    }

    final prescriptions = await homeBackend.getAllPrescriptions();
    setState(() {
      pendingPrescriptions =
          prescriptions.where((p) => p['status'] == 'waiting').toList();
      dispensedPrescriptions =
          prescriptions.where((p) => p['status'] == 'dispensed').toList();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer( // Replace with your shared drawer widget if available
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo[200]),
              child: const Text('Prescripto', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Prescriptions',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('New prescriptions awaiting review',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  ...pendingPrescriptions.map((p) => _buildCard(p, context)),
                  const SizedBox(height: 20),
                  const Text('Dispensed Prescriptions',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  ...dispensedPrescriptions.map((p) => _buildCard(p, context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCard(Map<String, dynamic> p, BuildContext ctx) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue[800]),
          child: const Icon(Icons.medical_services, color: Colors.white),
        ),
        title: Text(
          '${p['firstName']} ${p['lastName']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(p['physicianName'], style: const TextStyle(color: Colors.grey)),
        trailing: p['status'] == 'waiting'
            ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ReviewPrescriptionScreen(prescriptionId: p['prescriptionId']),
              ),
            );
          },
          child: const Text('Review'),
        )
            : const Text('Dispensed',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
