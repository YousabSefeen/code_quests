import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/doctor_appointment_model.dart';

abstract class AppointmentRepositoryBase {
  Future<Either<Failure, List<DoctorAppointmentModel>>> getDoctorAppointments({
    required String doctorId,
  });

  Future<Either<Failure, List<String>>> getReservedTimeSlotsForDoctorOnDate({
    required String doctorId,
    required String date,
  });
}
