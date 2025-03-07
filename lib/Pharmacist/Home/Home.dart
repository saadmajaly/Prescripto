import 'package:flutter/material.dart';

// import '../../AuthLogic/AuthProvider.dart';
class pharmacistHome extends StatefulWidget {
  const pharmacistHome({super.key});

  @override
  _pharmacistHomePage createState() => _pharmacistHomePage();
}

class _pharmacistHomePage extends State<pharmacistHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'pharmacist home page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
    );
  }

}
