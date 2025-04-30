import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';
import 'HomeBackEnd.dart';
import 'package:prescripto/AuthLogic/AuthProvider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBackEnd backend = HomeBackEnd();
  String userName = "User";
  Map<String, dynamic>? nextMedication;
  List<Map<String, String>> activeMedications = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var db = new AppDatabase();
    var auth = new AuthProvider(db);
    String nationalId = auth.getLoggedInNationalID() as String;
    var name = await backend.getUserName(nationalId);
    var nextMed = await backend.getNextMedicationReminder(nationalId);
    var activeMeds = await backend.getActiveMedications(nationalId);

    setState(() {
      userName = name ?? "User";
      nextMedication = nextMed;
      activeMedications = activeMeds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Patient Home Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/UserPic.jpeg'),
                ),
                const SizedBox(width: 16),
                Text(
                  'Hello, $userName',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Next Medication Reminder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      nextMedication?['image'] ?? 'assets/HomeMobile.png',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nextMedication?['name'] ?? 'No upcoming medication',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          nextMedication?['time'] ?? '--:--',
                          style: TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          nextMedication?['instructions'] ?? 'No instructions available',
                          style: TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Active Presc section
            const Text(
              'Active Prescriptions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            activeMedications.isEmpty
                ? const Center(child: Text("No active prescriptions"))
                : Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: activeMedications.map((med) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(med['image'] ?? 'assets/MedicineLogo.jpg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      med['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      med['dosage']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 20), // Extra space at bottom
          ],
        ),
      ),
    );
  }
}
