import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/themes/app_colors.dart';

class SuffixIconButton extends StatelessWidget {
  final bool? isDaysField;
  final void Function() onPressed;

  const SuffixIconButton({
    super.key,
    this.isDaysField=false,
    required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(

          isDaysField==true? Icons.calendar_month_outlined: Icons.access_alarm_outlined ,
          size: 23.sp, color: AppColors.black),
      onPressed:  onPressed,
    );
  }
}
