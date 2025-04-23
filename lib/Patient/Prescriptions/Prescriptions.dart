import 'package:flutter/material.dart';
import '../../AuthLogic/AuthProvider.dart';
import '../../data/database.dart';
import 'PrescriptionsBackEnd.dart';
import 'SinglePrescription.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({super.key});

  @override
  _PrescriptionsState createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  final PrescriptionsBackEnd backend = PrescriptionsBackEnd();
  List<Map<String, dynamic>> activePrescriptions = [];
  List<Map<String, dynamic>> pastPrescriptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrescriptions();
  }

  Future<void> _fetchPrescriptions() async {
    final AppDatabase db = AppDatabase();
    var authProvider = new AuthProvider(db);
    var nationalId = await authProvider.getLoggedInNationalID() as String; // Replace with real user ID
    final prescriptions = await backend.getPrescriptions(nationalId);
    setState(() {
      activePrescriptions = prescriptions["active"]!;
      pastPrescriptions = prescriptions["past"]!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Prescriptions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Active"),
              _buildPrescriptionList(activePrescriptions),
              const SizedBox(height: 20),
              _buildSectionTitle("Past"),
              _buildPrescriptionList(pastPrescriptions, isExpired: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPrescriptionList(List<Map<String, dynamic>> prescriptions, {bool isExpired = false}) {
    return prescriptions.isEmpty
        ? _buildEmptyMessage(isExpired ? "No past prescriptions" : "No active prescriptions")
        : ListView.builder(
      shrinkWrap: true, // Allows it to be inside a Column without overflowing
      physics: const NeverScrollableScrollPhysics(), // Disables separate scrolling
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        final prescription = prescriptions[index];
        return _buildPrescriptionTile(
          id: prescription["id"]!,
          name: prescription["name"]!,
          instructions: prescription["instructions"]!,
          expiredDate: prescription["expiredDate"]!,
          isExpired: isExpired,
        );
      },
    );
  }

  Widget _buildEmptyMessage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  Widget _buildPrescriptionTile({
    required String name,
    required String instructions,
    required DateTime expiredDate,
    required bool isExpired,
    required int id,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.medication, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(instructions),
            if (isExpired)
              Text(
                "Expired on ${expiredDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {Navigator.push(
          context,MaterialPageRoute(
            builder: (_) => SinglePrescription(prescriptionId: id,),
        )
      );},
    ));
  }
}
