import '../../data/database.dart';
import '../../AuthLogic/AuthProvider.dart';
class SettingsBackEnd {
  void UpdateProfile(FirstName, LastName, Email, PhoneNumber) async {
    final DB = new AppDatabase();
    final prefs = new AuthProvider(DB);
    String? NatID = await prefs.getLoggedInNationalID();
    String phoneNumberString = (await PhoneNumber) ?? '';
    DB.updateProfile(NatID??'' , FirstName, LastName, Email, phoneNumberString);
  }
}
