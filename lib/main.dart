import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:prescripto/data/database.dart';
import 'ui/auth/login_screen.dart';
import 'ui/auth/signup_screen.dart';
import 'ui/patient/Login.dart';

void main() {
  //saed
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prescripto',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => kIsWeb ? WebLoginPage() : Login(),
      },
    );
  }
}

//abdelrahman
