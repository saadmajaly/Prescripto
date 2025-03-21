import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart'; // <-- Adjust to your actual path
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Home/Home.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';
import 'package:prescripto/physician/Patients/PatientsBackEnd.dart';

class Patients extends StatefulWidget {
  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<Patients> {
  List<Map<String, dynamic>> patients = [];
  List<Map<String, dynamic>> filteredPatients = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    FetchPatients();
  }

  /// Fetches all users with role 'patient' from the DB.
  Future<void> FetchPatients() async {
    setState(() {
      isLoading = true;
    });

    final db = AppDatabase();
    try {
      final userList = await db.getAllPatients();
      final patientsList = userList.map((user) {
        return {
          'id': user.id,
          'name': '${user.firstName} ${user.lastName}',
          'phone': user.phone,
        };
      }).toList();
      setState(() {
        patients = patientsList;
        filteredPatients = patientsList;
        isLoading = false;
      });
      print('Fetched ${patientsList.length} patients');
    } catch (error) {
      debugPrint("Error fetching patients: $error");
      setState(() {
        isLoading = false;
      });
    }

  }

  /// Filters the patient list using a backend search (if query is provided)
  /// or resets to the full list if the query is empty.
  Future<void> _filterPatients(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredPatients = patients;
      });
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        final PatientBE = new PatientsBackEnd();
        // Call the updated backend search function with role filtering.
        final searchResults =
            await PatientBE.searchUsers(query, role: 'patient');
        final mappedResults = searchResults.map((user) {
          return {
            'id': user.id,
            'name': '${user.firstName} ${user.lastName}',
            'phone': user.phone,
          };
        }).toList();
        setState(() {
          filteredPatients = mappedResults;
        });
      } catch (error) {
        debugPrint('Error searching patients: $error');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => physicianHome()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('New Prescriptions'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPrescription()),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackScreen()),
                    );
                  },
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
                  // Display loading indicator or the list of filtered patients
                  isLoading
                      ? Expanded(
                          child: Center(child: CircularProgressIndicator()))
                      : Expanded(
                          child: filteredPatients.isEmpty
                              ? Center(child: Text('No patients found.'))
                              : ListView.builder(
                                  itemCount: filteredPatients.length,
                                  itemBuilder: (context, index) {
                                    final patient = filteredPatients[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                      title: Text(patient['name']),
                                      subtitle: Text('Phone: ${patient['phone'] ?? 'N/A'}'),
                                      onTap: () {
                                        // Optionally, navigate to a "Patient Details" page.
                                      },
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
