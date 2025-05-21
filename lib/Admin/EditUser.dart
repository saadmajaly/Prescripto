import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:prescripto/Admin/MainScreen.dart';
import 'package:prescripto/data/database.dart';

import 'AdminHome.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  const EditUserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late User _user;
  final _formKey = GlobalKey<FormState>();

  // Controllers for every editable field:
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _nationalIdCtrl;
  late final TextEditingController _syndicateCtrl;
  late final TextEditingController _passwordCtrl;

  // Role dropdown state
  final List<String> _roles = ['patient', 'physician', 'pharmacist', 'admin'];
  late String _selectedRole;

  final _db = AppDatabase();

  @override
  void initState() {
    super.initState();
    _user = widget.user;

    // Initialize controllers with existing values:
    _firstNameCtrl    = TextEditingController(text: _user.firstName);
    _lastNameCtrl     = TextEditingController(text: _user.lastName);
    _emailCtrl        = TextEditingController(text: _user.email);
    _phoneCtrl        = TextEditingController(text: _user.phone);
    _nationalIdCtrl   = TextEditingController(text: _user.nationalId);
    _syndicateCtrl    = TextEditingController(text: _user.syndicateNumber ?? '');
    _passwordCtrl     = TextEditingController(); // leave blank unless resetting
    _selectedRole     = _user.role;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _nationalIdCtrl.dispose();
    _syndicateCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    // Build updated user:
    final updated = _user.copyWith(
      firstName:       _firstNameCtrl.text,
      lastName:        _lastNameCtrl.text,
      email:           _emailCtrl.text,
      phone:           _phoneCtrl.text,
      nationalId:      _nationalIdCtrl.text,
      syndicateNumber: _syndicateCtrl.text.isNotEmpty
          ? Value(_syndicateCtrl.text)
          : const Value(null),
      passwordHash:    _passwordCtrl.text.isNotEmpty
          ? _passwordCtrl.text
          : _user.passwordHash,
      role:            _selectedRole,
      // createdAt is not editable, and id remains the same
    );

    await _db.updateUser(updated);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AdminMainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${_user.firstName}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameCtrl,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _lastNameCtrl,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),

              // Contact info..
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                v!.contains('@') ? null : 'Invalid email',
              ),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),

              // National ID & Syndicate
              TextFormField(
                controller: _nationalIdCtrl,
                decoration: const InputDecoration(labelText: 'National ID'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _syndicateCtrl,
                decoration: const InputDecoration(
                  labelText: 'Syndicate Number (if any)',
                ),
              ),

              // Roles list dropdown
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: 'Role'),
                items: _roles.map((r) =>
                    DropdownMenuItem(value: r, child: Text(r.capitalize()))
                ).toList(),
                onChanged: (r) {
                  if (r != null) setState(() => _selectedRole = r);
                },
              ),

              // Password reset
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'New Password (leave blank to keep)',
                ),
                obscureText: true,
              ),

              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
extension StringCasingExtension on String {
  String capitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
}
