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
      spacing: 3,
      children: [
        Icon(icon, size: 18.sp, color: textStyle.color),
        Text(text, style: textStyle),
      ],
    );
  }
}
