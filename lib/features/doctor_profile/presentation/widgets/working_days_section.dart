import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/form_controllers/doctor_fields_validator.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/selected_days_container.dart';

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';

class WorkingDaysSection extends StatelessWidget {
  const WorkingDaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
      selector: (state) => state.confirmedWorkingDays,
      builder: (context, confirmedDays) {
        final isWorkingDaysEmpty = confirmedDays.isEmpty;

        return FormField<List<String>>(
          validator: (_) =>
              DoctorFieldsValidator().validateWorkingDays(isWorkingDaysEmpty),
          builder: (field) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectedDaysContainer(
                  isWorkingDaysEmpty: isWorkingDaysEmpty,
                  confirmedDays: confirmedDays,
                  field: field,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
