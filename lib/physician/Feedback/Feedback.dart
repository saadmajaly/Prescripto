import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';
import 'package:prescripto/physician/Home/HomeBackEnd.dart';
import 'package:prescripto/data/database.dart';
class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    String feedback = _feedbackController.text;
    if (feedback.isNotEmpty) {
      // Process feedback (e.g., send to backend)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted successfully!')),
      );
      _feedbackController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter feedback before submitting.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We value your feedback!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your feedback here...',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}