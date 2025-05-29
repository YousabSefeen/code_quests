import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/enum/lazy_request_state.dart';
import '../controller/states/appointment_state.dart';

class BookAppointmentButton extends StatelessWidget {
  final String doctorId;

  const BookAppointmentButton({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: double.infinity,
      height: 50,
      child: BlocSelector<AppointmentCubit, AppointmentState,
          Tuple2<String?, LazyRequestState>>(
        selector: (state) =>
            Tuple2(state.selectedTimeSlot, state.bookAppointmentState),
        builder: (context, values) {
          _handleBookAppointmentState(values, context);

          return ElevatedButton(
            onPressed: values.value1 == ''
                ? null
                : () => context
                    .read<AppointmentCubit>()
                    .createAppointmentForDoctor(doctorId: doctorId),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(values.value1 == ''
                  ? Colors.grey.shade300
                  : AppColors.softBlue),
              foregroundColor: WidgetStatePropertyAll(
                  values.value1 == '' ? Colors.black : Colors.white),
            ),
            child:
                values.value1 != '' && values.value2 == LazyRequestState.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Book Appointment',
                        style: GoogleFonts.raleway(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
          );
        },
      ),
    );
  }

  void _handleBookAppointmentState(
      Tuple2<String?, LazyRequestState> values, BuildContext context) {
    if (values.value2 == LazyRequestState.loaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppAlerts.showAppointmentSuccessDialog(
          context: context,
          message: AppStrings.successMessage,
        );

        Future.delayed(const Duration(milliseconds: 2500), () {
          if (!context.mounted) return;
          AppRouter.pushNamedAndRemoveUntil(
              context, AppRouterNames.doctorListView);
        });
        context.read<AppointmentCubit>().deleteData();
      });
    }
  }
}
