// lib/physician/Home/physicianHome.dart

import 'package:flutter/material.dart';
import 'package:prescripto/CommonWeb/login_screen.dart';
import 'package:prescripto/physician/Feedback/Feedback.dart';
import 'package:prescripto/physician/Help/Help.dart';
import 'package:prescripto/physician/Patients/Patients.dart';
import 'package:prescripto/physician/Prescriptions/NewPrescription.dart';
import 'package:prescripto/physician/Home/HomeBackEnd.dart';
import 'package:prescripto/data/database.dart';
import 'package:fl_chart/fl_chart.dart';

class physicianHome extends StatefulWidget {
  const physicianHome({Key? key}) : super(key: key);

  @override
  _PhysicianHomeState createState() => _PhysicianHomeState();
}

class _PhysicianHomeState extends State<physicianHome> {
  final HomeBackend _backend = HomeBackend();
  late Future<HomeStats> _statsFuture;
  late Future<List<Prescription>> _recentFuture;
  late Future<List<int>> _patientCountsFuture;

  @override
  void initState() {
    super.initState();
    _statsFuture         = _backend.fetchStats();
    _recentFuture        = _backend.fetchRecentPrescriptions();
    _patientCountsFuture = _backend.fetchWeeklyPatientRegistrations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.indigo[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Image.asset('assets/PrescriptoLogo.png', fit: BoxFit.cover),
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

          // Main area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dashboard',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  // Stats cards
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
                            footnote: 'as of today',
                            topRightIcon: Icons.medical_services,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Charts row
                  Expanded(
                    child: Row(
                      children: [
                        // ← now shows patient bar chart
                        Expanded(flex: 2, child: _buildPatientChart()),
                        const SizedBox(width: 20),
                        // keeps your prescription‐count bar chart
                        Expanded(flex: 2, child: _buildProductivityChart()),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Recent prescriptions
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
    return ListTile(leading: Icon(icon), title: Text(label), onTap: onTap);
  }

 Widget _buildPatientChart() {
  return FutureBuilder<List<int>>(
    future: _patientCountsFuture,
    builder: (context, snap) {
      if (snap.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snap.hasError) {
        return Center(child: Text('Error: ${snap.error}'));
      }

      final counts = snap.data!;
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    if (idx < 0 || idx >= days.length) return const SizedBox();
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        days[idx],
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                ),
                axisNameWidget: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Number of Patients',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                axisNameSize: 32,
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barGroups: List.generate(counts.length, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: counts[i].toDouble(),
                    width: 16,
                    color: const Color(0xFF0D47A1),
                  ),
                ],
              );
            }),
          ),
        ),
      );
    },
  );
}

  }

  /// Your existing prescription‐count bar chart
  Widget _buildProductivityChart() {
    return Container(
      height: 180,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(days[value.toInt() % 7], style: const TextStyle(fontSize: 10));
                },
              ),
            ),
              leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: false,
 
  
    ),
    axisNameWidget: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        'Number of prescrption',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ),
    axisNameSize: 32,
  ),
  topTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  rightTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 3, color: Color(0xFF0D47A1))]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5 ,color: Color(0xFF0D47A1))]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 4,color: Color(0xFF0D47A1))]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 6,color: Color(0xFF0D47A1))]),
            BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 2,color: Color(0xFF0D47A1))]),
            BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 7,color: Color(0xFF0D47A1))]),
            BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 5,color: Color(0xFF0D47A1))]),
          ],
        ),
      ),
    );
  }


// ... keep StatCard and RecentPrescriptions classes unchanged ...


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
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(topRightIcon, size: 20, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            footnote,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class RecentPrescriptions extends StatefulWidget {
  final List<Prescription> prescriptions;

  const RecentPrescriptions({Key? key, required this.prescriptions}) : super(key: key);

  @override
  State<RecentPrescriptions> createState() => _RecentPrescriptionsState();
}

class _RecentPrescriptionsState extends State<RecentPrescriptions> {
  final HomeBackend _backend = HomeBackend();
  List<Prescription> _filtered = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _filtered = widget.prescriptions;
  }

  void _search(String query) async {
    setState(() => _loading = true);
    if (query.trim().isEmpty) {
      setState(() {
        _filtered = widget.prescriptions;
        _loading = false;
      });
    } else {
      final results = await _backend.searchPrescriptions(query);
      setState(() {
        _filtered = results;
        _loading = false;
      });
    }
  }

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
            onChanged: _search,
          ),
          const SizedBox(height: 16),
          _loading
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: _filtered.isEmpty
                      ? const Center(child: Text('No matching prescriptions found.'))
                      : ListView.builder(
                          itemCount: _filtered.length,
                          itemBuilder: (context, index) {
                            final item = _filtered[index];
                            return ListTile(
                              leading: const Icon(Icons.description, color: Color.fromARGB(255, 84, 108, 244)),
                              title: Text('#${item.prescriptionId}'),
                              subtitle: Text(item.instructions ?? 'No instructions'),
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
