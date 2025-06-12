import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import 'form_title.dart';

class DoctorInfoField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? hintText;

  final FormFieldValidator<String>? validator;

  const DoctorInfoField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTitle(label: label),
        TextFormField(
          style: textTheme.styleField
              .copyWith(fontWeight: FontWeight.w400, letterSpacing: 1),
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.hintFieldStyle,
            fillColor: Colors.grey.shade100,
            filled: true,
            border: _buildBorder(Colors.black12),
            enabledBorder: _buildBorder(Colors.grey.shade100),
            focusedBorder: _buildBorder(Colors.grey.shade100),
            errorBorder: _buildBorder(Colors.red),
            errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
