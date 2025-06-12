import 'package:flutter/material.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/form_controllers/doctor_profile_validator.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/save_button.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/weekly_schedule_card.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/form_controllers/doctor_profile_controllers.dart';
import 'doctor_info_field.dart';
import 'doctor_profile_image.dart';

class DoctorProfileBody extends StatelessWidget {
  final DoctorProfileControllers doctorProfileControllers;
  final DoctorProfileValidator doctorProfileValidator;

  const DoctorProfileBody({
    super.key,
    required this.doctorProfileControllers,
    required this.doctorProfileValidator,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> fields = [
      {
        'label': AppStrings.nameLabel,
        'hint': AppStrings.nameHint,
        'controller': doctorProfileControllers.nameController,
        'validator': doctorProfileValidator.validateName,
      },
      {
        'label': AppStrings.specializationLabel,
        'hint': AppStrings.specializationHint,
        'controller': doctorProfileControllers.specializationController,
        'validator': doctorProfileValidator.validateSpecialization,
      },
      {
        'label': AppStrings.bioLabel,
        'hint': AppStrings.bioHint,
        'controller': doctorProfileControllers.bioController,
        'validator': doctorProfileValidator.validateBio,
        'maxLines': 3,
      },
      {
        'label': AppStrings.locationLabel,
        'hint': AppStrings.locationHint,
        'controller': doctorProfileControllers.locationController,
        'validator': doctorProfileValidator.validateLocation,
      },
      {
        'label': AppStrings.feesLabel,
        'hint': AppStrings.feesHint,
        'controller': doctorProfileControllers.feesController,
        'validator': doctorProfileValidator.validateFees,
        'keyboardType': TextInputType.number,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: DoctorProfileImage(),
        ),

        ...fields.map((field) => DoctorInfoField(
              label: field['label'],
              hintText: field['hint'],
              controller: field['controller'],
              validator: field['validator'],
              maxLines: field['maxLines'] ?? 1,
              keyboardType: field['keyboardType'] ?? TextInputType.text,
            )),
        const SizedBox(height: 5),
        const WeeklyScheduleCard(),

        SaveButton(controllers: doctorProfileControllers),
      ],
    );
  }
}
