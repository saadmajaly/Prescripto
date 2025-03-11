import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9), // Soft background color
      appBar: AppBar(
        title: const Text(
          'Patient home page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Header
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/UserPic.jpeg'),
                ),
                SizedBox(width: 16),
                Text(
                  'Hello, Chloe',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Next Medication Reminder
            Text(
              'Next Medication Reminder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      'assets/HomeMobile.png',
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lisinopril',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text('8:00 AM', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                        SizedBox(height: 4),
                        Text('Take with food', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Active Prescriptions
            Text(
              'Active Prescriptions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/MedicineLogo.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text('Metformin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('500mg, 2x daily', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/MedicineLogo.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text('Atorvasta', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('40mg, 1x daily', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20), // Extra space at bottom
          ],
        ),
      ),
    );
  }
}
