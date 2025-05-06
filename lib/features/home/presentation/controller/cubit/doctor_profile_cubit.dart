import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/home/data/models/doctor_profile.dart';

import '../../../data/repository/doctor_profile_repository.dart';
import '../states/doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository doctorRepository;

  DoctorProfileCubit({required this.doctorRepository})
      : super(DoctorProfileState.initial());

  void updateAvailableTime(String formattedTime, {required bool isStartTime}) {
    if (isStartTime) {
      emit(state.copyWith(availableFromTime: formattedTime));
    } else {
      emit(state.copyWith(availableToTime: formattedTime));
    }
  }

  void toggleWorkingDay(String day) {
    final updatedDays = List<String>.from(state.tempSelectedDays);

    if (updatedDays.contains(day)) {
      updatedDays.remove(day);
    } else {
      updatedDays.add(day);
    }

    emit(state.copyWith(tempSelectedDays: updatedDays));
  }

  void confirmWorkingDaysSelection() {
    emit(state.copyWith(confirmedWorkingDays: state.tempSelectedDays));
  }

 Future<void> uploadDoctorProfile() async {


   final response=   await doctorRepository.uploadDoctorProfile(DoctorProfile(
      name: 'Yousab 97',
      specialization: 'specialization',
      bio: 'Experienced cardiologist with over 10 years in treating heart-related conditions.',
      location: 'Cairo, Egypt',
      workingDays: [ 'Saturday',
        'Sunday',
        'Monday',],
      availableFrom: '05:20 Ap',
      availableTo: '06:50 Ap',
      fees: 97,
    ));
   response.fold((failure){
     print('DoctorProfileCubit.uploadDoctorProfile failure== $failure');
   }, (success){
     print('DoctorProfileCubit.uploadDoctorProfile == success');
    });
  }
  Future<void>  getDoctors()async{
    try {

      final QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
      await FirebaseFirestore.instance.collection('doctors').get();

      for (var doc in doctorsSnapshot.docs) {
        print('Doctor ID: ${doc.id}');
        print('Doctor Data: ${doc.data()}');
      }
      // final QuerySnapshot<Map<String, dynamic>> doctors=  await FirebaseFirestore.instance
      //     .collection('doctors').get()  ;
      //
      // print('DoctorProfileCubit.getDoctors==  $doctors');
    }  catch (e) {
      print('DoctorProfileCubit.catch $e');
    }
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
/*  Future<void> createDoctorAppointment({required String doctorId })async{
    final appointmentId = FirebaseFirestore.instance.collection('appointments').doc().id;
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
        .doc('4zWO081HcuThwwg069u1upSR6Dj1')
        .collection('appointments')
        .doc(appointmentId)
        .set({
      'clientId': 'WVRar7SR42ZqrqwS0mRDdYYWSN02',
      'date': '06/06/2006',
      'time': '05:05 PM',
      'status': 'pending',
    });

// حفظ في collection العام
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .set({
      'doctorId': '4zWO081HcuThwwg069u1upSR6Dj1',
      'clientId': 'WVRar7SR42ZqrqwS0mRDdYYWSN02',
      'date': '06/06/2006',
      'time': '05:05 PM',
      'status': 'pending',
    });
  }*/


}
