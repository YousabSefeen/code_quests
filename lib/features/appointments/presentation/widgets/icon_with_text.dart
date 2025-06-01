import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle textStyle;

  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey.shade600),
        const SizedBox(width: 5),
        Text(
          text,
          style: textStyle.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
