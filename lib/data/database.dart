import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift_hrana/drift_hrana.dart';
import 'package:flutter/foundation.dart';

part 'database.g.dart';

// USERS: Holds patients, physicians, pharmacists, and admin.
class Users extends Table {
  IntColumn get id               => integer().autoIncrement()();
  TextColumn get firstName       => text().withLength(min: 1, max: 50)();
  TextColumn get lastName        => text().withLength(min: 1, max: 50)();
  TextColumn get email           => text().withLength(min: 1, max: 100)();
  TextColumn get phone           => text().withLength(min: 1, max: 20)();
  TextColumn get nationalId      => text().withLength(min: 1, max: 20)();
  TextColumn get syndicateNumber => text().nullable().withLength(min: 1, max: 20)();
  TextColumn get passwordHash    => text()();
  TextColumn get role            => text()();
  DateTimeColumn get createdAt   => dateTime().withDefault(currentDateAndTime)();
}

class Pharmacies extends Table {
  IntColumn get pharmacyId        => integer().autoIncrement()();
  TextColumn get name             => text().withLength(min: 1, max: 100)();
  TextColumn get address          => text().nullable().withLength(min: 1, max: 255)();
  TextColumn get phone            => text().nullable().withLength(min: 1, max: 20)();
  RealColumn get latitude         => real().nullable()();
  RealColumn get longitude        => real().nullable()();
  BoolColumn get acceptsInsurance => boolean().withDefault(const Constant(false))();
}

class Pharmacist extends Table {
  IntColumn get id               => integer().autoIncrement()();
  IntColumn get pharmacyId       => integer()();
  IntColumn get pharmacistId     => integer()();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(pharmacy_id)    REFERENCES pharmacies(pharmacy_id)',
    'FOREIGN KEY(pharmacist_id)  REFERENCES users(id)'
  ];
}

// MEDICATIONS: Master list of medications.
class Medications extends Table {
  IntColumn get medicationId        => integer().autoIncrement()();
  TextColumn get name               => text().withLength(min: 1, max: 100)();
  TextColumn get description        => text().nullable().withLength(min: 1, max: 255)();
  BoolColumn get controlledSubstance=> boolean().withDefault(const Constant(false))();
}

// INVENTORY: Tracks stock of medications at each pharmacy.
class Inventory extends Table {
  IntColumn get inventoryId      => integer().autoIncrement()();
  IntColumn get pharmacyId       => integer()();
  IntColumn get medicationId     => integer()();
  IntColumn get quantity         => integer().withDefault(const Constant(0))();
  IntColumn get reorderThreshold => integer().withDefault(const Constant(0))();
  RealColumn get price           => real().withDefault(const Constant(0.0))();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(pharmacy_id)    REFERENCES pharmacies(pharmacy_id)',
    'FOREIGN KEY(medication_id)  REFERENCES medications(medication_id)'
  ];
}

// PRESCRIPTIONS: Records a prescription created by a physician.
class Prescriptions extends Table {
  IntColumn get prescriptionId  => integer().autoIncrement()();
  IntColumn get patientId       => integer()();
  IntColumn get physicianId     => integer()();
  IntColumn get pharmacyId      => integer().nullable()();
  DateTimeColumn get createdAt  => dateTime().withDefault(currentDateAndTime)();

  TextColumn get status         => text().withDefault(const Constant('pending'))();
  // four status
  // pending => sent from the physician and pending with the patient or rejected from the pharmacy
  // waiting => Sent to the pharmacy and waiting for approval or decline
  // accepted => Accepted by a phramacist and waiting for dispense
  // dispensed => the patient picked up the prescription
  TextColumn get instructions   => text().nullable()();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(patient_id)     REFERENCES users(id)',
    'FOREIGN KEY(physician_id)   REFERENCES users(id)'
  ];
}

class PrescriptionItems extends Table {
  IntColumn get itemId          => integer().autoIncrement()();
  IntColumn get prescriptionId  => integer()();
  IntColumn get medicationId    => integer()();
  TextColumn get dosage         => text().nullable().withLength(min: 1, max: 50)();
  TextColumn get frequency      => text().nullable().withLength(min: 1, max: 50)();
  IntColumn get quantity        => integer().withDefault(const Constant(1))();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(prescription_id) REFERENCES prescriptions(prescription_id)',
    'FOREIGN KEY(medication_id)   REFERENCES medications(medication_id)'
  ];
}

// FEEDBACKS: User feedback or support tickets.
class Feedbacks extends Table {
  IntColumn get id              => integer().autoIncrement()();
  IntColumn get userId          => integer()();
  TextColumn get message        => text()();
  DateTimeColumn get createdAt  => dateTime().withDefault(currentDateAndTime)();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(user_id)        REFERENCES users(id)'
  ];
}

