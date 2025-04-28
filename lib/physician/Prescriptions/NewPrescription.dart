import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Home/Home.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescriptionBackEnd.dart';
import 'package:prescripto/data/database.dart';
//jfujvhfjibjdibhfdklbdfjobjfdo;kml
class NewPrescription extends StatefulWidget {
  const NewPrescription({super.key});

  @override
  _NewPrescriptionState createState() => _NewPrescriptionState();
}

class _NewPrescriptionState extends State<NewPrescription> {
  List<Map<String, dynamic>> patients = [];
  String? selectedPatient;

  final List<String> refills = ['0', '1', '2', '3', '4+'];
  final List<String> dawOptions = ['Yes', 'No'];
//test
  List<Map<String, dynamic>> prescriptions = [
    {
      'drugName': TextEditingController(),
      'instructions': TextEditingController(),
      'refills': null,
      'daw': null,
      'pharmacyName': TextEditingController(),
      'pharmacyAddress': TextEditingController(),
    }
  ];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final db = AppDatabase();
    List<Map<String, dynamic>> patientList = await PrescriptionService.fetchPatients(db);
    setState(() {
      patients = patientList;
    });
  }

  Future<void> submitPrescription() async {
    if (selectedPatient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a patient')),
      );
      return;
    }

    final db = AppDatabase();

    for (var prescription in prescriptions) {
      if (prescription['drugName'].text.isEmpty || prescription['instructions'].text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields in each prescription')),
        );
        return;
      }

      bool success = await PrescriptionService.submitPrescription(
        db,
        patientId: int.parse(selectedPatient!),
        physicianId: 1, // Replace with actual logged-in physician ID
        instructions: prescription['instructions'].text,
        medications: [
          {
            'medicationId': 1, // Replace with actual medication ID
            'dosage': prescription['drugName'].text,
            'frequency': prescription['instructions'].text,
            'quantity': 10,
          }
        ],
      );

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit one of the prescriptions')),
        );
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All prescriptions submitted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'New prescription',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildPatientDropdown(),
                    const SizedBox(height: 20),
                    _buildPrescriptions(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.add_circle, size: 36, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            prescriptions.add({
                              'drugName': TextEditingController(),
                              'instructions': TextEditingController(),
                              'refills': null,
                              'daw': null,
                              'pharmacyName': TextEditingController(),
                              'pharmacyAddress': TextEditingController(),
                            });
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: submitPrescription,
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: const Color.fromARGB(255, 0, 150, 136),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => physicianHome()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('New prescriptions'),
            selected: true,
            selectedTileColor: Colors.grey.shade300,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Patients'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Patients()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Log out'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WebLoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPatientDropdown() {
    return _buildDropdownField(
      'Select patient',
      patients.map((p) => p['name'] as String).toList(),
      selectedPatient,
      (val) {
        setState(() {
          selectedPatient = val;
        });
      },
    );
  }

  Widget _buildPrescriptions() {
    return Column(
      children: prescriptions.asMap().entries.map((entry) {
        int index = entry.key;
        var prescription = entry.value;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Prescription ${index + 1}'),
                _buildTextField('Drug name', prescription['drugName']),
                _buildTextField('Instructions', prescription['instructions'], maxLines: 3),
                _buildDropdownField('Refills', refills, prescription['refills'], (val) {
                  setState(() => prescription['refills'] = val);
                }),
                _buildDropdownField('Dispense as written (DAW)', dawOptions, prescription['daw'], (val) {
                  setState(() => prescription['daw'] = val);
                }),
                _buildTextField('Pharmacy name', prescription['pharmacyName']),
                _buildTextField('Pharmacy address', prescription['pharmacyAddress']),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1, Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
