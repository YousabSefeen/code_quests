import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/select_working_days_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../core/animations/my_custom_modal_type.dart';
import 'custom_field_container.dart';
import 'doctor_availability/working_days_dialog_header.dart';

class SelectedDaysContainer extends StatelessWidget {
  final bool isWorkingDaysEmpty;
  final List<String> confirmedDays;
  final FormFieldState<List<String>> field;

  const SelectedDaysContainer({
    super.key,
    required this.isWorkingDaysEmpty,
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
            child: isWorkingDaysEmpty
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
        // onPressed: () => _showDaySelectionDialog(context),
        onPressed: () => _showDaySelectionSheet(context),
      );

  /// Show  the custom BottomSheet for selecting working days.

  void _showDaySelectionSheet(BuildContext context) => WoltModalSheet.show(
        context: context,
        modalTypeBuilder: (_) => MyCustomModalType(),
        barrierDismissible: true,
        pageListBuilder: (modalSheetContext) => [
          WoltModalSheetPage(
            hasSabGradient: false,
            topBar: const WorkingDaysDialogHeader(),
            isTopBarLayerAlwaysVisible: true,
            trailingNavBarWidget: IconButton(
              padding: const EdgeInsets.all(20),
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: Navigator.of(modalSheetContext).pop,
            ),
            child: const SelectWorkingDaysBottomSheet(),
          )
        ],
        onModalDismissedWithBarrierTap: () {
          debugPrint('Closed modal sheet with barrier tap');
          Navigator.of(context).pop();
        },
      );
}
