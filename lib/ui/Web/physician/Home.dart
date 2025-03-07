import 'package:flutter/material.dart';

// import '../../AuthLogic/AuthProvider.dart';
class physicianHome extends StatefulWidget {
  const physicianHome({super.key});

  @override
  _physicianHomePage createState() => _physicianHomePage();
}

class _physicianHomePage extends State<physicianHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'physician home page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
    );
  }

}
