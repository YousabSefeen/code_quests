import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/cubit/doctor_profile_cubit.dart';




class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<DoctorProfileCubit>().confirmWorkingDaysSelection();
        Navigator.pop(context);
      },
      style: ButtonStyle(
        padding:
        const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
        backgroundColor: const WidgetStatePropertyAll(Colors.green),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        overlayColor: const WidgetStatePropertyAll(Colors.white70),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
      ),
      child: Text(
        'Done',
        style: GoogleFonts.roboto(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 1.2
        ),
      ),
    );
  }
}