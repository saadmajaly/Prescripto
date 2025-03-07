
 import 'package:flutter/material.dart';
import 'package:prescripto/ui/Web/Pharmacist/Home.dart';
import 'package:prescripto/ui/Web/physician/Home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import '../../../AuthLogic/AuthProvider.dart';

class WebLoginPage extends StatefulWidget {
  const WebLoginPage({super.key});

  @override
  _WebLoginPageState createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  void _onLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        bool loginSuccessful = await Provider.of<AuthProvider>(context, listen: false).Login(
            _nationalIdController.text,
            _passwordController.text,
            _tabController.index.toString().toLowerCase(),
        );
        if (loginSuccessful) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if(prefs.getString("userRole") == "physician")
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => physicianHome()),
              );
            }
          else if(prefs.getString("userRole") == "pharmacist")
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => pharmacistHome()),
              );
            }

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid National ID or password')),
          );
        }
        // Navigation to the HomePage will be handled by the Consumer in MyApp.
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }
  @override
  void dispose() {
    _tabController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Column(
        children: [
          // Navigation Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // App Name
                Text(
                  "Prescripto",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                // Navigation Links
                Row(
                  children: [
                    _buildNavItem("Home"),
                    _buildNavItem("Features"),
                    _buildNavItem("Pricing"),
                    _buildNavItem("Resources"),
                  ],
                ),
              ],
            ),
          ),

          // Login Form Centered
          Expanded(
            child: Center(
              child: Container(
                width: 500,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),

                    // Placeholder for Logo
                    Image.asset(
                      'images/Weblogin.jpg',
                      width: 300,
                      height: 150,
                      fit: BoxFit.cover,
                    ),

                    Text(
                      'Welcome to Prescripto',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Form(
                        key: _formKey,
                        child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(text: 'Physician'),
                            Tab(text: 'Pharmacist'),
                          ],
                          labelColor: Colors.black,
                          indicatorColor: Colors.blueAccent,
                        ),
                        SizedBox(height: 20),

                        // Username Field
                        TextField(
                          controller: _nationalIdController,
                          decoration: InputDecoration(
                            labelText: 'National Id',
                            hintText: '2063845695',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Password Field
                        TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Login Button
                        ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 22, 102, 167),
                          ),
                          child: Text('Log in'),
                        ),

                        SizedBox(height: 10),

                        // Forgot Password & Sign Up Links
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          child: Text('Forgot your password?'),
                        ),
                        TextButton(
                          onPressed: () {
                            //route the user to the signup page
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          child: Text("Don't have an account?"),
                        ),
                      ],
                    )),

                    // TabBar for user types

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  // Helper Widget for Navbar Items
  Widget _buildNavItem(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        title,
        style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold, color: Colors.black54,),
      ),
    );
  }
}


