import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: const [
        Text('Pharmacist Help & Instructions',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        SizedBox(height: 24),
        Text('1. Reviewing Prescriptions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 8),
        Text(
          '- Go to Home.\n'
              '- Tap “Review” on a pending prescription.\n'
              '- Follow on-screen instructions to Approve or Reject.',
        ),
        SizedBox(height: 24),
        Text('2. Managing Inventory',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 8),
        Text(
          '- Use the search bar on Inventory.\n'
              '- Tap Edit to update stock, price, thresholds.',
        ),
        SizedBox(height: 24),
        Text('3. General Tips',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 8),
        Text(
          '- Keep data current.\n'
              '- Use secure credentials.\n'
              '- Log out when done.',
        ),
        SizedBox(height: 24),
        Text('Need Help?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 8),
        Text('Contact your IT administrator for further assistance.'),
      ],
    );
  }
}
