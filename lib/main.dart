import 'package:flutter/material.dart';
import 'data/database.dart'; // Adjust the path as needed

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppDatabase db = AppDatabase();

  @override
  void initState() {
    super.initState();
    var db = AppDatabase();
    db.clearDatabase(db);
    db.populateTestData();
    print('Test data populated successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prescripto Debug',
      home: Scaffold(
        appBar: AppBar(title: Text('Prescripto')),
        body: Center(child: Text('Check your console for database logs.')),
      ),
    );
  }
}
