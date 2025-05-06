import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppLightTheme {
  static ThemeData theme = ThemeData(



    primarySwatch: Colors.blue,
    unselectedWidgetColor: Colors.red,
    scaffoldBackgroundColor: AppColors.white,
    secondaryHeaderColor: const Color(0xffe85d04),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.customWhite,
      elevation: 0,
      titleTextStyle: GoogleFonts.permanentMarker(
        textStyle: TextStyle(
            fontSize: 22.sp, color: AppColors.customDarkBlue, letterSpacing: 2),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.customDarkBlue, size: 25.sp),
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
      trackBorderColor:
      WidgetStateProperty.all(Colors.white),
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
              letterSpacing: 1.2)),
      position: PopupMenuPosition.under,
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: GoogleFonts.caladea(
          textStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5)),
    ),
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
        overlayColor: MaterialStateProperty.all(const Color(0xff427D9D)),
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
    textTheme: TextTheme(
      bodySmall: TextStyle(
        //Email Verification Body
        fontSize: 13.sp,
        height: 2.2,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      bodyMedium: TextStyle(

        fontSize: 14.sp,
        height: 2.2,
        fontWeight: FontWeight.w600,
        color: Colors.blue,
      ),
      labelSmall: TextStyle(
        fontSize:14.sp,
        letterSpacing: 0.08,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
      labelMedium:   TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
      // headlineLarge: TextStyle(
      //   //use in   (TimePicker)
      //   color: Colors.black,
      //   fontWeight: FontWeight.bold,
      //   fontSize: 18.sp,
      // ),
      headlineSmall: TextStyle(
        //use in AddScreen (TimePicker)
        color: Colors.white,
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w400,color: Colors.black),
      titleMedium: GoogleFonts.permanentMarker(
        //TODO:Uses of texts( LogoText )
        textStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22.sp,
          color: const Color(0xff164863),
          letterSpacing: 2,
        ),
      ),
      titleLarge: GoogleFonts.caladea(
          //TODO:Uses of texts( CustomAuthField(*labelStyle*) )
          textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xff164863),
        letterSpacing: 1.5,
      )),
      titleSmall: TextStyle(
        //TODO:Uses of texts( CustomAuthField(*style*) )
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
