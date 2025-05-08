import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  final String imageUrl;
  final String name;
  final String specialization;
  final String bio;

  final String location;
  final List<String> workingDays;
  final String? availableFrom;
  final String? availableTo;
  final int fees;

  DoctorModel({
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
  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}
