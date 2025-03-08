import 'package:flutter/material.dart';

class NewPrescription extends StatelessWidget {
  const NewPrescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Prescription'),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Create a new prescription here'),
      ),
    );
  }
}
