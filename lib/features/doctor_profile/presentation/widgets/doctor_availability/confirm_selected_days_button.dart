import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/cubit/doctor_profile_cubit.dart';




class ConfirmSelectedDaysButton extends StatelessWidget {
  const ConfirmSelectedDaysButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<DoctorProfileCubit>().confirmWorkingDaysSelection();
        AppRouter.popWithKeyboardDismiss(context);
      },
      style: ButtonStyle(
        padding:
        const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 15,vertical: 10)),
        backgroundColor: const WidgetStatePropertyAll(Colors.green),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        overlayColor: const WidgetStatePropertyAll(Colors.white70),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),
      child: Text(
         AppStrings.confirm,
        style: GoogleFonts.roboto(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 1.2
        ),
      ),
    );
  }
}