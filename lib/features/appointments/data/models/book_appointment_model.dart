

import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_model.g.dart';

@JsonSerializable()
class BookAppointmentModel{

  final String doctorId;
  final String clientId;
  final String date;
  final String time;
  final String status;

  BookAppointmentModel({required this.doctorId, required this.clientId, required this.date, required this.time, required this.status});
  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentModelToJson(this);
}