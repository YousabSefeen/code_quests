// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentsModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      clientId: json['clientId'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AppointmentsModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'date': instance.date,
      'time': instance.time,
      'status': instance.status,
    };
