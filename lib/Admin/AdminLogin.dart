import 'package:flutter/material.dart';
import 'package:prescripto/Admin/AdminHome.dart';
import 'package:prescripto/Admin/MainScreen.dart';
import 'package:provider/provider.dart';
import '../AuthLogic/AuthProvider.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl   = TextEditingController();
  final _passCtrl = TextEditingController();

  void _onLogin() async {
    if (_formKey.currentState!.validate()) {
      bool loginSuccess = await Provider.of<AuthProvider>(context, listen: false).Login(
        _idCtrl.text,
        _passCtrl.text,
        '2',
      );
      if (loginSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminMainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid admin credentials')),
        );
      }
    }
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _idCtrl,
                decoration: const InputDecoration(labelText: 'Admin ID'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onLogin,
                child: const Text('Log in as Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
