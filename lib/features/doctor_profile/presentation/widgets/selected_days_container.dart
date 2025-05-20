import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/select_working_days_dialog.dart';

import 'custom_field_container.dart';

class SelectedDaysContainer extends StatelessWidget {
  final bool isFieldEmpty;
  final List<String> confirmedDays;
  final FormFieldState<List<String>> field;

  const SelectedDaysContainer({
    super.key,
    required this.isFieldEmpty,
    required this.confirmedDays,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFieldContainer(
      isFieldHasError: field.hasError,
      child: Row(
        children: [
          Expanded(
            child: isFieldEmpty
                ? _buildHintText(context)
                : _buildDaysWrap(context),
          ),
          _buildCalendarIcon(context),
        ],
      ),
    );
  }

  /// Build  the hint text when no working days are selected.
  Widget _buildHintText(BuildContext context) => Text(
        AppStrings.workingDaysHint,
        style: Theme.of(context).textTheme.hintFieldStyle,
      );

  /// Build  a Wrap of confirmed selected days.
  Widget _buildDaysWrap(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          confirmedDays.map((day) => _buildDayChip(context, day)).toList(),
    );
  }

  /// Build  an individual chip for a selected day.
  Widget _buildDayChip(BuildContext context, String day) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Text(
          day,
          style: Theme.of(context).textTheme.styleField.copyWith(
                color: Colors.white,
                fontSize: 14.sp,
              ),
        ),
      );

  /// Build  the calendar icon button to open the day selection dialog.
  Widget _buildCalendarIcon(BuildContext context) => IconButton(
        icon: Icon(
          Icons.calendar_month_outlined,
          size: 23.sp,
          color: AppColors.black,
        ),
        onPressed: () => _showDaySelectionDialog(context),
      );

  /// Show  the custom dialog for selecting working days.
  void _showDaySelectionDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SelectWorkingDaysDialog(),
      );
}
