import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

extension AppTextStyles on TextTheme {
  // Original: headlineMedium (DoctorAvailabilityTimeFields)
  TextStyle get mediumBlackBold => TextStyle(
        fontSize: 15.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        height: 1,
      );

  // Original: headlineSmall (DoctorAvailabilityTimeFields)
  TextStyle get mediumWhiteBold => TextStyle(
        color: Colors.white,
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
      );

  // Original: labelMedium (CustomDateTimeLine)
  TextStyle get smallWhiteRegular => TextStyle(
        fontSize: 12.sp,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      );

  // Original: titleMedium (DoctorList info)
  TextStyle get mediumPlaypenBold => GoogleFonts.playpenSans(
        fontSize: 14.sp,
        height: 2,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
      );

  // Original: bodySmall (AppointmentBookingScreen - CustomSliverAppBar)
  TextStyle get largeWhiteSemiBold => TextStyle(
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  // Original: bodyMedium (AppointmentBookingScreen - CustomSliverAppBar)
  TextStyle get extraLargeWhiteBold => GoogleFonts.playpenSans(
        fontSize: 22.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  // Original: bodyLarge (AppointmentBookingScreen - doctorInfo)
  TextStyle get mediumBlueBold => GoogleFonts.poppins(
        fontSize: 16.sp,
        letterSpacing: 0.05,
        fontWeight: FontWeight.w700,
        color: AppColors.softBlue,
      );

  // Original: titleSmall
  TextStyle get smallGreyMedium => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      );

  // Original: titleLarge
  TextStyle get smallOrangeMedium => TextStyle(
        fontSize: 14.sp,
        color: Colors.orange.shade800,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  // Original: headlineLarge
  TextStyle get largeBlackBold => GoogleFonts.caladea(
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  // Original: labelSmall (DoctorProfileFiled - hint)
  TextStyle get smallGreySemiBold => GoogleFonts.actor(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade600,
      );

  // Original: labelLarge (DoctorProfileFiled - hint)
  TextStyle get largeActorBold => GoogleFonts.actor(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        letterSpacing: 1.5,
      );
  TextStyle get dialogTitleStyle => GoogleFonts.playpenSans(
  fontSize: 16.sp,
  letterSpacing: 1,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  );
  TextStyle get labelFieldStyle => GoogleFonts.lato(
      fontSize: 17.sp,

      color: AppColors.blue ,
      fontWeight: FontWeight.w700,
      letterSpacing: 1
  );

  TextStyle get styleField => GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 0.5,
      );

  TextStyle get hintFieldStyle => GoogleFonts.roboto(
        fontSize: 12.sp,
        letterSpacing: 0.5,
        height: 1.5,
        color: Colors.grey.shade600,
      );
}
