import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/cubit/doctor_profile_cubit.dart';

class ConfirmSelectedDaysButton extends StatelessWidget {
  const ConfirmSelectedDaysButton({super.key});

  @override
  Widget build(BuildContext context) {
    return    Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width * 0.35,
      margin: const EdgeInsets.only(bottom: 15, right: 10),
      child: TextButton(
        onPressed: () {
          context.read<DoctorProfileCubit>().confirmWorkingDaysSelection();
          AppRouter.popWithKeyboardDismiss(context);
        },
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(1),
          padding:
          const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 15,vertical: 10)),
          backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          overlayColor: const WidgetStatePropertyAll(Colors.white70),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }
}