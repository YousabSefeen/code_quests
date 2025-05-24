import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_task/features/doctor_profile/presentation/widgets/working_days_selector_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../core/animations/my_custom_modal_type.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/common_widgets/circular_dropdown_icon.dart';
import 'working_days_dialog_header.dart';

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
            child: const WorkingDaysSelectorSheet(),
          )
        ],
        onModalDismissedWithBarrierTap: () {
          debugPrint('Closed modal sheet with barrier tap');
          Navigator.of(context).pop();
        },
      );
}
