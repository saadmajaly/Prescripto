// lib/Admin/AdminReportsPage.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prescripto/data/database.dart';  // no changes here!

// Simple data holder
class RoleCount {
  final String label;
  final int count;
  RoleCount(this.label, this.count);
}

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({Key? key}) : super(key: key);
  @override
  _AdminReportsPageState createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage> {
  final db = AppDatabase();

  late Future<int> _totalUsers;
  late Future<List<RoleCount>> _usersByRole;
  late Future<List<RoleCount>> _presByStatus;
  late Future<List<RoleCount>> _emReqByStatus;

  @override
  void initState() {
    super.initState();
    _totalUsers    = _fetchTotalUsers();
    _usersByRole   = _fetchGrouped('users',   'role');
    _presByStatus  = _fetchGrouped('prescriptions',     'status');
    _emReqByStatus = _fetchGrouped('emergency_access_requests', 'status');
  }

  // Generic “COUNT(*)” helper
  Future<int> _fetchTotalUsers() async {
    final row = await db
        .customSelect('SELECT COUNT(*) AS cnt FROM users')
        .getSingle();
    return row.read<int>('cnt');
  }

  // Generic “GROUP BY” helper
  Future<List<RoleCount>> _fetchGrouped(String table, String column) async {
    final sql = 'SELECT $column AS label, COUNT(*) AS cnt '
        'FROM $table GROUP BY $column';
    final rows = await db.customSelect(sql).get();
    return rows
        .map((r) => RoleCount(r.read<String>('label'), r.read<int>('cnt')))
        .toList();
  }

  Widget _buildPieChart(String title, List<RoleCount> data) {
    final sections = data.map((e) {
      return PieChartSectionData(
        value: e.count.toDouble(),
        title: '${e.label} (${e.count})',
      );
    }).toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(
            height: 180,
            child: PieChart(PieChartData(sections: sections)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin • Reports')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<int>(
              future: _totalUsers,
              builder: (ctx, snap) {
                if (snap.connectionState != ConnectionState.done)
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  );
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total users: ${snap.data}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              },
            ),

            FutureBuilder<List<RoleCount>>(
              future: _usersByRole,
              builder: (ctx, snap) {
                if (!snap.hasData) return const SizedBox.shrink();
                return _buildPieChart('Users by Role', snap.data!);
              },
            ),

            FutureBuilder<List<RoleCount>>(
              future: _presByStatus,
              builder: (ctx, snap) {
                if (!snap.hasData) return const SizedBox.shrink();
                return _buildPieChart('Prescriptions by Status', snap.data!);
              },
            ),

            FutureBuilder<List<RoleCount>>(
              future: _emReqByStatus,
              builder: (ctx, snap) {
                if (!snap.hasData) return const SizedBox.shrink();
                return _buildPieChart('Emergency Requests by Status', snap.data!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
