import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';
import 'package:prescripto/physician/Home/Home.dart';
import 'package:prescripto/physician/Patients/PatientsBackEnd.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart'; // Ensure the correct path

class Patients extends StatefulWidget {
  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<Patients> {
  // List to store patients data fetched from the database
  List<Map<String, dynamic>> patients = [];
  // List to store filtered patients based on the search query
  List<Map<String, dynamic>> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  /// Fetches patient data from the backend using PatientsService
  Future<void> _fetchPatients() async {
    final db = AppDatabase();
    final result = await PatientsService.fetchPatients(db);
    setState(() {
      patients = result;
      filteredPatients = result; // Initially display all patients
    });
  }

  /// Filters the patient list based on the search query
  void _filterPatients(String query) {
    setState(() {
      filteredPatients = patients.where((patient) {
        final name = patient['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sidebar Menu
          Container(
            width: 200,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => physicianHome()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('New Prescriptions'),
                  onTap: () {
                      Navigator.push(
                            context,
                         MaterialPageRoute(builder: (context) =>  NewPrescription()),
                              );

                  },
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Patients'),
                  selected: true,
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('Feedback'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search field to filter patients
                  TextField(
                    onChanged: _filterPatients,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search patients',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // List view displaying filtered patients
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        final patient = filteredPatients[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(patient['name']),
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
