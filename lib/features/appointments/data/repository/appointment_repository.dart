import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_task/core/error/failure.dart';

import '../models/doctor_appointment_model.dart';
import 'appointment_repository_base.dart';

class AppointmentRepository extends AppointmentRepositoryBase {
  @override
  Future<Either<Failure, List<DoctorAppointmentModel>>> getDoctorAppointments(
      {required String doctorId}) async {
    try {

      final snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .collection('appointments')
          .get();
      final doctorAppointmentModel =
          snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, Object> combinedData = {
          'appointmentId': doc.id,
          'appointmentModel': doc.data(),
        };

        return DoctorAppointmentModel.fromJson(combinedData);
      }).toList();
      return right(doctorAppointmentModel);
    } catch (e) {
      print('DoctorListRepository.getAllDoctorsError $e');

      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getReservedTimeSlotsForDoctorOnDate({required String doctorId, required String date})async {
    try {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('date', isEqualTo: date)
          .get();

      final reservedTimeSlots = appointmentsSnapshot.docs
          .map((doc) => doc['time'] as String)
          .toList();

      return right(reservedTimeSlots);
    } catch (e) {
      print('AppointmentRepository.getReservedTimeSlotsForDoctorOnDate ERROR: $e');
      return left(ServerFailure(catchError: e));
    }
  }
}
