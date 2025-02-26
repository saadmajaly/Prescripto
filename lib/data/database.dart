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

  // -------------------------
  // Data Population Method
  // -------------------------
  Future<void> populateTestData() async {
    final rand = Random();

    // Insert 200 patients
    for (int i = 0; i < 200; i++) {
      await into(users).insert(UsersCompanion.insert(
        firstName: 'PatientFirst$i',
        lastName: 'PatientLast$i',
        email: 'patient$i@example.com',
        phone: Value('555-000${i.toString().padLeft(3, '0')}'),
        nationalId: 'NID-PATIENT-$i',
        syndicateNumber: const Value(null),
        passwordHash: 'hashed_password',
        role: 'patient',
      ));
    }

    // Insert 100 physicians
    for (int i = 0; i < 100; i++) {
      await into(users).insert(UsersCompanion.insert(
        firstName: 'DoctorFirst$i',
        lastName: 'DoctorLast$i',
        email: 'doctor$i@example.com',
        phone: Value('555-100${i.toString().padLeft(3, '0')}'),
        nationalId: 'NID-DOCTOR-$i',
        syndicateNumber: Value('DOC-$i'),
        passwordHash: 'hashed_password',
        role: 'physician',
      ));
    }

    // Insert 100 pharmacists
    for (int i = 0; i < 100; i++) {
      await into(users).insert(UsersCompanion.insert(
        firstName: 'PharmacistFirst$i',
        lastName: 'PharmacistLast$i',
        email: 'pharmacist$i@example.com',
        phone: Value('555-200${i.toString().padLeft(3, '0')}'),
        nationalId: 'NID-PHARMACIST-$i',
        syndicateNumber: Value('PHARM-$i'),
        passwordHash: 'hashed_password',
        role: 'pharmacist',
      ));
    }

    // Insert 1 admin
    await into(users).insert(UsersCompanion.insert(
      firstName: 'Admin',
      lastName: 'User',
      email: 'admin@example.com',
      phone: Value('555-999000'),
      nationalId: 'NID-ADMIN-1',
      syndicateNumber: const Value(null),
      passwordHash: 'hashed_admin',
      role: 'admin',
    ));

    // Insert 50 pharmacies
    for (int i = 0; i < 50; i++) {
      await into(pharmacies).insert(PharmaciesCompanion.insert(
        name: 'Pharmacy $i',
        address: Value('Address of Pharmacy $i'),
        phone: Value('555-300${i.toString().padLeft(3, '0')}'),
        latitude: Value(31.95 + rand.nextDouble()),
        longitude: Value(35.90 + rand.nextDouble()),
        acceptsInsurance: Value(i % 2 == 0),
      ));
    }

    // Insert 10 medications
    final List<Map<String, dynamic>> meds = [
      {'name': 'Amoxicillin', 'description': 'Antibiotic', 'controlled': false},
      {'name': 'Ibuprofen', 'description': 'Pain reliever', 'controlled': false},
      {'name': 'Clindamycin', 'description': 'Antibiotic', 'controlled': false},
      {'name': 'Morphine', 'description': 'Opioid pain medication', 'controlled': true},
      {'name': 'Tramadol', 'description': 'Opioid analgesic', 'controlled': true},
      {'name': 'Metformin', 'description': 'Diabetes medication', 'controlled': false},
      {'name': 'Lisinopril', 'description': 'Blood pressure medication', 'controlled': false},
      {'name': 'Atorvastatin', 'description': 'Cholesterol management', 'controlled': false},
      {'name': 'Amlodipine', 'description': 'Blood pressure medication', 'controlled': false},
      {'name': 'Omeprazole', 'description': 'Acid reflux medication', 'controlled': false},
    ];
    for (var med in meds) {
      await into(medications).insert(MedicationsCompanion.insert(
        name: med['name'] as String,
        description: Value(med['description'] as String),
        controlledSubstance: Value(med['controlled'] as bool),
      ));
    }

    // Insert inventory: for each pharmacy and each medication.
    final pharmacyList = await select(pharmacies).get();
    final medicationList = await select(medications).get();
    for (var pharmacy in pharmacyList) {
      for (var med in medicationList) {
        await into(inventory).insert(InventoryCompanion.insert(
          pharmacyId: pharmacy.pharmacyId,
          medicationId: med.medicationId,
          quantity: Value(rand.nextInt(100)), // 0-99
          reorderThreshold: Value(10 + rand.nextInt(10)), // 10-19
          price: Value(5.0 + rand.nextDouble() * 20.0), // 5.0 to 25.0
        ));
      }
    }

    // Insert 100 prescriptions with 1-3 items each.
    final List<User> patientList = await (select(users)
      ..where((tbl) => tbl.role.equals('patient')))
        .get();
    final List<User> physicianList = await (select(users)
      ..where((tbl) => tbl.role.equals('physician')))
        .get();
    for (int i = 0; i < 100; i++) {
      final patient = patientList[rand.nextInt(patientList.length)];
      final physician = physicianList[rand.nextInt(physicianList.length)];
      final prescriptionId = await into(prescriptions).insert(PrescriptionsCompanion.insert(
        patientId: patient.id,
        physicianId: physician.id,
        status: Value('pending'),
        instructions: Value('Take with meals'),
      ));
      int itemsCount = 1 + rand.nextInt(3); // 1-3 items
      for (int j = 0; j < itemsCount; j++) {
        final med = medicationList[rand.nextInt(medicationList.length)];
        await into(prescriptionItems).insert(PrescriptionItemsCompanion.insert(
          prescriptionId: prescriptionId,
          medicationId: med.medicationId,
          dosage: Value('500 mg'),
          frequency: Value('3 times a day'),
          quantity: Value(10 + rand.nextInt(10)), // 10-19
        ));
      }
    }

    // Insert 50 feedback entries.
    for (int i = 0; i < 50; i++) {
      final randomUserId = (await select(users).get()).elementAt(rand.nextInt(400)).id;
      await into(feedbacks).insert(FeedbacksCompanion.insert(
        userId: randomUserId,
        message: 'Feedback message $i',
      ));
    }

    // Insert 100 audit logs.
    for (int i = 0; i < 100; i++) {
      final randomUserId = (await select(users).get()).elementAt(rand.nextInt(400)).id;
      await into(auditLogs).insert(AuditLogsCompanion.insert(
        userId: randomUserId,
        action: 'ACTION_$i',
        details: Value('Details for action $i'),
      ));
    }

    // Insert 20 emergency access requests.
    for (int i = 0; i < 20; i++) {
      final randomPatient = patientList[rand.nextInt(patientList.length)];
      final randomPhysician = physicianList[rand.nextInt(physicianList.length)];
      await into(emergencyAccessRequests).insert(EmergencyAccessRequestsCompanion.insert(
        patientId: randomPatient.id,
        physicianId: randomPhysician.id,
        reason: 'Emergency access reason $i',
        status: Value('pending'),
      ));
    }

    // Insert 5 insurances.
    for (int i = 0; i < 5; i++) {
      await into(insurances).insert(InsurancesCompanion.insert(
        name: 'Insurance $i',
        details: 'Details for Insurance $i',
      ));
    }

    // Insert PharmacyInsurances: assign each pharmacy 1-2 random insurances.
    final List<Insurance> insuranceList = await select(insurances).get();
    for (var pharmacy in pharmacyList) {
      int count = 1 + rand.nextInt(2);
      for (int i = 0; i < count; i++) {
        final ins = insuranceList[rand.nextInt(insuranceList.length)];
        await into(pharmacyInsurances).insert(PharmacyInsurancesCompanion.insert(
          pharmacyId: pharmacy.pharmacyId,
          insuranceId: ins.id,
        ));
      }
    }

    // Insert 30 blockchain transactions for prescriptions that include a controlled medication.
    final List<Prescription> prescriptionList = await select(prescriptions).get();
    for (int i = 0; i < 30; i++) {
      final pres = prescriptionList[rand.nextInt(prescriptionList.length)];
      // For simplicity, we assume a transaction is created for a random prescription.
      await into(blockchainTransactions).insert(BlockchainTransactionsCompanion.insert(
        prescriptionId: pres.prescriptionId,
        transactionHash: '0x${rand.nextInt(1000000).toRadixString(16)}',
      ));
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
