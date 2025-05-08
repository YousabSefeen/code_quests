import 'package:flutter/material.dart';

import '../../../../core/constants/themes/app_colors.dart';

class AppointmentBookingButton extends StatelessWidget {
  const AppointmentBookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 14),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          backgroundColor: WidgetStatePropertyAll(AppColors.green),
          foregroundColor: WidgetStatePropertyAll(AppColors.white),
          overlayColor: const WidgetStatePropertyAll(Colors.grey),
        ),
        onPressed: () {},
        child: const Text('View Availability & Book'),
      ),
    );
  }
}
