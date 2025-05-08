import 'package:json_annotation/json_annotation.dart';

import '../../../doctor_profile/data/models/doctor_model.dart';

part 'doctor_list_model.g.dart';

@JsonSerializable()
class DoctorListModel {
  final String doctorId;
  final DoctorModel doctorModel;

  DoctorListModel({required this.doctorId, required this.doctorModel});

  factory DoctorListModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorListModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorListModelToJson(this);
}
