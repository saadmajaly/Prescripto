import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Help/Help.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescriptionBackEnd.dart';
import 'package:prescripto/data/database.dart';

import '../Home/Home.dart';

class NewPrescription extends StatefulWidget {
  const NewPrescription({Key? key}) : super(key: key);

  @override
  _NewPrescriptionState createState() => _NewPrescriptionState();
}

class _NewPrescriptionState extends State<NewPrescription> {
  // Dynamic list of medication controllers
  List<Map<String, TextEditingController>> prescriptions = [
    {
      'drugName': TextEditingController(),
      'dosage': TextEditingController(),
      'frequency': TextEditingController(),
      'quantity': TextEditingController(),
    }
  ];

  // Patient selection
  List<Map<String, dynamic>> patients = [];
  String? selectedPatient;

  // Prescription-level fields
  bool includesControlled = true;
  final TextEditingController instructionsController = TextEditingController();

  // Toggle UI for controlled / non-controlled
  final List<String> refills = ['0', '1', '2', '3', '4+'];
  final List<String> dawOptions = ['Yes', 'No'];
  List<bool> _toggleSelections = [true, false];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  @override
  void dispose() {
    for (var entry in prescriptions) {
      entry.values.forEach((c) => c.dispose());
    }
    instructionsController.dispose();
    super.dispose();
  }

  Future<void> fetchPatients() async {
    final db = AppDatabase();
    patients = await PrescriptionService.fetchPatients(db);
    setState(() {});
  }

  void _addMedication() {
    setState(() {
      prescriptions.add({
        'drugName': TextEditingController(),
        'dosage': TextEditingController(),
        'frequency': TextEditingController(),
        'quantity': TextEditingController(),
      });
    });
  }

  void _removeMedication(int index) {
    setState(() {
      prescriptions[index].values.forEach((c) => c.dispose());
      prescriptions.removeAt(index);
    });
  }

  Future<void> submitPrescription() async {
    // Validate patient
    if (selectedPatient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a patient')),
      );
      return;
    }
    // Validate instructions
    if (instructionsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter prescription instructions')),
      );
      return;
    }
    // Validate each medication
    for (var entry in prescriptions) {
      if ((entry['drugName']!).text.isEmpty ||
          (entry['dosage']!).text.isEmpty ||
          (entry['frequency']!).text.isEmpty ||
          (entry['quantity']!).text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all medication fields')),
        );
        return;
      }
    }

    final db = AppDatabase();
    final meds = prescriptions.map((entry) {
      return {
        'name': entry['drugName']!.text,
        'description': '',
        'dosage': entry['dosage']!.text,
        'frequency': entry['frequency']!.text,
        'quantity': int.parse(entry['quantity']!.text),
      };
    }).toList();

    final success = await PrescriptionService.submitPrescription(
      db,
      includesControlled: includesControlled,
      patientId: int.parse(selectedPatient!),
      instructions: instructionsController.text,
      medications: meds,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Prescription submitted successfully!'
              : 'Failed to submit prescription.',
        ),
      ),
    );

    if (success) {
      setState(() {
        instructionsController.clear();
        for (var entry in prescriptions) {
          entry.values.forEach((c) => c.clear());
        }
        prescriptions = [
          {
            'drugName': TextEditingController(),
            'dosage': TextEditingController(),
            'frequency': TextEditingController(),
            'quantity': TextEditingController(),
          }
        ];
        selectedPatient = null;
        includesControlled = true;
        _toggleSelections = [true, false];
      });
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
                      'New Prescription',
                      style:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Patient',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: selectedPatient,
                      items: patients
                          .map(
                            (p) => DropdownMenuItem<String>(
                          value: p['id'].toString(),
                          child: Text(p['name']),
                        ),
                      )
                          .toList(),
                      onChanged: (val) => setState(() => selectedPatient = val),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey.shade400, width: 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _toggleSelections = [true, false];
                                  includesControlled = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _toggleSelections[0]
                                      ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomLeft: Radius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  'Includes Controlled Medications',
                                  style: TextStyle(
                                    color: _toggleSelections[0]
                                        ? Theme.of(context).primaryColor
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _toggleSelections = [false, true];
                                  includesControlled = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _toggleSelections[1]
                                      ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  'Without Controlled Medications',
                                  style: TextStyle(
                                    color: _toggleSelections[1]
                                        ? Theme.of(context).primaryColor
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      'Prescription Instructions',
                      instructionsController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    _buildPrescriptions(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.add_circle,
                            size: 36, color: Colors.blue),
                        onPressed: _addMedication,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
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

  Widget _buildPrescriptions() {
    return Column(
      children: prescriptions.asMap().entries.map((entry) {
        final idx = entry.key;
        final controllers = entry.value;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RX ${idx + 1}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildTextField('Drug Name', controllers['drugName']!),
                _buildTextField('Dosage', controllers['dosage']!),
                _buildTextField('Frequency', controllers['frequency']!),
                _buildTextField('Quantity', controllers['quantity']!,
                    keyboardType: TextInputType.number),
                if (prescriptions.length > 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => _removeMedication(idx),
                      icon:
                      const Icon(Icons.remove_circle, color: Colors.red),
                      label: const Text(
                        'Remove',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        int maxLines = 1,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.indigo[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child:
            Image.asset('assets/PrescriptoLogo.png', fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const physicianHome()),
            ),
          ),
            ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('New Prescriptions'),
                  onTap: () {
                 },
                ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Patients'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Patients()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FeedbackScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HelpPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Log Out'),
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const WebLoginPage()),
                  (route) => false,
            ),
          ),
        ],
      ),
    );
  }
}
