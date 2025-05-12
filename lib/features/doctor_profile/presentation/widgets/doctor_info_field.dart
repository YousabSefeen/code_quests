import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorInfoField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;

  final String? hintText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  const DoctorInfoField({
    super.key,
    required this.label,
      this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,

    this.hintText,
    this.suffixIcon,
    this.validator
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
            style: GoogleFonts.actor(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 1.5),
            controller: controller,
            readOnly: suffixIcon!=null,
            keyboardType: keyboardType,
            maxLines: maxLines,
          validator:   validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.actor(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
              ),
              fillColor: Colors.white,
              filled: true,
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
