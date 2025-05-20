import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppLightTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.blue,
    unselectedWidgetColor: Colors.red,
    scaffoldBackgroundColor: AppColors.customWhite,
    secondaryHeaderColor: const Color(0xffe85d04),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.softBlue,
      elevation: 0,
      titleTextStyle: GoogleFonts.saira(
        textStyle: TextStyle(
          fontSize: 22.sp,
          color: AppColors.white,
          letterSpacing: 1,
        ),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white, size: 25.sp),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 22.sp,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.shade200,
      selectionHandleColor: Colors.blue,
    ),

    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      trackVisibility: const WidgetStatePropertyAll(true),
      thumbColor: WidgetStateProperty.all(const Color(0xff4F98CA)),
      trackColor: WidgetStateProperty.all(Colors.black12),
      trackBorderColor: WidgetStateProperty.all(Colors.white),
      radius: const Radius.circular(10),
      thickness: WidgetStateProperty.all(7),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(180),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xff9BBEC8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      elevation: 8,
      shadowColor: Colors.blue.shade300,
      textStyle: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
          color: Colors.black,
          letterSpacing: 1.2,
        ),
      ),
      position: PopupMenuPosition.under,
    ),
    listTileTheme: ListTileThemeData(
        titleTextStyle: GoogleFonts.caladea(
            textStyle: TextStyle(
                fontSize: 18.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        subtitleTextStyle: TextStyle(
            fontSize: 12.sp,
            color: Colors.black54,
            height: 1.5,
            fontWeight: FontWeight.w500)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(AppColors.darkBlue),
      foregroundColor: WidgetStatePropertyAll(AppColors.white),
      overlayColor: WidgetStatePropertyAll(AppColors.grey),
      textStyle: WidgetStatePropertyAll(GoogleFonts.raleway(
          color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w700)),
    )),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 5)),
        textStyle: WidgetStatePropertyAll(GoogleFonts.raleway(
          textStyle: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2
              // color: Takes the text color from foregroundColor,
              ),
        )),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        overlayColor: const WidgetStatePropertyAll(Color(0xff427D9D)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xff164863),
      elevation: 8,
      labelStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: Colors.white,
      ),
    ),

    cardTheme: CardTheme(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shadowColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.customLightBlue,
      thickness: 2,
    ),
    checkboxTheme: CheckboxThemeData(

    )
  );
}

