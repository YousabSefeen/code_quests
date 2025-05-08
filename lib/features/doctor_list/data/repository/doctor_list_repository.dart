




import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../doctor_profile/data/models/doctor_model.dart';
import 'doctor_list_repository_base.dart';

  class DoctorListRepository  extends DoctorListRepositoryBase{
  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctors() {
    // TODO: implement getAllDoctors
    throw UnimplementedError();
  }



}