// AUDIT_LOGS: Records actions for compliance and auditing.
class AuditLogs extends Table {
  IntColumn get id              => integer().autoIncrement()();
  IntColumn get userId          => integer()();
  TextColumn get action         => text()();
  TextColumn get details        => text().nullable()();
  DateTimeColumn get createdAt  => dateTime().withDefault(currentDateAndTime)();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(user_id)        REFERENCES users(id)'
  ];
}

// EMERGENCY_ACCESS_REQUESTS: For emergency access approvals.
class EmergencyAccessRequests extends Table {
  IntColumn get id              => integer().autoIncrement()();
  IntColumn get patientId       => integer()();
  IntColumn get physicianId     => integer()();
  TextColumn get reason         => text()();
  TextColumn get status         => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt  => dateTime().withDefault(currentDateAndTime)();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(patient_id)     REFERENCES users(id)',
    'FOREIGN KEY(physician_id)   REFERENCES users(id)'
  ];
}

// INSURANCES: List of insurance companies.
class Insurances extends Table {
  IntColumn get id              => integer().autoIncrement()();
  TextColumn get name           => text().withLength(min: 1, max: 100)();
  TextColumn get details        => text()();
}

// PHARMACY_INSURANCES: Linking pharmacies with approved insurance providers.
class PharmacyInsurances extends Table {
  IntColumn get id              => integer().autoIncrement()();
  IntColumn get pharmacyId      => integer()();
  IntColumn get insuranceId     => integer()();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(pharmacy_id)    REFERENCES pharmacies(pharmacy_id)',
    'FOREIGN KEY(insurance_id)   REFERENCES insurances(id)'
  ];
}

// BLOCKCHAIN_TRANSACTIONS: Records blockchain data for controlled prescriptions.
class BlockchainTransactions extends Table {
  IntColumn get id              => integer().autoIncrement()();
  IntColumn get prescriptionId  => integer()();
  TextColumn get transactionHash=> text()();
  DateTimeColumn get createdAt  => dateTime().withDefault(currentDateAndTime)();
  @override
  List<String> get customConstraints => [
    'FOREIGN KEY(prescription_id) REFERENCES prescriptions(prescription_id)'
  ];
}

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
  BlockchainTransactions,
  Pharmacist,
])
class AppDatabase extends _$AppDatabase {
  // Create a private static instance
  static final AppDatabase _instance = AppDatabase._internal();

  AppDatabase._internal()
      : super(

    HranaDatabase(Uri.parse('ws://${kIsWeb || !Platform.isAndroid ? 'localhost' : '10.0.2.2'}:8080/',)),
  );

  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 2;

  // ------------------- Users CRUD OPS -----------------------------

  Future<int> createUser(UsersCompanion user) async {
    return await into(users).insert(user);
  }

  Future<bool> validatePassword(String NatId, String HashedPassword) async {
    final user = await (select(users)
      ..where((u) => u.nationalId.equals(NatId)))
        .getSingleOrNull();
    return user?.passwordHash == HashedPassword;
  }

  Future<List<User>> getAllUsers() async {
    return await select(users).get();
  }

  Future<List<User>> getAllPatients() async {
    return await (select(users)
      ..where((u) => u.role.equals("patient")))
        .get();
  }

  Future<User?> getUserByNatID(String NatID) async {
    return await (select(users)
      ..where((u) => u.nationalId.equals(NatID)))
        .getSingleOrNull();
  }

  Future<bool> updateUser(User user) async {
    return await update(users).replace(user);
  }

  Future<int> deleteUser(int id) async {
    return await (delete(users)
      ..where((u) => u.id.equals(id)))
        .go();
  }

  Future<void> updateProfile(
      String nationalId,
      String newFirstName,
      String newLastName,
      String newEmail,
      String newPhoneNumber,
      ) async {
    final user = await (select(users)
      ..where((u) => u.nationalId.equals(nationalId)))
        .getSingleOrNull();

    if (user != null) {
      final updatedUser = user.copyWith(
        firstName: newFirstName,
        lastName: newLastName,
        email: newEmail,
        phone: newPhoneNumber,
      );

      await update(users).replace(updatedUser);
    }
  }

  Future<List<User>> searchUsers(String query, {String? role}) async {
    final pattern = '%\$query%';
    final selectQuery = select(users)
      ..where((u) => (u.firstName.like(pattern) | u.lastName.like(pattern)));
    if (role != null) {
      selectQuery.where((u) => u.role.equals(role));
    }
    return selectQuery.get();
  }

