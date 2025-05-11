import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Future<Either<Failure, void>> createAppointmentForDoctor({
    required String doctorId,
    required String date,
    required String time,
  }) async {
    try {
      final appointmentId =
          FirebaseFirestore.instance.collection('appointments').doc().id;
      final clientId = FirebaseAuth.instance.currentUser!.uid;



      await _saveAppointmentUnderDoctor(
        doctorId: doctorId,
        appointmentId: appointmentId,
        clientId: clientId,
        date: date,
        time: time,
      );

      await _saveAppointmentGlobally(
        doctorId: doctorId,
        appointmentId: appointmentId,
        clientId: clientId,
        date: date,
        time: time,
      );

      return right(null);
    } catch (e) {
      print('AppointmentRepository.createAppointmentForDoctor ERROR: $e');

      return left(ServerFailure(catchError: e));
    }
  }

  Future<void> _saveAppointmentUnderDoctor({
    required String doctorId,
    required String appointmentId,
    required String clientId,
    required String date,
    required String time,
  }) async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorId)
        .collection('appointments')
        .doc(appointmentId)
        .set({
      'clientId': clientId,
      'date': date,
      'time': time,
      'status': 'pending',
    });
  }

  Future<void> _saveAppointmentGlobally({
    required String doctorId,
    required String appointmentId,
    required String clientId,
    required String date,
    required String time,
  }) async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .set({
      'doctorId': doctorId,
      'clientId': clientId,
      'date': date,
      'time': time,
      'status': 'pending',
    });
  }
}
