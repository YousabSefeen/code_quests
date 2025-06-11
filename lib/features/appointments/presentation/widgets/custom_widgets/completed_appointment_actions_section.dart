


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/common_widgets/elevated_blue_button.dart';
import '../../../../../core/constants/themes/app_colors.dart';


class CompletedAppointmentActionsSection extends StatelessWidget {
  const CompletedAppointmentActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BookAgainButton( ),
          LeaveAReviewButton(),
        ],
      ),
    );
  }
}


class BookAgainButton extends StatelessWidget {
  const BookAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
        overlayColor: const WidgetStatePropertyAll(Colors.white),

      ),
      onPressed: () {

      },
      child: const Text(AppStrings.bookAgain),
    );
  }
}


class LeaveAReviewButton extends StatelessWidget {
  const LeaveAReviewButton({super.key});

  @override
  Widget build(BuildContext context) {

    return ElevatedBlueButton(
text:AppStrings.leaveAReview,

      onPressed: () {

      },
    );
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: WidgetStatePropertyAll(AppColors.white),
        foregroundColor: WidgetStatePropertyAll(Colors.blue),
        overlayColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Colors.blue,width: 1.2),
          
        ))
      ),
      onPressed: () {

      },
      child: const Text(AppStrings.leaveAReview),
    );
  }
}

