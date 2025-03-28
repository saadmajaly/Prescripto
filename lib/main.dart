import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
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
// Auth provider (make sure the path is correct)
import 'package:prescripto/AuthLogic/AuthProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
var role = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize and load authentication state
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn')??false;
  role = prefs.getString('userRole')??"";
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
  var prescriptions = await db.GetAllPrescriptions();
  for( var pres in prescriptions){
    print(pres.prescriptionId);
    print("-------------------------\n");
  }
  // final usersList = await db.select(db.users).get();
  // print(usersList);
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
      title: 'Prescripto',
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          // If the user is authenticated, show HomePage
          // Otherwise, display the login screen based on platform.
          if (isLoggedIn) {
            switch(role){
              case "patient": return MainScreen();
              break;
              case "physician": return physicianHome();
              break;
              case "pharmacist": return PharmacistHome();
              break;
              default: return kIsWeb ? WebLoginPage() : Login();
            }

          } else {
            return kIsWeb ? WebLoginPage() : Login();
          }
        },
      ),
      routes: {
        '/signup': (context) => SignUpScreen(),
        // Add additional routes here as needed.
      },
    );
  }
}

// A simple HomePage widget that is displayed when the user is authenticated.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescripto Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to Prescripto!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
