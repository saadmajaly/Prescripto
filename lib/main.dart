import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:prescripto/Admin/AdminHome.dart';
import 'package:prescripto/Admin/AdminLogin.dart';
import 'package:prescripto/Patient/MainScreen.dart';
import 'package:prescripto/Pharmacist/Home/Home.dart';
import 'package:prescripto/physician/Home/Home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:prescripto/data/database.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/Patient/Auth/Login.dart';
import 'package:prescripto/AuthLogic/AuthProvider.dart';

bool isLoggedIn = false;
String role = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  role       = prefs.getString('userRole')   ?? "";
  final db = AppDatabase();
  await db.customStatement('PRAGMA foreign_keys = OFF;');
  await db.clearDatabase();
  await db.populateTestData();

  var users = await db.getAllUsers();
  print('Total users: ${users.length}');
  for (var user in users) {
    print('${user.firstName}');
    print('${user.nationalId}');
    print('${user.passwordHash}');
    print('${user.role}');
    print('-------------------------');
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
  const MyApp({Key? key}) : super(key: key);

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
                return PharmacistHome();
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