  // ------------------- Prescriptions CRUD OPS ----------------------

  Future<List<Prescription>> getAllPrescriptions() async {
    return await select(prescriptions).get();
  }

  Future<List<Prescription>> getUserPrescriptions(String NationalId) async {
    final LoggedUser = await (select(users)
      ..where((u) => u.nationalId.equals(NationalId)))
        .getSingle();
    final query = select(prescriptions)
      ..where((p) => p.patientId.equals(LoggedUser.id));
    return query.get();
  }
  Future<bool> sendPrescriptionToThePharmacy(int prescriptionId, int pharmacyId) async {
    final updated = await (update(prescriptions)
      ..where((tbl) => tbl.prescriptionId.equals(prescriptionId)))
        .write(PrescriptionsCompanion(
      status: Value("waiting"),
      pharmacyId: Value(pharmacyId),

    ));
    return updated > 0;
  }

  Future<bool> createNewPrescription(
      Prescription Prescription, String PatientNationalId) async {
    final user = await getUserByNatID(PatientNationalId);

    if (user == null) return false;

    final updatedPrescription = Prescription.copyWith(
      patientId: user.id,
    );
    await into(prescriptions).insert(updatedPrescription);
    return true;
  }

  Future<Prescription> getPrescription(int ID) async {
    return await (select(prescriptions)
      ..where((p) => p.prescriptionId.equals(ID)))
        .getSingle();
  }

  Future<List<PrescriptionItem>> getPrescriptionItems(int ID) async {
    return await (select(prescriptionItems)
      ..where((item) => item.prescriptionId.equals(ID)))
        .get();
  }

  Future<Medication> getMedicationInfo(int ID) async {
    return await (select(medications)
      ..where((med) => med.medicationId.equals(ID)))
        .getSingle();
  }

  // ------------------- Medicine CRUD OPS ---------------------------

  Future<List<Medication>> searchMedications(String query) async {
    final pattern = '%\$query%';
    return await (select(medications)
      ..where((m) =>
      m.name.like(pattern) | m.description.like(pattern)))
        .get();
  }

  Future<List<EmergencyAccessRequest>> getAllEmergencyAccessRequests() {
    return select(emergencyAccessRequests).get();
  }

  Future<int> updateEmergencyAccessRequestStatus(int requestId, String newStatus) {
    return (update(emergencyAccessRequests)
      ..where((tbl) => tbl.id.equals(requestId)))
        .write(
      EmergencyAccessRequestsCompanion(
        status: Value(newStatus),
      ),
    );
  }

  AppDatabase.forTesting(DatabaseConnection super.connection);

