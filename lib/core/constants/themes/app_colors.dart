import 'package:flutter/material.dart';

class AppColors {
  static Color white = const Color(0xffffffff);
  static Color grey = Colors.grey;
  static Color black = const Color(0xff000000);
  static Color green = const Color(0xff66BB6A);
  static Color red = const Color(0xffF93827);
  static Color customBlue = const Color(0xff427D9D);
  static Color softBlue = const Color(0xff7C93C3);
  static const Color darkBlue = Color(0xff001F3F);
  static const Color coolBlue = Color(0xff001F3F);
  static Color customLightBlue = const Color(0xff9BBEC8);
  static Color customDarkBlue = const Color(0xff164863);
  static Color customGreen = Colors.greenAccent;
  static Color customWhite = const Color(0xffEEF5FF);
  static const List<Color> gradientAnimationColor = [
    /*
    AppColors.darkBlue,
    Color(0xff7C93C3),
    AppColors.darkBlue,
     */

    AppColors.darkBlue,
    AppColors.darkBlue,
    Color(0xff7C93C3),
    Color(0xff7C93C3),
    AppColors.darkBlue,
  ];

  static const List<Color> borderGradientAnimationColor = [
    Colors.white38,
    AppColors.darkBlue,
    AppColors.darkBlue,
    AppColors.darkBlue,
    Colors.white38,
  ];
}
