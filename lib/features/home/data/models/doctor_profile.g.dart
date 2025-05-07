// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
/*
{fees: 200, workingDays: [Saturday, Sunday, Monday], imageUrl: https://i.pinimg.com/736x/62/44/97/624497ea5ae28be78867dafce4834e1c.jpg, name: Sarah Ahmed,
 bio: Specialist in heart diseases and hypertension,
with over 8 years of experience., specialization: Cardiologist, location: Cairo Heart Center, availableFrom: 05:00 PM, availableTo: 10:00 PM}
 */
DoctorProfile _$DoctorProfileFromJson(Map<String, dynamic> json) =>
    DoctorProfile(
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

Map<String, dynamic> _$DoctorProfileToJson(DoctorProfile instance) =>
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
