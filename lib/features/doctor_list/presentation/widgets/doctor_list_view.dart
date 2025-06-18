import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/custom_action_button.dart';

import '../../../../core/constants/common_widgets/consultation_fee_and_wait_row.dart';
import '../../../doctor_profile/data/models/doctor_model.dart';
import '../../data/models/doctor_list_model.dart';
import 'doctor_location_display.dart';
import 'doctor_profile_header.dart';

class DoctorListView extends StatelessWidget {
  final List<DoctorModel> doctorList;

  const DoctorListView({super.key, required this.doctorList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctorList.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        final DoctorModel doctor = doctorList[index];

        return Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            spacing: 5,
            children: [
              DoctorProfileHeader(doctorInfo: doctor),
              DoctorLocationDisplay(location: doctor .location),
              const SizedBox(),
              ConsultationFeeAndWaitRow(
                fee: doctor .fees.toString(),
              ),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: CustomActionButton(
                  text: 'View Availability & Book',
                  onPressed: () => AppRouter.pushNamed(
                    context,
                    AppRouterNames.createAppointment,
                    arguments: doctor,
                  ),
                  backgroundColor: AppColors.green,
                  textColor: AppColors.white,
                  borderColor: Colors.transparent,
                ),
              ),
              // AppointmentBookingButton(doctorId: doctor.doctorId),
            ],
          ),
        );
      },
    );
  }
}
