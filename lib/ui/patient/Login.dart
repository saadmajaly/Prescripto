import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _WebLoginPageState createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text("Mobile Login Page"),
      ),
    );
  }
}
