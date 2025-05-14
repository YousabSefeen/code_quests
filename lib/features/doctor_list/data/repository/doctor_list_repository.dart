import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_task/features/doctor_list/data/models/doctor_list_model.dart';

import '../../../../core/error/failure.dart';
import 'doctor_list_repository_base.dart';

class DoctorListRepository extends DoctorListRepositoryBase {
  @override
  Future<Either<Failure, List<DoctorListModel>>> getDoctorList() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('doctors').get();

      final List<DoctorListModel> doctorList =
          snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, Object> combinedData = {
          'doctorId': doc.id,
          'doctorModel': doc.data(),
        };
        return DoctorListModel.fromJson(combinedData);
      }).toList();
      return right(doctorList);
    } catch (e) {
      print('DoctorListRepository.getAllDoctorsError $e');

      return left(ServerFailure(catchError: e));
    }
  }
}
