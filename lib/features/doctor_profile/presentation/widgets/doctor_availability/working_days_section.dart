import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/doctor_availability/suffix_icon_button.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/doctor_availability/working_day_checkbox_tile.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/doctor_availability/working_days_dialog_header.dart';

import '../../controller/cubit/doctor_profile_cubit.dart';
import '../../controller/states/doctor_profile_state.dart';
import '../custom_field_container.dart';
import 'confirm_working_days_button.dart';

class WorkingDaysSection extends StatelessWidget {
  const WorkingDaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
      selector: (state) => state.confirmedWorkingDays,
      builder: (context, confirmedDays) {
        final isFieldEmpty = confirmedDays.isEmpty;

        return FormField<List<String>>(
          validator: (_) =>
              isFieldEmpty ? AppStrings.workingDaysValidationMessage : null,
          builder: (field) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SelectedDaysContainer(
                  isFieldEmpty: isFieldEmpty,
                  confirmedDays: confirmedDays,
                  field: field,
                  onPressed: () => _showDaySelectionDialog(context),
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

  void _showDaySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
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
          actions: const [
            ConfirmButton(),
          ],
        ),
      ),
    );
  }
}

class _SelectedDaysContainer extends StatelessWidget {
  final bool isFieldEmpty;
  final List<String> confirmedDays;

  final FormFieldState<List<String>> field;
  final VoidCallback onPressed;

  const _SelectedDaysContainer({
    required this.isFieldEmpty,
    required this.confirmedDays,
    required this.field,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomFieldContainer(
      isFieldHasError: field.hasError,
      child: Row(
        children: [
          Expanded(
            child: isFieldEmpty
                ? Text(
                    AppStrings.workingDaysHint,
                    style: textTheme.hintFieldStyle,
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: confirmedDays
                        .map(
                          (day) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade400,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Text(
                              day,
                              style: textTheme.styleField.copyWith(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          SuffixIconButton(isDaysField: true, onPressed: onPressed),
        ],
      ),
    );
  }
}
