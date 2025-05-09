import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/request_state.dart';
import 'package:flutter_task/core/error/failure.dart';
import 'package:flutter_task/features/appointments/data/models/appointment_model.dart';
import 'package:flutter_task/features/doctor_list/presentation/controller/states/doctor_list_state.dart';

import '../../../../appointments/data/models/doctor_appointment_model.dart';
import '../../../data/models/doctor_list_model.dart';
import '../../../data/repository/doctor_list_repository.dart';

class DoctorListCubit extends Cubit<DoctorListState> {
  final DoctorListRepository doctorListRepository;

  DoctorListCubit({
    required this.doctorListRepository,
  }) : super(const DoctorListState());

  Future getDoctorList() async {
    final Either<Failure, List<DoctorListModel>> response =
        await doctorListRepository.getDoctorList();

    response.fold(
      (failure) => emit(
        state.copyWith(
          doctorListState: RequestState.error,
          doctorListError: failure.toString(),
        ),
      ),
      (List<DoctorListModel> doctorList) => emit(
        state.copyWith(
          doctorList: doctorList,
          doctorListState: RequestState.loaded,
        ),
      ),
    );
  }

  //TODO ********************************************************************************************************************************
  List<DoctorAppointmentModel> doctorAppointmentModel   = [];

  Future<void> getDoctors() async {
    try {
      //   I/flutter (18037): doc.id  HH6D1RLWQquxD0hDYFdr
      // I/flutter (18037): ddddddddddddd  {date: 06/06/2006, clientId: WVRar7SR42ZqrqwS0mRDdYYWSN02, time: 05:05 PM, status: pending}
      //
      final snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc('4zWO081HcuThwwg069u1upSR6Dj1')
          .collection('appointments')
          .get();
        snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {

        final Map<String, Object> combinedData = {
          'appointmentId': doc.id,
          'appointmentModel': doc.data(),
        };

        final ddd=DoctorAppointmentModel.fromJson(combinedData);
        print('combinedData   ${ddd.appointmentId}');
        print('date   ${ddd.appointmentModel.date}');
     //   return DoctorAppointmentModel.fromJson(combinedData);

      }).toList();

    } catch (e) {
      print('DoctorProfileCubit.catch $e');
    }
  }

  Future<void> createDoctorAppointment({required String doctorId}) async {
    final appointmentId =
        FirebaseFirestore.instance.collection('appointments').doc().id;

    final clientId = FirebaseAuth.instance.currentUser!.uid;
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
      'clientId': clientId,
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
