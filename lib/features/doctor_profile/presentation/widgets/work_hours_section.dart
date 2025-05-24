import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/form_controllers/doctor_profile_validator.dart';

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'custom_field_container.dart';
import 'work_hours_selector.dart';

class WorkHoursSection extends StatelessWidget {
  const WorkHoursSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState,
        Map<String, String>>(
      selector: (state) => state.workHoursSelected,
      builder: (context, workHoursSelected) => FormField(
        validator: (_) =>
            DoctorProfileValidator().validateWorkingHours(workHoursSelected),
        builder: (field) => CustomFieldContainer(
          field: field,
          child: const WorkHoursSelector(),
        ),
      ),
    );
  }
}