  Future<void> clearDatabase() async {
    await transaction(() async {
      await delete(pharmacyInsurances).go();
      await delete(pharmacist).go();
      await delete(inventory).go();
      await delete(prescriptionItems).go();
      await delete(blockchainTransactions).go();
      await delete(prescriptions).go();
      await delete(feedbacks).go();
      await delete(auditLogs).go();
      await delete(emergencyAccessRequests).go();
      await delete(insurances).go();
      await delete(medications).go();
      await delete(pharmacies).go();
      await delete(users).go();
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

    await into(users).insert(
      UsersCompanion.insert(
        firstName: "Test",
        lastName: "Test",
        email: 'test@example.com',
        phone: '555-01${rand.nextInt(90).toString().padLeft(2, "0")}',
        nationalId: '9999999999',
        syndicateNumber: const Value(null),
        passwordHash: 'test',
        role: 'patient',
      ),
    );
    // --- Insert 200 Patients ---
    // for (int i = 0; i < 200; i++) {
    //   await into(users).insert(
    //     UsersCompanion.insert(
    //       firstName: patientFirstNames[rand.nextInt(patientFirstNames.length)],
    //       lastName: patientLastNames[rand.nextInt(patientLastNames.length)],
    //       email: 'patient$i@example.com',
    //       phone: '555-00${rand.nextInt(90).toString().padLeft(2, "0")}',
    //       nationalId: 'P$i${rand.nextInt(100000)}',
    //       syndicateNumber: const Value(null),
    //       passwordHash: 'password',
    //       role: 'patient',
    //     ),
    //   );
    // }

    await into(users).insert(
      UsersCompanion.insert(
        firstName: "Physician",
        lastName: "Test",
        email: 'test@hospital.com',
        phone: '555-10${rand.nextInt(90).toString().padLeft(2, "0")}',
        nationalId: '8888888888',
        syndicateNumber: Value('DOC-2000'),
        passwordHash: 'test',
        role: 'physician',
      ),
    );
    // --- Insert 100 Physicians ---
    // for (int i = 0; i < 100; i++) {
    //   await into(users).insert(
    //     UsersCompanion.insert(
    //       firstName: doctorFirstNames[rand.nextInt(doctorFirstNames.length)],
    //       lastName: doctorLastNames[rand.nextInt(doctorLastNames.length)],
    //       email: 'physician$i@hospital.com',
    //       phone: '555-20${rand.nextInt(90).toString().padLeft(2, "0")}',
    //       nationalId: 'D$i${rand.nextInt(100000)}',
    //       syndicateNumber: Value('DOC-${1000 + i}'),
    //       passwordHash: 'password',
    //       role: 'physician',
    //     ),
    //   );
    // }

    await into(users).insert(
      UsersCompanion.insert(
        firstName: "Pharmacist",
        lastName: "Test",
        email: 'test@pharmacy.com',
        phone: '555-20${rand.nextInt(90).toString().padLeft(2, "0")}',
        nationalId: '7777777777',
        syndicateNumber: Value('PHARM-2000'),
        passwordHash: 'test',
        role: 'pharmacist',
      ),
    );
    // --- Insert 1 Admin ---
    await into(users).insert(
      UsersCompanion.insert(
        firstName: 'Admin',
        lastName: 'User',
        email: 'admin@example.com',
        phone: '555-999000',
        nationalId: '1111',
        syndicateNumber: const Value(null),
        passwordHash: '1111',
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

    for (int i = 0; i < 1; i++) {
      final name = '${pharmacyNames[rand.nextInt(pharmacyNames.length)]} $i';
      final address = '${pharmacyAddresses[rand.nextInt(pharmacyAddresses.length)]}, City, Country';
      await into(pharmacies).insert(
        PharmaciesCompanion.insert(
          name: name,
          address: Value(address),
          phone: Value('555-300${rand.nextInt(900).toString().padLeft(3, "0")}'),
          latitude: Value(31.95 + rand.nextDouble() * 0.1),
          longitude: Value(35.90 + rand.nextDouble() * 0.1),
          acceptsInsurance: Value(i % 2 == 0),
        ),
      );
    }

    // --- Insert 10 Medications ---
    final List<Map<String, dynamic>> meds = [
      {'name': 'Amoxicillin', 'description': 'Antibiotic for bacterial infections', 'controlled': false},
      {'name': 'Ibuprofen',    'description': 'Nonsteroidal anti-inflammatory drug', 'controlled': false},
      {'name': 'Clindamycin',  'description': 'Antibiotic used to treat infections', 'controlled': false},
      {'name': 'Morphine',     'description': 'Opioid for severe pain', 'controlled': true},
      {'name': 'Tramadol',     'description': 'Opioid analgesic for moderate pain', 'controlled': true},
      {'name': 'Metformin',    'description': 'Medication for type 2 diabetes', 'controlled': false},
      {'name': 'Lisinopril',   'description': 'Medication for high blood pressure', 'controlled': false},
      {'name': 'Atorvastatin', 'description': 'Cholesterol-lowering medication', 'controlled': false},
      {'name': 'Amlodipine',   'description': 'Calcium channel blocker for high blood pressure', 'controlled': false},
      {'name': 'Omeprazole',   'description': 'Proton pump inhibitor for acid reflux', 'controlled': false},
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

    // Assign Pharmacists to Pharmacies
    final allPharmacies   = await select(pharmacies).get();
    final allPharmacists  = await (select(users)..where((u) => u.role.equals('pharmacist'))).get();
    for (var pharmacy in allPharmacies) {
      final count = 1 + rand.nextInt(3);
      for (var i = 0; i < count; i++) {
        final pharm = allPharmacists[rand.nextInt(allPharmacists.length)];
        await into(pharmacist).insert(
          PharmacistCompanion.insert(
            pharmacyId: pharmacy.pharmacyId,
            pharmacistId: pharm.id,
          ),
        );
      }
    }

    // --- Insert Inventory for each Pharmacy & Medication ---
    final pharmacyList    = await select(pharmacies).get();
    final medicationList  = await select(medications).get();

    for (var med in medicationList) {
      final pharmacy = pharmacyList[rand.nextInt(pharmacyList.length)];
      await into(inventory).insert(
        InventoryCompanion.insert(
          pharmacyId:      pharmacy.pharmacyId,
          medicationId:    med.medicationId,
          quantity:        Value(50 + rand.nextInt(50)),
          reorderThreshold:Value(10 + rand.nextInt(10)),
          price:           Value(5.0 + rand.nextDouble() * 20.0),
        ),
      );
    }

    // --- Insert Prescriptions & Items ---
    final List<User> patientList   = await (select(users)..where((u) => u.role.equals('patient'))).get();
    final List<User> physicianList = await (select(users)..where((u) => u.role.equals('physician'))).get();
    // for (int i = 0; i < 20; i++) {
    //   final patient   = patientList[rand.nextInt(patientList.length)];
    //   final physician = physicianList[rand.nextInt(physicianList.length)];
    //   final int prescriptionId = await into(prescriptions).insert(
    //     PrescriptionsCompanion.insert(
    //       patientId: patient.id,
    //       physicianId: physician.id,
    //       status: Value('pending'),
    //       instructions: Value('Take with meals, preferably after food.'),
    //     ),
    //   );
    //   int itemsCount = 1 + rand.nextInt(3);
    //   for (int j = 0; j < itemsCount; j++) {
    //     final med = medicationList[rand.nextInt(medicationList.length)];
    //     await into(prescriptionItems).insert(
    //       PrescriptionItemsCompanion.insert(
    //         prescriptionId: prescriptionId,
    //         medicationId: med.medicationId,
    //         dosage: Value('500 mg'),
    //         frequency: Value('3 times a day'),
    //         quantity: Value(10 + rand.nextInt(10)),
    //       ),
    //     );
    //   }
    // }

    // --- Insert Feedback Entries ---
  //   final List<User> allUsers = await select(users).get();
  //   for (int i = 0; i < 50; i++) {
  //     final randomUser = allUsers[rand.nextInt(allUsers.length)];
  //     await into(feedbacks).insert(
  //       FeedbacksCompanion.insert(
  //         userId: randomUser.id,
  //         message: 'I, ${randomUser.firstName} ${randomUser.lastName}, am very satisfied with the service.',
  //       ),
  //     );
  //   }
  //
  //   // --- Insert Audit Logs ---
  //   for (int i = 0; i < 100; i++) {
  //     final randomUser = allUsers[rand.nextInt(allUsers.length)];
  //     await into(auditLogs).insert(
  //       AuditLogsCompanion.insert(
  //         userId: randomUser.id,
  //         action: 'ACTION_$i',
  //         details: Value('User ${randomUser.firstName} ${randomUser.lastName} performed action $i.'),
  //       ),
  //     );
  //   }
  //
  //   // --- Insert Emergency Access Requests ---
  //   for (int i = 0; i < 20; i++) {
  //     final randomPatient   = patientList[rand.nextInt(patientList.length)];
  //     final randomPhysician = physicianList[rand.nextInt(physicianList.length)];
  //     await into(emergencyAccessRequests).insert(
  //       EmergencyAccessRequestsCompanion.insert(
  //         patientId: randomPatient.id,
  //         physicianId: randomPhysician.id,
  //         reason: 'Emergency: Immediate access needed for ${randomPatient.firstName} ${randomPatient.lastName}.',
  //         status: Value('waiting'),
  //       ),
  //     );
  //   }
  //
  //   // --- Insert Insurances ---
  //   final List<String> insuranceCodes = ['A', 'B', 'C', 'D', 'E'];
  //   for (int i = 0; i < insuranceCodes.length; i++) {
  //     await into(insurances).insert(
  //       InsurancesCompanion.insert(
  //         name: 'Insurance ${insuranceCodes[i]}',
  //         details: 'This insurance covers general health, dental, and vision services with a wide network of providers.',
  //       ),
  //     );
  //   }
  //
  //   // --- Insert Pharmacy Insurances ---
  //   final List<Insurance> insuranceList = await select(insurances).get();
  //   for (var pharmacy in pharmacyList) {
  //     final count = 1 + rand.nextInt(2);
  //     for (int i = 0; i < count; i++) {
  //       final ins = insuranceList[rand.nextInt(insuranceList.length)];
  //       await into(pharmacyInsurances).insert(
  //         PharmacyInsurancesCompanion.insert(
  //           pharmacyId: pharmacy.pharmacyId,
  //           insuranceId: ins.id,
  //         ),
  //       );
  //     }
  //   }
  //   // --- Insert 30 Blockchain Transactions for Prescriptions with Controlled Medications ---
  //   final List<Prescription> prescriptionList = await select(prescriptions).get();
  //   for (int i = 0; i < 30; i++) {
  //     final pres = prescriptionList[rand.nextInt(prescriptionList.length)];
  //     await into(blockchainTransactions).insert(
  //       BlockchainTransactionsCompanion.insert(
  //         prescriptionId: pres.prescriptionId,
  //         transactionHash: '0x${rand.nextInt(1000000).toRadixString(16)}',
  //       ),
  //     );
  //   }
  }
}