import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValidationMessage extends StatelessWidget {
  final String message;

  const ValidationMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 8),
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 12.sp),
      ),
    );
  }
}
