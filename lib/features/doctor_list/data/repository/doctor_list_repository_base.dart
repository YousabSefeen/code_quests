



import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../doctor_profile/data/models/doctor_model.dart';

abstract class DoctorListRepositoryBase{
  Future<Either<Failure, List<DoctorModel>>>  getAllDoctors();
}