import 'package:prescripto/data/database.dart';
import 'package:drift/drift.dart';

class PrescriptionService {
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
    required int physicianId,
    required String instructions,
    required List<Map<String, dynamic>> medications, required String pharmacyAddress, required String pharmacyName,
  }) async {
    try {
      // أولاً: نضيف سجّل الوصفة الرئيسي في جدول Prescriptions
      final prescriptionId = await db.into(db.prescriptions).insert(
        PrescriptionsCompanion.insert(
          patientId: patientId,
          physicianId: physicianId,
          instructions: Value(instructions),
          // بإمكانك إضافة حقول أخرى مثل status إذا لزم الأمر
        ),
      );

      // ثانيًا: نضيف العناصر (الأدوية) في جدول PrescriptionItems
      for (final med in medications) {
        await db.into(db.prescriptionItems).insert(
          PrescriptionItemsCompanion.insert(
            prescriptionId: prescriptionId,
            medicationId: med['medicationId'] as int,
            dosage: Value(med['dosage'] as String),
            frequency: Value(med['frequency'] as String),
            quantity: Value(med['quantity'] as int),
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
