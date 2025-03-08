import 'package:flutter/material.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({super.key});

  @override
  _Prescriptions createState() => _Prescriptions();
}

class _Prescriptions extends State<Prescriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Patient prescription page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
    );
  }

}
