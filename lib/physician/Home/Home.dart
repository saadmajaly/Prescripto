import 'package:flutter/material.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';
import 'package:prescripto/physician/Home/HomeBackEnd.dart';
import 'package:prescripto/data/database.dart';

class physicianHome extends StatefulWidget {
  const physicianHome({super.key});

  @override
  _physicianHome createState() => _physicianHome();
}

class _physicianHome extends State<physicianHome> {
  late HomeBackEnd controller;
  List<PrescriptionSummary> allPrescriptions = [];
  List<PrescriptionSummary> filteredPrescriptions = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    controller = HomeBackEnd(AppDatabase());
    loadData();
  }

  Future<void> loadData() async {
    // Replace with real physician national ID from auth
    const physicianNatId = '8888888888';
    allPrescriptions = await controller.loadPrescriptions(physicianNatId);
    setState(() {
      filteredPrescriptions = allPrescriptions;
    });
  }

  void onSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredPrescriptions = controller.filterPrescriptions(allPrescriptions, query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Your Prescriptions',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: SizedBox.shrink(),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.note_add),
                title: const Text('New Prescription'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPrescription()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Patients'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Patients()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text('Feedback'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedbackScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            child: Drawer(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.note_add),
                      title: const Text('New Prescription'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewPrescription()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text('Patients'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Patients()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.feedback),
                      title: const Text('Feedback'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FeedbackScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Help'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search prescriptions',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: onSearch,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPrescriptions.length,
                      itemBuilder: (context, index) {
                        final prescription = filteredPrescriptions[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.receipt_long, color: Colors.blue),
                            title: Text("#${prescription.id}"),
                            subtitle: Text(
                              '${prescription.formattedTime}\nPatient: ${prescription.patientName ?? 'N/A'}',
                            ),
                            onTap: () {
                              // Navigate to details page
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}