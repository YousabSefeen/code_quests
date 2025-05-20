import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/constants/themes/app_colors.dart';

class WorkingDaysDialogHeader extends StatelessWidget {
  const WorkingDaysDialogHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => AppRouter.popWithKeyboardDismiss(context),
            icon: CircleAvatar(
              radius: 13.r,
              backgroundColor: AppColors.customWhite,
              child: Icon(Icons.arrow_back, color: Colors.black, size: 18.sp),
            ),
          ),
          Expanded(
            child: Text(
              AppStrings.workingDaysDialogTitle,
              style: Theme.of(context).textTheme.dialogTitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
