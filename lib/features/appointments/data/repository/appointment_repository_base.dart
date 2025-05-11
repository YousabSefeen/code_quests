import 'package:dartz/dartz.dart';
import 'package:flutter_task/features/appointments/data/models/book_appointment_model.dart';

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

  Future<Either<Failure, void>> createAppointmentForDoctor({
    required String doctorId,
    required String date,
    required String time,
  });
}
