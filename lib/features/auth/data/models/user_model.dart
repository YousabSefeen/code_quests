import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String phone;
  final String email;
  final String role;
  final FieldValue createdAt;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  /// من JSON إلى كائن
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// من كائن إلى JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
