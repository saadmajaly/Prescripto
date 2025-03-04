import 'package:flutter/material.dart';

class WebLoginPage extends StatefulWidget {
  @override
  _WebLoginPageState createState() => _WebLoginPageState();
}


class _WebLoginPageState extends State<WebLoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'https://via.placeholder.com/500x150',
                height: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to Prescripto',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Physician'),
                  Tab(text: 'Pharmacist'),
                ],
                labelColor: Colors.black,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'johndoe@prescripto.com',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Log in'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text('Forgot your password?'),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Don't have an account?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
