import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Help/Help.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';
import 'package:prescripto/physician/Home/HomeBackEnd.dart';
import 'package:prescripto/data/database.dart';
import 'package:fl_chart/fl_chart.dart';

/// Main screen for physician user with dynamic data loading
class physicianHome extends StatefulWidget {
  const physicianHome({Key? key}) : super(key: key);

  @override
  _PhysicianHomeState createState() => _PhysicianHomeState();
}

class _PhysicianHomeState extends State<physicianHome> {
  final HomeBackend _backend = HomeBackend();
  late Future<HomeStats> _statsFuture;
  late Future<List<Prescription>> _recentFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture = _backend.fetchStats();
    _recentFuture = _backend.fetchRecentPrescriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          // Sidebar navigation panel
          Container(
            width: 200,
            color: Colors.indigo[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/PrescriptoLogo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                _buildNavTile(Icons.home, 'Home', () {}),
                _buildNavTile(Icons.edit, 'New Prescriptions', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => NewPrescription()));
                }),
                _buildNavTile(Icons.person, 'Patients', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Patients()));
                }),
                _buildNavTile(Icons.feedback, 'Feedback', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => FeedbackScreen()));
                }),
                _buildNavTile(Icons.help, 'Help', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HelpPage()));
                }),
                _buildNavTile(Icons.logout_outlined, 'Log out', () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const WebLoginPage()),
                    (route) => false,
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  FutureBuilder<HomeStats>(
                    future: _statsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final stats = snapshot.data!;
                      return Row(
                        children: [
                          StatCard(
                            title: 'Number of patients',
                            value: stats.patientCount.toString(),
                            footnote: 'as of today',
                            topRightIcon: Icons.people,
                          ),
                          const SizedBox(width: 20),
                          StatCard(
                            title: 'Prescriptions',
                            value: stats.prescriptionCount.toString(),
                            footnote: 'updated hourly',
                            topRightIcon: Icons.medical_services,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: _buildChart()),
                        const SizedBox(width: 20),
                        Expanded(flex: 2, child: _buildPlaceholder(height: 180, label: 'Productivity Chart')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: FutureBuilder<List<Prescription>>(
                      future: _recentFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        final prescriptions = snapshot.data!;
                        return RecentPrescriptions(prescriptions: prescriptions);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }

  Widget _buildChart() {
    return Container(
      height: 180,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 1.5),
                FlSpot(2, 1.4),
                FlSpot(3, 3.4),
                FlSpot(4, 2),
                FlSpot(5, 2.2),
                FlSpot(6, 1.8),
              ],
              isCurved: true,
       color: Colors.indigo,
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String footnote;
  final IconData topRightIcon;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.footnote,
    required this.topRightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(topRightIcon, size: 20, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            footnote,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class RecentPrescriptions extends StatelessWidget {
  final List<Prescription> prescriptions;

  const RecentPrescriptions({Key? key, required this.prescriptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search prescriptions',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                final item = prescriptions[index];
                return ListTile(
                  leading: const Icon(Icons.description, color: Colors.indigo),
                  title: Text('#${item.prescriptionId}'),
                  subtitle: Text('Created ${item.createdAt}'),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPlaceholder({required double height, required String label}) {
  return Container(
    height: height,
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Center(child: Text(label, style: const TextStyle(color: Colors.grey))),
  );
}
