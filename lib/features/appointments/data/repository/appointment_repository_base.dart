import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/client_appointments_model.dart';
import '../models/doctor_appointment_model.dart';

abstract class AppointmentRepositoryBase {
  Future<Either<Failure, List<DoctorAppointmentModel>>> fetchDoctorAppointments({
    required String doctorId,
  });

  Future<Either<Failure, List<String>>> fetchReservedTimeSlotsForDoctorOnDate({
    required String doctorId,
    required String date,
  });

  Future<Either<Failure, void>> createAppointmentForDoctor({
    required String doctorId,
    required String date,
    required String time,
  });

  Future<Either<Failure, List<ClientAppointmentsModel>?>>
      fetchClientAppointmentsWithDoctorDetails();
}
