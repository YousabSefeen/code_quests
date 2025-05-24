import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class CircularDropdownIcon extends StatelessWidget {
  const CircularDropdownIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12.r,
      backgroundColor: Colors.grey.shade100,
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 25.sp,
        color: AppColors.black,
      ),
    );
  }
}
