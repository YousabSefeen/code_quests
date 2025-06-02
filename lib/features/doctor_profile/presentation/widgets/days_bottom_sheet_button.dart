import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/working_days_selector_sheet.dart';

import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/common_widgets/circular_dropdown_icon.dart';

class DaysBottomSheetButton extends StatelessWidget {
  const DaysBottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => IconButton(
        icon: const CircularDropdownIcon(),
        onPressed: () => _handlePressed(context, isKeyboardVisible),
      ),
    );
  }

  void _handlePressed(BuildContext context, bool isKeyboardVisible) {
    if (isKeyboardVisible) {
      AppRouter.dismissKeyboard();

      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) {
          _showDaySelectionSheet(context);
        }
      });
    } else {
      _showDaySelectionSheet(context);
    }
  }

  /// Show  the custom BottomSheet for selecting working days.

  void _showDaySelectionSheet(BuildContext context) =>
      AppAlerts.showCustomBottomSheet(
        context: context,
        title: AppStrings.workingDaysDialogTitle,
        body: const WorkingDaysSelectorSheet(),
      );
}
