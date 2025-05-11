import 'package:prescripto/data/database.dart';
import 'package:drift/drift.dart';
import 'package:prescripto/services/InfuraService.dart';

import '../../AuthLogic/AuthProvider.dart';

class PrescriptionService {
  // create instance from the integration service (Blockchain) that handles infura library
  static final InfuraService _infura = InfuraService();
  /// إحضار قائمة المرضى من قاعدة البيانات
  /// نفترض أنّ المرضى لهم دور (role = 'patient')
  static Future<List<Map<String, dynamic>>> fetchPatients(AppDatabase db) async {
    // ننفّذ استعلامًا لاختيار كل المستخدمين بدور patient
    final query = await (db.select(db.users)
      ..where((u) => u.role.equals('patient')))
        .get();

    // نعيد البيانات في شكل قائمة Map مع حقول نحتاجها للعرض
    return query.map((user) {
      return {
        'id': user.id,
        'name': '${user.firstName} ${user.lastName}',
      };
    }).toList();
  }

  /// إنشاء وصفة طبية جديدة وحفظها في قاعدة البيانات
  ///
  /// - [patientId]: رقم المريض
  /// - [physicianId]: رقم الطبيب (المستخدم الحالي)
  /// - [instructions]: تعليمات الوصفة
  /// - [medications]: قائمة بالأدوية المراد إدراجها في هذه الوصفة
  ///
  /// ترجع `true` إذا تمّ الحفظ بنجاح و `false` في حالة الخطأ
  static Future<bool> submitPrescription(
    AppDatabase db, {
    required int patientId,
    required String instructions,
    required List<Map<String, dynamic>> medications,
    required String pharmacyAddress,
    required String pharmacyName,
    required bool includesControlled,})
    async {

    try {
      var auth = new AuthProvider(db);
      var NatID = await auth.getLoggedInNationalID();
      var physician = (await db.getUserByNatID(NatID as String))!;
      // أولاً: نضيف سجّل الوصفة الرئيسي في جدول Prescriptions
      final prescriptionId = await db.into(db.prescriptions).insert(
        PrescriptionsCompanion.insert(
          patientId: patientId,
          physicianId: physician.id,
          instructions: Value(instructions),
          status: Value("pending"),
          // بإمكانك إضافة حقول أخرى مثل status إذا لزم الأمر
        ),
      );

      if (includesControlled) {
        try {
          final txHash = await _infura.logPrescriptionOnChain(
            from: '<YOUR_WALLET_ADDRESS>',       // ex: '0xAbC123…'
            to: '<YOUR_CONTRACT_OR_NULL>',       // optional
            prescriptionId: prescriptionId,
            patientId: patientId,
            includesControlled: true,

          );
          await db.into(db.blockchainTransactions).insert(
              BlockchainTransactionsCompanion.insert(
                prescriptionId: prescriptionId,
                transactionHash: txHash,
              ));
          print('Prescription logged on-chain: $txHash');
        } catch (e) {
          print('Blockchain logging failed: $e');
        }

      }
      // ثانيًا: نضيف العناصر (الأدوية) في جدول PrescriptionItems
      for (final med in medications) {
        // a) Create or fetch the medication row
        final medId = await db.into(db.medications).insert(
          MedicationsCompanion.insert(
            name: med['drugName']         as String,
            description: Value(med['description'] as String? ?? ''),
            controlledSubstance: Value(includesControlled),
          ),
        );

        // b) Now insert the item using that medId
        await db.into(db.prescriptionItems).insert(
          PrescriptionItemsCompanion.insert(
            prescriptionId: prescriptionId,
            medicationId:   medId,
            dosage:         Value(med['dosage']    as String),
            frequency:      Value(med['frequency'] as String),
            quantity:       Value(med['quantity']  as int),
          ),
        );
      }

      return true;
    } catch (e) {
      print('Error in submitPrescription: $e');
      return false;
    }
  }
}
