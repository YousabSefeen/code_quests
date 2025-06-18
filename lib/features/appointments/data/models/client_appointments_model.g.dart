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
      appointmentId: json['appointmentId'] as String,
          patientName: json['patientName'] as String ,
          patientGender: json['patientGender'] as String ,
          patientAge: json['patientAge'] as String ,
           patientProblem: json['patientProblem'] as String ,
      appointmentDate: json['appointmentDate'] as String,
      appointmentTime: json['appointmentTime'] as String,
      appointmentStatus: json['appointmentStatus'] as String,
      doctorModel:
          DoctorModel.fromJson(json['doctorModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientAppointmentsModelToJson(
        ClientAppointmentsModel instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'appointmentDate': instance.appointmentDate,
      'appointmentTime': instance.appointmentTime,
      'appointmentStatus': instance.appointmentStatus,
      'clientId': instance.clientId,
      'doctorId': instance.doctorId,
      'doctorModel': instance.doctorModel.toJson(),
    };


/*
  // patientName: json['patientName'] as String??'',
         // patientGender: json['patientGender'] as String?,
         // patientAge: json['patientAge'] as String?,
         //  patientProblem: json['patientProblem'] as String?,
 */