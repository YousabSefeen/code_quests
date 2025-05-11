
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';

class AppAlerts {
  static showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 20,
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        content: Text(
          errorMessage,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            height: 1.6,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  static showRegisterErrorSnackBar(
      {required BuildContext context,
      required Widget content,
      required String errorMessage,
      String? userEmail}) {
    final emailAlreadyInUseError =
        'This email address is already in use. If it’s your account, try logging in.';

    final isValidEmailMessage = errorMessage != emailAlreadyInUseError;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 20,
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        duration: isValidEmailMessage
            ? const Duration(seconds: 2)
            : const Duration(seconds: 20),
        content: content,
      ),
    );
  }

  static customDialog({required BuildContext context, required Widget body}) {
    showDialog(
      context: context,


      builder: (context) => body,
    );
  }

 static void showAppointmentSuccessDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Book Appointment',
      transitionDuration: const Duration(milliseconds:800),
      pageBuilder: (context, _, __) {
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        });

        return Align(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                AppStrings.successMessage,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, _, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation1,
            curve: Curves.easeOutBack,
          ),
          child: child,
        );
      },
    );
  }
}
