import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Home/Home.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescriptionBackEnd.dart';
import 'package:prescripto/data/database.dart'; // Import the database

class NewPrescription extends StatefulWidget {
  const NewPrescription({super.key});

  @override
  _NewPrescriptionState createState() => _NewPrescriptionState();
}

class _NewPrescriptionState extends State<NewPrescription> {
  List<Map<String, dynamic>> patients = [];
  String? selectedPatient;
  final TextEditingController drugNameController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController pharmacyNameController = TextEditingController();
  final TextEditingController pharmacyAddressController = TextEditingController();
  String? selectedRefills;
  String? selectedDAW;

  final List<String> refills = ['0', '1', '2', '3', '4+'];
  final List<String> dawOptions = ['Yes', 'No'];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  /// Fetch patients from the backend
  Future<void> fetchPatients() async {
    final db = AppDatabase();
    List<Map<String, dynamic>> patientList = await PrescriptionService.fetchPatients(db);
    setState(() {
      patients = patientList;
    });
  }

  /// Submit the prescription to the backend
  Future<void> submitPrescription() async {
    if (selectedPatient == null || drugNameController.text.isEmpty || instructionsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final db = AppDatabase();
    bool success = await PrescriptionService.submitPrescription(
      db,
      patientId: int.parse(selectedPatient!), // Convert from String to int
      physicianId: 1, // Replace with actual logged-in physician ID
      instructions: instructionsController.text,
      medications: [
        {
          'medicationId': 1, // Replace with actual medication ID
          'dosage': '500mg',
          'frequency': 'Twice a day',
          'quantity': 10,
        }
      ],
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prescription submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit prescription')),
      );
    }
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
                    _buildSectionTitle('Prescription information'),
                    _buildTextField('Drug name', drugNameController),
                    _buildTextField('Instructions', instructionsController, maxLines: 4),
                    _buildDropdownField('Refills', refills, selectedRefills, (val) {
                      setState(() {
                        selectedRefills = val;
                      });
                    }),
                    _buildDropdownField('Dispense as written (DAW)', dawOptions, selectedDAW, (val) {
                      setState(() {
                        selectedDAW = val;
                      });
                    }),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Pharmacy preference'),
                    _buildTextField('Pharmacy name', pharmacyNameController),
                    _buildTextField('Pharmacy address', pharmacyAddressController),
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
   color: const Color.fromARGB(255, 0, 150, 136),  // #009688
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
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Log out'),
                  onTap: () {
                    // Clear user data if needed
                    // Then navigate to login screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WebLoginPage ()),
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

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
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
