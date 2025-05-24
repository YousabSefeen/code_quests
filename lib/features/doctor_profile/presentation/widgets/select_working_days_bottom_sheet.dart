import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'doctor_availability/confirm_selected_days_button.dart';
import 'doctor_availability/working_day_checkbox_tile.dart';

class SelectWorkingDaysBottomSheet extends StatelessWidget {
  const SelectWorkingDaysBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.customWhite,
      child: BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
        selector: (state) => state.tempSelectedDays,
        builder: (context, tempDays) => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 10,
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 5,
                left: 20,
                right: 40,
              ),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: AppStrings.weekDays.length,
              itemBuilder: (context, index) {
                final day = AppStrings.weekDays[index];
                return WorkingDayCheckboxTile(
                  day: day,
                  isSelected: tempDays.contains(day),
                );
              },
            ),
            const ConfirmSelectedDaysButton(),
          ],
        ),
      ),
    );
  }
}
