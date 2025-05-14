import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final void Function() onPressed;

  const CustomButton(
      {super.key,
      required this.isLoading,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return SizedBox(
      width: deviceSize.width * 0.5,
      height: deviceSize.height * 0.06,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: WidgetStatePropertyAll(2),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: WidgetStatePropertyAll(AppColors.darkBlue),
            overlayColor: WidgetStatePropertyAll(AppColors.grey),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
                side: BorderSide(color: Colors.black12)))),
        onPressed: onPressed,
        child: isLoading
            ? CircularProgressIndicator(
                color: AppColors.darkBlue,
              )
            : FittedBox(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5),
                ),
              ),
      ),
    );
  }
}
