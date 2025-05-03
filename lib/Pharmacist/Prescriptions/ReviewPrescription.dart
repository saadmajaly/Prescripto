import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';
import 'ReviewPrescriptionBackEnd.dart';

class ReviewPrescriptionScreen extends StatefulWidget {
  final int prescriptionId;
  const ReviewPrescriptionScreen({Key? key, required this.prescriptionId})
      : super(key: key);

  @override
  _ReviewPrescriptionScreenState createState() =>
      _ReviewPrescriptionScreenState();
}

class _ReviewPrescriptionScreenState
    extends State<ReviewPrescriptionScreen> {
  Map<String, dynamic>? prescription;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    final backend = ReviewBackend(AppDatabase());
    final data = await backend.getPrescriptionDetails(widget.prescriptionId);
    if (data != null) {
      setState(() {
        prescription = data;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Not found')));
    }
  }

  Future<void> _updateStatus(String status) async {
    final backend = ReviewBackend(AppDatabase());
    final ok = await backend.updatePrescriptionStatus(
        widget.prescriptionId, status);
    if (ok && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Marked $status')));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Update failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (prescription == null) {
      return const Scaffold(
        body: Center(child: Text('No prescription found')),
      );
    }
    return Scaffold(
      backgroundColor: Colors.indigo[200],
      appBar: AppBar(
        title: const Text('Review Prescription'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient info, medicines list, total, instructions, buttons...
            // (unchanged from before)
          ],
        ),
      ),
    );
  }
}
