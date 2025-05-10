import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/custom_action_button.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/doctor_booking_availability_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/doctor_list_model.dart';
import 'doctor_location_display.dart';
import 'doctor_profile_header.dart';
import 'info_icon_with_text.dart';

class DoctorListView extends StatelessWidget {
  final List<DoctorListModel> doctorList;

  const DoctorListView({super.key, required this.doctorList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctorList.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        final DoctorListModel doctor = doctorList[index];

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
              DoctorProfileHeader(
                imageUrl: doctor.doctorModel.imageUrl,
                name: doctor.doctorModel.name,
                bio: doctor.doctorModel.bio,
              ),
              DoctorLocationDisplay(location: doctor.doctorModel.location),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 12),
                  const InfoIconWithText(
                    icon: FontAwesomeIcons.clockRotateLeft,
                    title: 'Waiting Time',
                    subtitle: '15 min',
                  ),
                  InfoIconWithText(
                    icon: FontAwesomeIcons.dollarSign,
                    title: 'Consultation Fee',
                    subtitle: doctor.doctorModel.fees.toString(),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: CustomActionButton(
                  text: 'View Availability & Book',
                  onPressed: () => AppRouter.pushNamed(
                      context,
                      AppRouterNames.appointmentBooking,
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
