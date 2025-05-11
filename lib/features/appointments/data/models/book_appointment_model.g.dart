// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAppointmentModel _$BookAppointmentModelFromJson(
        Map<String, dynamic> json) =>
    BookAppointmentModel(
      doctorId: json['doctorId'] as String,
      clientId: json['clientId'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$BookAppointmentModelToJson(
        BookAppointmentModel instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'clientId': instance.clientId,
      'date': instance.date,
      'time': instance.time,
      'status': instance.status,
    };
