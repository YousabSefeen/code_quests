import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/features/shared/models/doctor_schedule_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../../core/animations/custom_modal_type_bottom_sheet.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../doctor_profile/presentation/widgets/working_days_dialog_header.dart';
import '../doctor_appointment_booking_section.dart';

class RescheduleButton extends StatelessWidget {
  final DoctorScheduleModel doctorSchedule;

  const RescheduleButton({super.key, required this.doctorSchedule});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
            overlayColor: const WidgetStatePropertyAll(Colors.white),
          ),

      onPressed: () => AppAlerts.showCustomBottomSheet(
            context: context,
            title: AppStrings.reschedule,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                spacing: 30,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('When would you like to come?',style: Theme.of(context).textTheme.styleField.copyWith(
                    fontSize: 18.sp,

                    fontWeight: FontWeight.w700
                  ),),
                  DoctorAppointmentBookingSection(
                      doctorSchedule: doctorSchedule,
                  ),
                ],
              ),
            )),
      child: const Text(AppStrings.reschedule),
    );
  }


}
