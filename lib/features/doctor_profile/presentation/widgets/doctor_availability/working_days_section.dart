import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/form_controllers/doctor_profile_validator.dart';

import '../../controller/cubit/doctor_profile_cubit.dart';
import '../../controller/states/doctor_profile_state.dart';
import '../selected_days_container.dart';

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
              DoctorProfileValidator().validateWorkingDays(isWorkingDaysEmpty),
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
                if (field.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 8.w),
                    child: Text(
                      field.errorText!,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
