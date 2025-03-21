import 'package:prescripto/data/database.dart';
import 'package:drift/drift.dart'; // For Value<T> and other Drift features

class PatientsBackEnd {
  final AppDatabase db;

  PatientsBackEnd(this.db);

  Future<List<User>> getAllPatients() async {
    final query = db.select(db.users);
    // ..where((u) => u.role.equals('patient'))
    return await query.get();
  }

  /// 1) Retrieve all users.
  ///    If [role] is provided, only users matching that role are returned.

  Future<List<User>> getAllUsers({String? role}) async {
    final query = await db.select(db.users);
    if (role != null) {
      query.where((u) => u.role.equals(role));
    }
    return await query.get();
  }

  /// 2) Search users by first or last name.
  ///    Uses a SQL "LIKE" query for partial matches.
  ///    If [role] is provided, only users with that role are searched.
  Future<List<User>> searchUsers(String query, {String? role}) async {
    final pattern = '%$query%';
    final selectQuery = db.select(db.users)
      ..where((u) => (u.firstName.like(pattern) | u.lastName.like(pattern)));
    if (role != null) {
      selectQuery.where((u) => u.role.equals(role));
    }
    return selectQuery.get();
  }

  /// 3) Get a single user by their user ID (primary key).
  Future<User?> getUserById(int userId) async {
    return (db.select(db.users)
          ..where((u) => u.id.equals(userId)))
        .getSingleOrNull();
  }

  /// 4a) Update a user's phone number.
  ///     Creates a copy of the [user] with the updated phone field
  ///     and updates it in the DB.
  Future<bool> updateUserPhone(User user, String newPhone) async {
    final updatedUser = user.copyWith(
      phone: Value(newPhone),
    );
    return db.updateUser(updatedUser);
  }

  /// 4b) Generic update for a user record.
  Future<bool> updateUser(User user) async {
    return db.updateUser(user);
  }

  /// 5) Create a new user record in the database.
  ///    Pass a UsersCompanion containing the new user's details.
  ///    If [role] is provided, it forces the new record to have that role.
  Future<int> createUser(UsersCompanion userData, {String? role}) async {
    if (role != null) {
      userData = userData.copyWith(role: Value(role));
    }
    return db.createUser(userData);
  }
}
