import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  /// Attempts to log in with the given [nationalId] and [password].
  ///
  /// Replace the dummy check with your actual authentication logic.
  Future<void> login(String nationalId, String password) async {
    // Dummy credentials check - replace with your API or DB check.
    if (nationalId == '123456789' && password == 'password') {
      _isAuthenticated = true;
      notifyListeners();

      // Persist the login state using SharedPreferences.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
    } else {
      throw Exception('Invalid credentials');
    }
  }

  /// Loads the authentication state from SharedPreferences during app startup.
  Future<void> loadAuthState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    notifyListeners();
  }

  /// Logs out the user by clearing the authentication state.
  Future<void> logout() async {
    _isAuthenticated = false;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuthenticated');
  }
}
