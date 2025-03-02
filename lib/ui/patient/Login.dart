import 'package:flutter/material.dart';

class Login extends StatefulWidget {
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

  void _onLogin() {
    //  Implement your login logic here
    if (_formKey.currentState!.validate()) {
      // Perform login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a back button (optional)
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
                'Sign in to your account',
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
        // Handle "Sign up" navigation
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
