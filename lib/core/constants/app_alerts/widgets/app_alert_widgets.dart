import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../themes/app_colors.dart';

class AppAlertWidgets {
  static SnackBar errorSnackBar(String errorMessage) {
    return SnackBar(
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
    );
  }

  static SnackBar registerSnackBar({
    required Widget content,
    required String errorMessage,
  }) {
    final emailAlreadyInUseError =
        'This email address is already in use. If it’s your account, try logging in.';
    final isValidEmailMessage = errorMessage != emailAlreadyInUseError;

    return SnackBar(
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
    );
  }

  static Widget successDialogContent(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        message,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
