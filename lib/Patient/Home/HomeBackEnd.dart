import 'package:flutter/material.dart';

class HomeBackEnd with ChangeNotifier {
  // Example user data
  final String userName = "Chloe";
  final String userProfilePic = "assets/UserPic.jpeg";

  // Medication Reminder Data
  Map<String, dynamic> nextMedicationReminder = {
    "name": "Lisinopril",
    "time": "8:00 AM",
    "instructions": "Take with food",
    "image": "assets/HomeMobile.png",
  };

  // Active Prescriptions List
  List<Map<String, String>> activePrescriptions = [
    {
      "name": "Metformin",
      "dosage": "500mg, 2x daily",
      "image": "assets/MedicineLogo.jpg",
    },
    {
      "name": "Atorvasta",
      "dosage": "40mg, 1x daily",
      "image": "assets/MedicineLogo.jpg",
    },
  ];

  // Function to simulate fetching data from API
  Future<void> fetchHomeData() async {
    await Future.delayed(Duration(seconds: 2));
    // Here you would fetch data from API
    // Example:
    // final response = await http.get(Uri.parse('https://api.example.com/home'));
    // Parse and set data to nextMedicationReminder & activePrescriptions

    // After fetching, notify listeners to update UI
    notifyListeners();
  }

  // Function to refresh medication reminder (Example)
  void updateNextMedicationReminder(Map<String, dynamic> newReminder) {
    nextMedicationReminder = newReminder;
    notifyListeners();
  }

  // Function to add new prescription (Example)
  void addPrescription(Map<String, String> prescription) {
    activePrescriptions.add(prescription);
    notifyListeners();
  }

  // Function to remove a prescription (Example)
  void removePrescription(String name) {
    activePrescriptions.removeWhere((item) => item["name"] == name);
    notifyListeners();
  }
}
