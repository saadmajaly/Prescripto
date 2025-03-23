import 'package:flutter/material.dart';
import 'TrackerBackEnd.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  final TrackerBackEnd backend = TrackerBackEnd();
  List<Map<String, dynamic>> todaySchedule = [];
  List<Map<String, dynamic>> medicationLog = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTrackerData();
  }

  Future<void> _fetchTrackerData() async {
    const String nationalId = "9999999999"; // Replace with actual user ID
    final schedule = await backend.getTodaysSchedule(nationalId);
    final log = await backend.getMedicationLog(nationalId);

    setState(() {
      todaySchedule = schedule;
      medicationLog = log;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Medication Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Today's Schedule"),
            _buildMedicationList(todaySchedule, showCheckbox: true),
            const SizedBox(height: 20),
            _buildSectionTitle("Log"),
            _buildMedicationList(medicationLog, showCheckbox: false),
            const SizedBox(height: 30),
            _buildAddMedicationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMedicationList(List<Map<String, dynamic>> medications, {bool showCheckbox = false}) {
    return medications.isEmpty
        ? Center(
      child: Text(
        showCheckbox ? "No medications scheduled for today" : "No medication log available",
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    )
        : Column(
      children: medications.map((med) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.medication, color: Colors.white),
            ),
            title: Text(
              med["name"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(med["status"]),
            trailing: showCheckbox ? Checkbox(value: false, onChanged: (bool? value) {}) : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddMedicationButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Add medication action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'Add Medication',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
