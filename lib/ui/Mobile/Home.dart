import 'package:flutter/material.dart';

class patientHome extends StatefulWidget {
  const patientHome({super.key});

  @override
  _patientHomePage createState() => _patientHomePage();
}

class _patientHomePage extends State<patientHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Patient home page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
    );
  }

}
