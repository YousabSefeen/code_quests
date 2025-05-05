import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorInfoField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;

  final String? hintText;
  final Widget? suffixIcon;

  const DoctorInfoField({
    super.key,
    required this.label,
      this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,

    this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15.sp, color: Colors.blue)),
          TextFormField(
            controller: controller,
            readOnly: suffixIcon!=null,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
