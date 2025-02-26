// database.dart

import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// -------------------------
// Table Definitions
// -------------------------

// USERS: Holds patients, physicians, pharmacists, and admin.
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().withLength(min: 1, max: 100)();
  TextColumn get phone => text().nullable().withLength(min: 1, max: 20)();
  TextColumn get nationalId => text().withLength(min: 1, max: 20)();
  // For physicians and pharmacists; null for patients/admin.
  TextColumn get syndicateNumber => text().nullable().withLength(min: 1, max: 20)();
  TextColumn get passwordHash => text()();
  // Role: 'patient', 'physician', 'pharmacist', 'admin'
  TextColumn get role => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// PHARMACIES: Stores pharmacy details.
class Pharmacies extends Table {
  IntColumn get pharmacyId => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get address => text().nullable().withLength(min: 1, max: 255)();
  TextColumn get phone => text().nullable().withLength(min: 1, max: 20)();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get acceptsInsurance => boolean().withDefault(const Constant(false))();
}

// MEDICATIONS: Master list of medications.
class Medications extends Table {
  IntColumn get medicationId => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable().withLength(min: 1, max: 255)();
  BoolColumn get controlledSubstance => boolean().withDefault(const Constant(false))();
}

// INVENTORY: Tracks stock of medications at each pharmacy.
class Inventory extends Table {
  IntColumn get inventoryId => integer().autoIncrement()();
  IntColumn get pharmacyId => integer()();
  IntColumn get medicationId => integer()();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
  IntColumn get reorderThreshold => integer().withDefault(const Constant(0))();
  RealColumn get price => real().withDefault(const Constant(0.0))();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(pharmacy_id) REFERENCES pharmacies(pharmacy_id)',
    'FOREIGN KEY(medication_id) REFERENCES medications(medication_id)'
  ];
}


// PRESCRIPTIONS: Records a prescription created by a physician.
class Prescriptions extends Table {
  IntColumn get prescriptionId => integer().autoIncrement()();
  IntColumn get patientId => integer()();
  IntColumn get physicianId => integer()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get status =>
      text().withDefault(const Constant('pending'))();
  TextColumn get instructions => text().nullable()();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(patient_id) REFERENCES users(id)',
    'FOREIGN KEY(physician_id) REFERENCES users(id)'
  ];
}


// PRESCRIPTION_ITEMS: Details of medications in a prescription.
class PrescriptionItems extends Table {
  IntColumn get itemId => integer().autoIncrement()();
  IntColumn get prescriptionId => integer()();
  IntColumn get medicationId => integer()();
  TextColumn get dosage => text().nullable().withLength(min: 1, max: 50)();
  TextColumn get frequency => text().nullable().withLength(min: 1, max: 50)();
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(prescription_id) REFERENCES prescriptions(prescription_id)',
    'FOREIGN KEY(medication_id) REFERENCES medications(medication_id)'
  ];
}

// FEEDBACKS: User feedback or support tickets.
class Feedbacks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get message => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(user_id) REFERENCES users(id)'
  ];
}

// AUDIT_LOGS: Records actions for compliance and auditing.
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get action => text()(); // e.g., "CREATE_PRESCRIPTION", "UPDATE_STATUS", etc.
  TextColumn get details => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(user_id) REFERENCES users(id)'
  ];
}

// EMERGENCY_ACCESS_REQUESTS: For emergency access approvals.
class EmergencyAccessRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer()();
  IntColumn get physicianId => integer()();
  TextColumn get reason => text()();
  // Status: 'pending', 'approved', 'rejected'
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(patient_id) REFERENCES users(id)',
    'FOREIGN KEY(physician_id) REFERENCES users(id)'
  ];
}

// INSURANCES: List of insurance companies.
class Insurances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get details => text()();
}

// PHARMACY_INSURANCES: Linking pharmacies with approved insurance providers.
class PharmacyInsurances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pharmacyId => integer()();
  IntColumn get insuranceId => integer()();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(pharmacy_id) REFERENCES pharmacies(pharmacy_id)',
    'FOREIGN KEY(insurance_id) REFERENCES insurances(id)'
  ];
}

// BLOCKCHAIN_TRANSACTIONS: Records blockchain data for controlled prescriptions.
class BlockchainTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get prescriptionId => integer()();
  TextColumn get transactionHash => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(prescription_id) REFERENCES prescriptions(prescription_id)'
  ];
}

// -------------------------
// Database Definition
// -------------------------

