// lib/Admin/AdminHomePage.dart
import 'package:flutter/material.dart';
import 'package:prescripto/Admin/EditUser.dart';
import 'package:prescripto/data/database.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final db = AppDatabase();
  final _searchCtrl = TextEditingController();
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers([String? query]) {
    setState(() {
      if (query == null || query.isEmpty) {
        _futureUsers = db.getAllUsers();
      } else {
        _futureUsers = db.searchUsers(query);
      }
    });
  }

  Future<void> _deleteUser(User u) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete ${u.firstName} ${u.lastName}?'),
        content: Text('This will permanently remove the user.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true),  child: Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      await db.deleteUser(u.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted ${u.firstName} ${u.lastName}')),
      );
      _loadUsers(_searchCtrl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin • Manage Users'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                labelText: 'Search users by name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _loadUsers(_searchCtrl.text),
                ),
              ),
              onSubmitted: (_) => _loadUsers(_searchCtrl.text),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<User>>(
              future: _futureUsers,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                final users = snapshot.data ?? [];
                if (users.isEmpty) {
                  return Center(child: Text('No users found.'));
                }
                return ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (ctx, i) {
                    final u = users[i];
                    return ListTile(
                      title: Text('${u.firstName} ${u.lastName}'),
                      subtitle: Text('${u.role} • ${u.email}'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (choice) {
                          if (choice == 'edit') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => EditUserPage(user: u,)),
                            );
                          } else if (choice == 'delete') {
                            _deleteUser(u);
                          }
                        },
                        itemBuilder: (_) => [
                          PopupMenuItem(value: 'edit',   child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
