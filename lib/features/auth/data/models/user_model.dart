import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String phone;
  final String email;
  final String role;
  final String createdAt;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.createdAt,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
