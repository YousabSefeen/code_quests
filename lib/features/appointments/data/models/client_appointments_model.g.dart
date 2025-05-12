// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_appointments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientAppointmentsModel _$ClientAppointmentsModelFromJson(
        Map<String, dynamic> json) =>
    ClientAppointmentsModel(
      clientId: json['clientId'] as String,
      doctorId: json['doctorId'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      imageUrl: json['imageUrl'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$ClientAppointmentsModelToJson(
        ClientAppointmentsModel instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'doctorId': instance.doctorId,
      'name': instance.name,
      'specialization': instance.specialization,
      'imageUrl': instance.imageUrl,
      'date': instance.date,
      'time': instance.time,
      'status': instance.status,
    };
