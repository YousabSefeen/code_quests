


import 'package:dartz/dartz.dart';
import 'package:flutter_task/features/home/data/models/doctor_profile.dart';

import '../../../../core/error/failure.dart';

abstract class DoctorProfileRepositoryBase{

  Future<Either<Failure, void>> uploadDoctorProfile(DoctorProfile doctorProfile);


}