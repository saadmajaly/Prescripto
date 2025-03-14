import 'package:flutter/material.dart';

class Patients extends StatefulWidget {
  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<Patients> {
  final List<String> patients = [
    "Stacey Abrams",
    "Kamala Harris",
    "Elizabeth Warren",
    "Nancy Pelosi",
    "Hillary Clinton"
  ];
  List<String> filteredPatients = [];
  
  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }

  void _filterPatients(String query) {
    setState(() {
      filteredPatients = patients
          .where((patient) => patient.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('New Prescriptions'),
                  onTap: () {},
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
          // Main Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: _filterPatients,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search prescriptions',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(filteredPatients[index]),
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
