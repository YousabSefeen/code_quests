import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task/core/error/failure.dart';

import '../../../doctor_profile/data/models/doctor_model.dart';
import '../models/client_appointments_model.dart';
import '../models/doctor_appointment_model.dart';
import 'appointment_repository_base.dart';

class AppointmentRepository extends AppointmentRepositoryBase {
  @override
  Future<Either<Failure, List<DoctorAppointmentModel>>> fetchDoctorAppointments(
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
  Future<Either<Failure, List<String>>> fetchReservedTimeSlotsForDoctorOnDate(
      {required String doctorId, required String date}) async {
    try {

      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('appointmentDate', isEqualTo: date)
          .get();

      final reservedTimeSlots = appointmentsSnapshot.docs
          .map((doc) => doc['appointmentTime'] as String)
          .toList();

      return right(reservedTimeSlots);
    } catch (e) {
      print(
          'AppointmentRepository.getReservedTimeSlotsForDoctorOnDate ERROR: $e');
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> bookAppointment({
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
      'appointmentDate': date,
      'appointmentTime': time,
      'appointmentStatus': 'pending',
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
      'appointmentDate': date,
      'appointmentTime': time,
      'appointmentStatus': 'pending',
    });
  }

  @override
  Future<Either<Failure, List<ClientAppointmentsModel>?>>
      fetchClientAppointmentsWithDoctorDetails() async {
    try {
      final clientId = FirebaseAuth.instance.currentUser!.uid;
      //  جلب جميع المواعيد المحجوزة بواسطة الclientId
      final appointments = await _fetchAppointmentsByClientId(clientId);


       // بعمل فورلوب علي ال الحجوزات وبجيب ال doctorIds  لجميع الحجوزات
      final doctorIds = _extractUniqueDoctorIds(appointments);

      final doctorDataMap = await _fetchDoctorsDataByIds(doctorIds);



      final models = appointments.map((appointment) {
        final doctorId = appointment['doctorId'] as String;
        final doctorModel = doctorDataMap[doctorId];

        return ClientAppointmentsModel.fromJson({
          ...appointment,
          'doctorModel': doctorModel?.toJson() ?? {},
        });
      }).toList();


      return Right(models);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  Future<List<Map<String, dynamic>>> _fetchAppointmentsByClientId(
      String clientId) async {


    final snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('clientId', isEqualTo: clientId)
        .orderBy('appointmentDate')
        .get();



    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['appointmentId'] = doc.id;
      return data;
    }).toList();
  }
  @override
  deleteAppointment({required String appointmentId,required String doctorId})async{
     try{
       await FirebaseFirestore.instance
           .collection('appointments')
           .doc(appointmentId)
           .delete();
       // حذف من تحت الدكتور
       await FirebaseFirestore.instance
           .collection('doctors')
           .doc(doctorId)
           .collection('appointments')
           .doc(appointmentId)
           .delete();

       return right(null);
     }catch(e){
       print('AppointmentRepository.deleteAppointmentId  $e');
       return left(ServerFailure(catchError: e));
    }

  }
  List<String> _extractUniqueDoctorIds(
      List<Map<String, dynamic>> appointments) {
    return appointments
        .map((appointment) => appointment['doctorId'] as String)
        .toSet()
        .toList();
  }

  Future<Map<String,DoctorModel>> _fetchDoctorsDataByIds(
      List<String> doctorIds) async {
    if (doctorIds.isEmpty) {
      return {};
    }
    final snapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where(FieldPath.documentId, whereIn: doctorIds)
        .get();


    return {
      for (var doc in snapshot.docs)
        doc.id: DoctorModel.fromJson(doc.data())
    };
  }

}
