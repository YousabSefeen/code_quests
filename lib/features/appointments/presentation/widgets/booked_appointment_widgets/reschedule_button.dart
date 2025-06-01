import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';

import '../../../../../core/constants/app_strings/app_strings.dart';

class RescheduleButton extends StatelessWidget {
  const RescheduleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
            overlayColor: const WidgetStatePropertyAll(Colors.white),
          ),
      onPressed: () {},
      child: const Text(AppStrings.reschedule),
    );
  }
}
