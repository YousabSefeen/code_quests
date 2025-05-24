import 'package:flutter_task/features/doctor_profile/presentation/controller/form_controllers/doctor_profile_controllers.dart';

import '../../../../../core/constants/app_strings/app_strings.dart';

class DoctorProfileValidator {
  static final DoctorProfileValidator _instance =
      const DoctorProfileValidator._internal();

  factory DoctorProfileValidator() => _instance;

  const DoctorProfileValidator._internal();

  // 🧩 Name - required and at least 5 characters
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 5) {
      return 'Name must be at least 5 characters long';
    }
    return null;
  }

  // 🧩 Specialization - required and at least 3 characters
  String? validateSpecialization(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your specialization';
    }
    if (value.trim().length < 3) {
      return 'Specialization must be at least 3 characters long';
    }
    return null;
  }

  // 🧩 Bio - required and at least 10 characters
  String? validateBio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your bio';
    }
    if (value.trim().length < 10) {
      return 'Bio must be at least 10 characters long';
    }
    return null;
  }

  // 🧩 Location - required and at least 5 characters
  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your location';
    }
    if (value.trim().length < 5) {
      return 'Location must be at least 5 characters long';
    }
    return null;
  }

  // 🧩 Working Days - required




  // 🧩 Fees - required and must be a positive number
  String? validateFees(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your consultation fees';
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return 'Fees must be a valid positive number';
    }
    return null;
  }

//  🧩 Working Days - both start and end times are required
  String? validateWorkingDays(bool isWorkingDaysEmpty) {
    if (isWorkingDaysEmpty) {
      return AppStrings.workingDaysValidationMessage;
    } else {
      return null;
    }
  }

//  🧩 Working Hours - both start and end times are required
  String? validateWorkingHours(Map<String, String> workHoursSelected) {
    if (workHoursSelected.isEmpty) {
      return 'Please select your available working hours.';
    } else {
      return null;
    }
  }

  // ✅ Optional: validate all fields together
  String? validateInputs(DoctorProfileControllers? c) {
    return validateName(c?.nameController.text) ??
        validateSpecialization(c?.specializationController.text) ??
        validateBio(c?.bioController.text) ??
        validateLocation(c?.locationController.text) ??
        validateFees(c?.feesController.text);
  }
}
