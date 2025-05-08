// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorListModel _$DoctorListModelFromJson(Map<String, dynamic> json) =>
    DoctorListModel(
      doctorId: json['doctorId'] as String,
      doctorModel:
          DoctorModel.fromJson(json['doctorModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DoctorListModelToJson(DoctorListModel instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'doctorModel': instance.doctorModel,
    };
