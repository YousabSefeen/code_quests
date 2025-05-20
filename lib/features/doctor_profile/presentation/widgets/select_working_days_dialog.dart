import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'doctor_availability/confirm_selected_days_button.dart';
import 'doctor_availability/working_day_checkbox_tile.dart';
import 'doctor_availability/working_days_dialog_header.dart';

class SelectWorkingDaysDialog extends StatelessWidget {
  const SelectWorkingDaysDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
      selector: (state) => state.tempSelectedDays,
      builder: (context, tempDays) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        titlePadding: EdgeInsets.zero,
        title: const WorkingDaysDialogHeader(),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: AppStrings.weekDays.length,
            itemBuilder: (context, index) {
              final day = AppStrings.weekDays[index];
              return WorkingDayCheckboxTile(
                day: day,
                isSelected: tempDays.contains(day),
              );
            },
          ),
        ),
        actions: const [ConfirmSelectedDaysButton()],
      ),
    );
  }
}
