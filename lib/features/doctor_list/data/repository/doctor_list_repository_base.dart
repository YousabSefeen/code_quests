import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/doctor_list_model.dart';

abstract class DoctorListRepositoryBase {
  Future<Either<Failure, List<DoctorListModel>>> getDoctorList();
}
