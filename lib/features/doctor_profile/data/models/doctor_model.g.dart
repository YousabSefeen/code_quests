// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      bio: json['bio'] as String,
      location: json['location'] as String,
      workingDays: (json['workingDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      availableFrom: json['availableFrom'] as String?,
      availableTo: json['availableTo'] as String?,
      fees: (json['fees'] as num).toInt(),
    );

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'specialization': instance.specialization,
      'bio': instance.bio,
      'location': instance.location,
      'workingDays': instance.workingDays,
      'availableFrom': instance.availableFrom,
      'availableTo': instance.availableTo,
      'fees': instance.fees,
    };
