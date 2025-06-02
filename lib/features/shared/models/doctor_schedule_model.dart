


import 'package:flutter_task/features/shared/models/availability_model.dart';



class DoctorScheduleModel{

  final String doctorId;
  final DoctorAvailabilityModel  doctorAvailability;

  DoctorScheduleModel({required this.doctorId, required this.doctorAvailability});

}