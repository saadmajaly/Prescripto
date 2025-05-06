import 'package:drift/src/runtime/data_class.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:prescripto/Admin/AdminHome.dart';
import 'package:prescripto/Admin/AdminLogin.dart';
import 'package:prescripto/Patient/MainScreen.dart';
import 'package:prescripto/Patient/Auth/Signup.dart';
import 'package:prescripto/Pharmacist/Home/Home.dart';
import 'package:prescripto/physician/Home/Home.dart';
import 'package:provider/provider.dart';

// Data layer
import 'package:prescripto/data/database.dart';
// Auth screens
import 'package:prescripto/CommonWeb/login_screen.dart';
// Patient (mobile) login
import 'package:prescripto/Patient/Auth/Login.dart';
// Auth provider
import 'package:prescripto/AuthLogic/AuthProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pharmacist/MainScreen.dart';


bool isLoggedIn = false;
String role = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  role       = prefs.getString('userRole')   ?? "";

  final db = AppDatabase();
  await db.clearDatabase();
  await db.populateTestData();

  var users = await db.getAllUsers();
  print(users.length);
  for( var user in users){
    print(user.firstName + "\n");
    print(user.nationalId + "\n");
    print(user.passwordHash + "\n");
    print(user.role + "\n");
    print("-------------------------\n");
  }

  final authProvider = AuthProvider(db);
  runApp(
    ChangeNotifierProvider<AuthProvider>.value(
      value: authProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/admin9ryd': (ctx) => AdminLoginPage()},
      title: 'Prescripto',
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final initialPath = Uri.base.path;
          if (initialPath == '/admin9ryd') {
            return AdminLoginPage();
          }
          if (isLoggedIn) {
            switch (role) {
              case 'patient':
                return MainScreen();
              case 'physician':
                return physicianHome();
              case 'pharmacist':
                return PharmacistHomeScreen();
              case 'admin':
                return AdminHomePage();
              default:
                return kIsWeb ? WebLoginPage() : Login();
            }
          } else {
            return kIsWeb ? WebLoginPage() : Login();
          }
        },
      ),
    );
  }
}
