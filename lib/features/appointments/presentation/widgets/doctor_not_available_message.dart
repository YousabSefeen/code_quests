import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import '../../../../core/constants/app_strings/app_strings.dart';

class DoctorNotAvailableMessage extends StatelessWidget {
  const DoctorNotAvailableMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final smallOrangeMedium = Theme.of(context).textTheme.smallOrangeMedium;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.orange.shade600,
            size: 25.sp,
          ),
          Expanded(
              child: Text.rich(
            TextSpan(
              text: AppStrings.doctorNotAvailableMessage[0],
              style: smallOrangeMedium,
              children: [
                TextSpan(
                  text: AppStrings.doctorNotAvailableMessage[1],
                  style: smallOrangeMedium.copyWith(color: AppColors.softBlue),
                ),
                TextSpan(
                  text: AppStrings.doctorNotAvailableMessage[2],
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
