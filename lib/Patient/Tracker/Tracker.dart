import 'package:flutter/material.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  _Tracker createState() => _Tracker();
}

class _Tracker extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Patient Tracker page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
    );
  }

}
