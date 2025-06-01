import 'package:json_annotation/json_annotation.dart';

part 'client_appointments_model.g.dart';

@JsonSerializable()
class ClientAppointmentsModel {
  final String appointmentId;
  final String clientId;
  final String doctorId;
  final String name;
  final String specialization;
  final String imageUrl;
  final String date;
  final String time;
  final String status;

  ClientAppointmentsModel(
      {
        required this.appointmentId,
        required this.clientId,
      required this.doctorId,
      required this.name,
      required this.specialization,
      required this.imageUrl,
      required this.date,
      required this.time,
      required this.status});

  factory ClientAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      _$ClientAppointmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientAppointmentsModelToJson(this);
}
