import 'package:json_annotation/json_annotation.dart';

part 'doctor_profile.g.dart';

@JsonSerializable()
class DoctorProfile {
  final String imageUrl;
  final String name;
  final String specialization;
  final String bio;

  final String location;
  final List<String> workingDays;
  final String? availableFrom;
  final String? availableTo;
  final int fees;

  DoctorProfile({
    required this.imageUrl,
    required this.name,
    required this.specialization,
    required this.bio,
    required this.location,
    required this.workingDays,
    required this.availableFrom,
    required this.availableTo,
    required this.fees,
  });
  factory DoctorProfile.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorProfileToJson(this);
}
