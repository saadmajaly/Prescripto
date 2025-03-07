import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AuthLogic/AuthProvider.dart';
import 'package:prescripto/ui/Mobile/Signup.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _WebLoginPageState createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        bool loginSuccessful = await Provider.of<AuthProvider>(context, listen: false).Login(
          _nationalIdController.text,
          _passwordController.text,
          "patient"
        );
        if (loginSuccessful) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => patientHome()),
          );
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
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a back button (optional)
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _onLogin();
          },
        ),
        title: const Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // Main content
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spacing at the top
              const SizedBox(height: 40),
              // Page Title
              const Text(
                'Log in to your account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // National ID Field
              TextFormField(
                controller: _nationalIdController,
                decoration: InputDecoration(
                  labelText: 'National ID',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      // Handle National ID image icon action if needed
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your National ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // You can implement password visibility toggle here
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Login Button with a blue background
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set the button color here
                  ),
                  onPressed: _onLogin,
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
         // Forgot Password
Center(
  child: TextButton(
    onPressed: () {
      // Handle "Forgot password?" action
    },
    child: const Text(
      'Forgot password?',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 0, 0, 0), // Change color to blue or your desired color
      ),
    ),
  ),
),
// Sign Up
const SizedBox(height: 10),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
      "Don't have an account?",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    TextButton(
      onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SignUpScreen()),
        );
      },
      child: const Text(
        'Sign up',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0), // Change color to blue or your desired color
        ),
      ),
    ),
  ],
),
const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
