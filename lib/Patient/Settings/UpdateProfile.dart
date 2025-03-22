import 'package:flutter/material.dart';
import 'package:prescripto/AuthLogic/AuthProvider.dart';
import 'package:prescripto/data/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Prescriptions/SinglePrescription.dart';
import 'SettingsBackEnd.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();

}

class _UpdateProfileState extends State<UpdateProfile> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loadProfileDate() async {
    final db = new AppDatabase();
    final prefs = new AuthProvider(db);
    User? u = await db.getUserByNatID(await prefs.getLoggedInNationalID() as String);
    _firstNameController.text = await u?.firstName as String;
    _lastNameController.text = await u?.lastName as String;
    _phoneController.text = await u?.phone as String;
    _emailController.text = await u?.email as String;
  }

  @override
  void initState() {
    super.initState();
    loadProfileDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              // First Name
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Last Name
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
              ),

              SizedBox(height: 20,),
              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle cancel logic
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SinglePrescription(
                              prescriptionId: 4305, // Replace 123 with the actual ID you want to pass
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54, // Text color
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var db = new AppDatabase();
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var ValidatePassword = await db.ValidatePassword(prefs.getString('NationalID') as String, _passwordController.text);
                        if(ValidatePassword == true){
                          var BE = new SettingsBackEnd();
                          BE.UpdateProfile(_firstNameController.text, _lastNameController.text, _emailController.text, _phoneController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Profile information was updated successfully'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top + 10,
                                left: 10,
                                right: 10,
                              ),
                            ),
                          );
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter the correct password'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top + 10,
                                left: 10,
                                right: 10,
                              ),
                            ),
                          );
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text('Save',
                      style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
