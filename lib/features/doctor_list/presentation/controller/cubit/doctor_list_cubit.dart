import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/doctor_list/presentation/controller/states/doctor_list_state.dart';

import '../../../../doctor_profile/data/models/doctor_model.dart';
import '../../../data/repository/doctor_list_repository.dart';

class DoctorListCubit extends Cubit<DoctorListState> {
  final DoctorListRepository doctorListRepository;


  DoctorListCubit({required this.doctorListRepository})
      : super(DoctorListState.initial());

  //TODO ********************************************************************************************************************************
  List<DoctorModel> doctors = [];

  Future<void>  getDoctors()async{
    try {

      final QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
      await FirebaseFirestore.instance.collection('doctors').get();

      for (var doc in doctorsSnapshot.docs) {
print('object  ${doc.id}');
      }

      //TODO New Test
      // final QuerySnapshot<Map<String, dynamic>> snapshot =
      // await FirebaseFirestore.instance.collection('doctors').get();
      //
      // doctors = snapshot.docs.map((doc) {
      //   return DoctorModel.fromJson(doc.data());
      // }).toList();
      // print('Number One== \n ${doctors[0].fees} ');
    }  catch (e) {
      print('DoctorProfileCubit.catch $e');
    }
  }
}
