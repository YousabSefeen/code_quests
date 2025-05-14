import 'package:flutter_task/features/appointments/data/models/appointment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_appointment_model.g.dart';

@JsonSerializable()
class DoctorAppointmentModel {
  final String appointmentId;

  final AppointmentModel appointmentModel;

  DoctorAppointmentModel(
      {required this.appointmentId, required this.appointmentModel});

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentModelToJson(this);
}
