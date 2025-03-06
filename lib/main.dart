import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:prescripto/ui/Mobile/Signup.dart';
import 'package:provider/provider.dart';

// Data layer
import 'package:prescripto/data/database.dart';
// Auth screens
import 'package:prescripto/ui/Web/Common/login_screen.dart';
import 'package:prescripto/ui/Web/Common/signup_screen.dart';
// Patient (mobile) login
import 'package:prescripto/ui/Mobile/Login.dart';
// Auth provider (make sure the path is correct)
import 'package:prescripto/AuthLogic/AuthProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize and load authentication state
  final authProvider = AuthProvider();
  await authProvider.loadAuthState();

  runApp(
    ChangeNotifierProvider<AuthProvider>.value(
      value: authProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prescripto',
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          // If the user is authenticated, show HomePage
          // Otherwise, display the login screen based on platform.
          if (authProvider.isAuthenticated) {
            return HomePage();
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
