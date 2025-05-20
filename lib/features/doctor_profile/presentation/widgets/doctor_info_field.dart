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
  final bool isTimeFieldNull;
  final bool readOnly;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const DoctorInfoField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.hintText,
    this.isTimeFieldNull = true,
    this.readOnly = false,
    this.suffixIcon,
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
          style: textTheme.styleField,
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: readOnly && isTimeFieldNull==false
                ? textTheme.styleField
                : textTheme.hintFieldStyle,
            fillColor: Colors.white,
            filled: true,
            suffixIcon: suffixIcon,
            border: _buildBorder(Colors.black12),
            enabledBorder: _buildBorder(Colors.black12),
            focusedBorder:
            readOnly ? _buildBorder(Colors.black12) : _buildBorder(Colors.blue),
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
