import 'package:flutter/cupertino.dart';
import 'package:prescripto/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prescripto/data/database.dart';

class AuthProvider with ChangeNotifier{

  final AppDatabase db;
  AuthProvider(this.db);

  //this function takes the user nationalId and the password and the role as parameters
  Future<bool> Login(String nationalId, String hashedPassword, String role) async {
    if(role == "0")
      {role = "physician";}
    else if(role == "1")
      {role = "pharmacist";}
    else{role = "patient";}
    //this statement selects the user using the nationalId
    final query = db.select(db.users)
      ..where((tbl) => tbl.nationalId.equals(nationalId));

    final user = await query.getSingleOrNull();
    //this statement check if the user exist?
    if (user != null) {
      //compare the user with the hashed password and the role
      if (user.passwordHash == hashedPassword && user.role == role) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // store the most used user info in the session to be used in the next pages and processes
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', user.email);
        await prefs.setString('NationalID', user.nationalId);
        await prefs.setString('userRole', role);
        return true;
      }
    }
    return false;
  }

  //logs the user out and clear the session data
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn')??false;
  }

  Future<String?> getLoggedInNationalID() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("NationalID");
  }
}
