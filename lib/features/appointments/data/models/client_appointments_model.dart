import 'package:json_annotation/json_annotation.dart';

import '../../../doctor_profile/data/models/doctor_model.dart';

part 'client_appointments_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ClientAppointmentsModel {
  final String appointmentId;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus;
  final String clientId;
  final String doctorId;

  final DoctorModel doctorModel;
  ClientAppointmentsModel(
      {
        required this.appointmentId,
        required this.clientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
    required this.doctorModel,
  });

  factory ClientAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      _$ClientAppointmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientAppointmentsModelToJson(this);
}
