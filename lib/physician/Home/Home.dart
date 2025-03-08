import 'package:flutter/material.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';



// import '../../AuthLogic/AuthProvider.dart';
class physicianHome extends StatefulWidget {
  const physicianHome({super.key});

  @override
  _physicianHome createState() => _physicianHome();
}

class _physicianHome extends State<physicianHome> {
  final List<Map<String, String>> prescriptions = [
    {'id': '#220365', 'date': 'Created 2 days ago'},
    {'id': '#193625', 'date': 'Created 4 days ago'},
    {'id': '#186325', 'date': 'Created 1 week ago'},
    {'id': '#175635', 'date': 'Created 3 weeks ago'},
    {'id': '#171963', 'date': 'Created 1 month ago'},
  ];
    
  String searchQuery = "";

  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
  backgroundColor: Colors.white, // Set AppBar background to white
  automaticallyImplyLeading: false,
  centerTitle: true,
  title: const Text(
    'Your Prescriptions',
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Ensure text is visible on white
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
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Patients'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text('Feedback'),
                onTap: () {},
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
                         MaterialPageRoute(builder: (context) =>  NewPrescription()),
                              );
                              },
                                                                                                                                                                                                                                                                                                   ),

                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text('Patients'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.feedback),
                      title: const Text('Feedback'),
                      onTap: () {},
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
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: prescriptions.length,
                      itemBuilder: (context, index) {
                        final prescription = prescriptions[index];
                        if (searchQuery.isNotEmpty &&
                            !prescription['id']!.toLowerCase().contains(searchQuery)) {
                          return Container();
                        }
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.receipt_long, color: Colors.blue),
                            title: Text(prescription['id']!),
                            subtitle: Text(prescription['date']!),
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