@DriftDatabase(tables: [
  Users,
  Pharmacies,
  Medications,
  Inventory,
  Prescriptions,
  PrescriptionItems,
  Feedbacks,
  AuditLogs,
  EmergencyAccessRequests,
  Insurances,
  PharmacyInsurances,
  BlockchainTransactions
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> clearDatabase(AppDatabase db) async {
    await db.transaction(() async {
      await db.delete(db.blockchainTransactions).go();
      await db.delete(db.pharmacyInsurances).go();
      await db.delete(db.insurances).go();
      await db.delete(db.emergencyAccessRequests).go();
      await db.delete(db.auditLogs).go();
      await db.delete(db.feedbacks).go();
      await db.delete(db.prescriptionItems).go();
      await db.delete(db.prescriptions).go();
      await db.delete(db.inventory).go();
      await db.delete(db.medications).go();
      await db.delete(db.pharmacies).go();
      await db.delete(db.users).go();
    });
  }


  // -------------------------
  // Data Population Method
  // -------------------------
  Future<void> populateTestData() async {
    final rand = Random();
    // Realistic names for Patients
      final List<String> patientFirstNames = [
        'John', 'Mary', 'Robert', 'Patricia', 'Michael',
        'Linda', 'William', 'Barbara', 'David', 'Elizabeth'
      ];
      final List<String> patientLastNames = [
        'Smith', 'Johnson', 'Williams', 'Jones', 'Brown',
        'Davis', 'Miller', 'Wilson', 'Moore', 'Taylor'
      ];

      // Realistic names for Physicians
      final List<String> doctorFirstNames = [
        'James', 'Jennifer', 'Charles', 'Susan', 'Joseph',
        'Margaret', 'Thomas', 'Dorothy', 'Christopher', 'Lisa'
      ];
      final List<String> doctorLastNames = [
        'Anderson', 'Thomas', 'Jackson', 'White', 'Harris',
        'Martin', 'Thompson', 'Garcia', 'Martinez', 'Robinson'
      ];

      // Realistic names for Pharmacists
      final List<String> pharmacistFirstNames = [
        'Karen', 'Steven', 'Nancy', 'Kevin', 'Betty',
        'Brian', 'Donna', 'Eric', 'Carol', 'Mark'
      ];
      final List<String> pharmacistLastNames = [
        'Clark', 'Lewis', 'Walker', 'Hall', 'Allen',
        'Young', 'King', 'Wright', 'Scott', 'Green'
      ];

      // --- Insert 200 Patients ---
      for (int i = 0; i < 200; i++) {
        final String firstName =
        patientFirstNames[rand.nextInt(patientFirstNames.length)];
        final String lastName =
        patientLastNames[rand.nextInt(patientLastNames.length)];
        await into(users).insert(
          UsersCompanion.insert(
            firstName: firstName,
            lastName: lastName,
            email: '${firstName.toLowerCase()}.${lastName.toLowerCase()}${i}@example.com',
            phone: Value('555-01${rand.nextInt(90).toString().padLeft(2, '0')}'),
            nationalId: 'NID-${100000000 + rand.nextInt(900000000)}',
            syndicateNumber: const Value(null),
            passwordHash: 'hashed_password',
            role: 'patient',
          ),
        );
      }

      // --- Insert 100 Physicians ---
      for (int i = 0; i < 100; i++) {
        final String firstName =
        doctorFirstNames[rand.nextInt(doctorFirstNames.length)];
        final String lastName =
        doctorLastNames[rand.nextInt(doctorLastNames.length)];
        await into(users).insert(
          UsersCompanion.insert(
            firstName: firstName,
            lastName: lastName,
            email: '${firstName.toLowerCase()}.${lastName.toLowerCase()}${i}@hospital.com',
            phone: Value('555-10${rand.nextInt(90).toString().padLeft(2, '0')}'),
            nationalId: 'NID-DOCTOR-${100000000 + rand.nextInt(900000000)}',
            syndicateNumber: Value('DOC-${1000 + i}'),
            passwordHash: 'hashed_password',
            role: 'physician',
          ),
        );
      }

      // --- Insert 100 Pharmacists ---
      for (int i = 0; i < 100; i++) {
        final String firstName =
        pharmacistFirstNames[rand.nextInt(pharmacistFirstNames.length)];
        final String lastName =
        pharmacistLastNames[rand.nextInt(pharmacistLastNames.length)];
        await into(users).insert(
          UsersCompanion.insert(
            firstName: firstName,
            lastName: lastName,
            email: '${firstName.toLowerCase()}.${lastName.toLowerCase()}${i}@pharmacy.com',
            phone: Value('555-20${rand.nextInt(90).toString().padLeft(2, '0')}'),
            nationalId: 'NID-PHARM-${100000000 + rand.nextInt(900000000)}',
            syndicateNumber: Value('PHARM-${1000 + i}'),
            passwordHash: 'hashed_password',
            role: 'pharmacist',
          ),
        );
      }

      // --- Insert 1 Admin ---
      await into(users).insert(
        UsersCompanion.insert(
          firstName: 'Admin',
          lastName: 'User',
          email: 'admin@example.com',
          phone: Value('555-999000'),
          nationalId: 'NID-ADMIN-1',
          syndicateNumber: const Value(null),
          passwordHash: 'hashed_admin',
          role: 'admin',
        ),
      );

      // --- Insert 50 Pharmacies ---
      final List<String> pharmacyNames = [
        'City Pharmacy', 'Downtown Pharmacy', 'Uptown Pharmacy', 'Community Pharmacy',
        'Central Pharmacy', 'Green Valley Pharmacy', 'Sunrise Pharmacy', 'Lakeside Pharmacy',
        'Riverside Pharmacy', 'Eastside Pharmacy'
      ];
      final List<String> pharmacyAddresses = [
        '123 Main St', '456 Broadway Ave', '789 Market St', '321 Center Plaza',
        '654 Oak St', '987 Pine Rd', '111 Maple Ave', '222 Cedar Ln',
        '333 Birch Blvd', '444 Elm St'
      ];

      for (int i = 0; i < 50; i++) {
        final String name =
            '${pharmacyNames[rand.nextInt(pharmacyNames.length)]} ${i + 1}';
        final String address =
            '${pharmacyAddresses[rand.nextInt(pharmacyAddresses.length)]}, City, Country';
        await into(pharmacies).insert(
          PharmaciesCompanion.insert(
            name: name,
            address: Value(address),
            phone: Value('555-300${rand.nextInt(900).toString().padLeft(3, '0')}'),
            latitude: Value(31.95 + rand.nextDouble() * 0.1),
            longitude: Value(35.90 + rand.nextDouble() * 0.1),
            acceptsInsurance: Value(i % 2 == 0),
          ),
        );
      }

      // --- Insert 10 Medications (Real Medications) ---
      final List<Map<String, dynamic>> meds = [
        {'name': 'Amoxicillin', 'description': 'Antibiotic for bacterial infections', 'controlled': false},
        {'name': 'Ibuprofen', 'description': 'Nonsteroidal anti-inflammatory drug', 'controlled': false},
        {'name': 'Clindamycin', 'description': 'Antibiotic used to treat infections', 'controlled': false},
        {'name': 'Morphine', 'description': 'Opioid for severe pain', 'controlled': true},
        {'name': 'Tramadol', 'description': 'Opioid analgesic for moderate pain', 'controlled': true},
        {'name': 'Metformin', 'description': 'Medication for type 2 diabetes', 'controlled': false},
        {'name': 'Lisinopril', 'description': 'Medication for high blood pressure', 'controlled': false},
        {'name': 'Atorvastatin', 'description': 'Cholesterol-lowering medication', 'controlled': false},
        {'name': 'Amlodipine', 'description': 'Calcium channel blocker for high blood pressure', 'controlled': false},
        {'name': 'Omeprazole', 'description': 'Proton pump inhibitor for acid reflux', 'controlled': false},
      ];
      for (var med in meds) {
        await into(medications).insert(
          MedicationsCompanion.insert(
            name: med['name'] as String,
            description: Value(med['description'] as String),
            controlledSubstance: Value(med['controlled'] as bool),
          ),
        );
      }

      // --- Insert Inventory for each Pharmacy & Medication ---
      final List<Pharmacy> pharmacyList = await select(pharmacies).get();
      final List<Medication> medicationList = await select(medications).get();
      for (var pharmacy in pharmacyList) {
        for (var med in medicationList) {
          await into(inventory).insert(
            InventoryCompanion.insert(
              pharmacyId: pharmacy.pharmacyId,
              medicationId: med.medicationId,
              quantity: Value(50 + rand.nextInt(50)), // between 50 and 99
              reorderThreshold: Value(10 + rand.nextInt(10)), // between 10 and 19
              price: Value(5.0 + rand.nextDouble() * 20.0), // between 5.0 and 25.0
            ),
          );
        }
      }

      // --- Insert 100 Prescriptions with 1-3 Prescription Items ---
      final List<User> patientList = await (select(users)
        ..where((tbl) => tbl.role.equals('patient')))
          .get();
      final List<User> physicianList = await (select(users)
        ..where((tbl) => tbl.role.equals('physician')))
          .get();
      for (int i = 0; i < 100; i++) {
        final patient = patientList[rand.nextInt(patientList.length)];
        final physician = physicianList[rand.nextInt(physicianList.length)];
        final int prescriptionId = await into(prescriptions).insert(
          PrescriptionsCompanion.insert(
            patientId: patient.id,
            physicianId: physician.id,
            status: Value('pending'),
            instructions: Value('Take with meals, preferably after food.'),
          ),
        );
        int itemsCount = 1 + rand.nextInt(3); // 1 to 3 items
        for (int j = 0; j < itemsCount; j++) {
          final med = medicationList[rand.nextInt(medicationList.length)];
          await into(prescriptionItems).insert(
            PrescriptionItemsCompanion.insert(
              prescriptionId: prescriptionId,
              medicationId: med.medicationId,
              dosage: Value('500 mg'),
              frequency: Value('3 times a day'),
              quantity: Value(10 + rand.nextInt(10)), // 10 to 19 units
            ),
          );
        }
      }

      // --- Insert 50 Feedback Entries with Realistic Messages ---
      final List<User> allUsers = await select(users).get();
      for (int i = 0; i < 50; i++) {
        final randomUser = allUsers[rand.nextInt(allUsers.length)];
        await into(feedbacks).insert(
          FeedbacksCompanion.insert(
            userId: randomUser.id,
            message: 'I, ${randomUser.firstName} ${randomUser.lastName}, am very satisfied with the service.',
          ),
        );
      }

      // --- Insert 100 Audit Logs with Realistic Details ---
      for (int i = 0; i < 100; i++) {
        final randomUser = allUsers[rand.nextInt(allUsers.length)];
        await into(auditLogs).insert(
          AuditLogsCompanion.insert(
            userId: randomUser.id,
            action: 'ACTION_$i',
            details: Value('User ${randomUser.firstName} ${randomUser.lastName} performed action $i.'),
          ),
        );
      }

      // --- Insert 20 Emergency Access Requests ---
      for (int i = 0; i < 20; i++) {
        final randomPatient = patientList[rand.nextInt(patientList.length)];
        final randomPhysician = physicianList[rand.nextInt(physicianList.length)];
        await into(emergencyAccessRequests).insert(
          EmergencyAccessRequestsCompanion.insert(
            patientId: randomPatient.id,
            physicianId: randomPhysician.id,
            reason: 'Emergency: Immediate access needed for ${randomPatient.firstName} ${randomPatient.lastName}.',
            status: Value('pending'),
          ),
        );
      }

      // --- Insert 5 Insurances with Realistic Details ---
      final List<String> insuranceCodes = ['A', 'B', 'C', 'D', 'E'];
      for (int i = 0; i < 5; i++) {
        await into(insurances).insert(
          InsurancesCompanion.insert(
            name: 'Insurance ${insuranceCodes[i]}',
            details: 'This insurance covers general health, dental, and vision services with a wide network of providers.',
          ),
        );
      }

      // --- Insert PharmacyInsurances: Each Pharmacy Gets 1-2 Random Insurances ---
      final List<Insurance> insuranceList = await select(insurances).get();
      for (var pharmacy in pharmacyList) {
        int count = 1 + rand.nextInt(2);
        for (int i = 0; i < count; i++) {
          final ins = insuranceList[rand.nextInt(insuranceList.length)];
          await into(pharmacyInsurances).insert(
            PharmacyInsurancesCompanion.insert(
              pharmacyId: pharmacy.pharmacyId,
              insuranceId: ins.id,
            ),
          );
        }
      }

      // --- Insert 30 Blockchain Transactions for Prescriptions with Controlled Medications ---
      final List<Prescription> prescriptionList = await select(prescriptions).get();
      for (int i = 0; i < 30; i++) {
        final pres = prescriptionList[rand.nextInt(prescriptionList.length)];
        await into(blockchainTransactions).insert(
          BlockchainTransactionsCompanion.insert(
            prescriptionId: pres.prescriptionId,
            transactionHash: '0x${rand.nextInt(1000000).toRadixString(16)}',
          ),
        );
      }
    }

  }

// -------------------------
// Database Connection Helper
// -------------------------

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'prescripto.sqlite'));
    return NativeDatabase(file);
  });
}

// -------------------------
// Main Function for Testing
// -------------------------

Future<void> main() async {
  final db = AppDatabase();
  await db.populateTestData();
  print('Test data populated successfully.');

  // Verify a count (e.g., total users)
  final userCount = (await db.select(db.users).get()).length;
  print('Total users: $userCount');
}
