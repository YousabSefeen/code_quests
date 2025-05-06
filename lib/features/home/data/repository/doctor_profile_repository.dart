import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task/core/error/failure.dart';
import 'package:flutter_task/features/home/data/models/doctor_profile.dart';
import 'package:flutter_task/features/home/data/repository/doctor_profile_repository_base.dart';

class DoctorProfileRepository extends DoctorProfileRepositoryBase {
  @override
  Future<Either<Failure, void>> uploadDoctorProfile(
      DoctorProfile doctorProfile) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(uid)
          .set(doctorProfile.toJson());
      return right(null);
    } catch (e) {

      print('_saveUserDataToFirestore $e');

      return left(ServerFailure(catchError: e));
    }
  }

  Future<void>  getDoctors()async{
  final doctors=  await FirebaseFirestore.instance
        .collection('doctors').get() as List;

  }
  Future<void> createDoctorAppointment({required String doctorId })async{
    final appointmentId = FirebaseFirestore.instance.collection('appointments').doc().id;

    final clientId= FirebaseAuth.instance.currentUser!.uid;
    // await FirebaseFirestore.instance
    //     .collection('doctors')
    //     .doc('4zWO081HcuThwwg069u1upSR6Dj1')
    //     .collection('appointments')
    //     .add({
    //   'clientId': '1111',
    //   'date': '05/05/2025',
    //   'time': '10:20 AM',
    //   'status': 'pending',
    // });

    // حفظ في subcollection تحت الدكتور
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorId)
        .collection('appointments')
        .doc(appointmentId)
        .set({
      'clientId':clientId,
      'date': '06/06/2006',
      'time': '05:05 PM',
      'status': 'pending',
    });

// حفظ في collection العام
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .set({
      'doctorId': doctorId,
      'clientId': clientId,
      'date': '06/06/2006',
      'time': '05:05 PM',
      'status': 'pending',
    });
  }


}