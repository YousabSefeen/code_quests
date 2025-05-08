import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/doctor_list/presentation/controller/states/doctor_list_state.dart';

import '../../../data/models/doctor_list_model.dart';
import '../../../data/repository/doctor_list_repository.dart';

class DoctorListCubit extends Cubit<DoctorListState> {
  final DoctorListRepository doctorListRepository;


  DoctorListCubit({required this.doctorListRepository})
      : super(DoctorListState.initial());


  List<DoctorListModel> doctors = [];

  Future<void>  getDoctors()async{
    try {

      // final QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
      // await FirebaseFirestore.instance.collection('doctors').get();

      // for (var doc in doctorsSnapshot.docs) {
      //
      // }
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('doctors').get();

      doctors = snapshot.docs.map((doc) {



        final combinedData =  {

          'doctorId': doc.id,
          'doctorModel': doc.data(), // assuming you have a nested `UserModel user` field
        };
        return DoctorListModel.fromJson(combinedData);
      }).toList();
      //   print('Number One== \n ${doctors[0].fees} ');
      print('doctorId == \n ${doctors[0].doctorId} ');
      print('doctorModel== \n ${doctors[0].doctorModel.bio} ');
    }  catch (e) {
      print('DoctorProfileCubit.catch $e');
    }
  }

}
