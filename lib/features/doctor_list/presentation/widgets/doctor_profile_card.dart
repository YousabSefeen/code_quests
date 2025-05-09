import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_assets/app_assets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/info_icon_with_text.dart';
import '../../../doctor_list/presentation/widgets/appointment_booking_button.dart';
import 'doctor_location_display.dart';
import 'doctor_profile_header.dart';

class DoctorProfileCard extends StatelessWidget {
  const DoctorProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            imageUrl: AppAssets.images[0],
            name: 'Dr Yousab Sefeen',
            bio:
                'Specialist in heart diseases and hypertension,with over 8 years of experience.',
          ),
          const DoctorLocationDisplay(location: 'Cairo Heart Center'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 12),
              InfoIconWithText(
                icon: FontAwesomeIcons.clockRotateLeft,
                title: 'Waiting Time',
                subtitle: '15 min',
              ),
              InfoIconWithText(
                icon: FontAwesomeIcons.dollarSign,
                title: 'Consultation Fee',
                subtitle: '200 EGP',
              ),
            ],
          ),
          const AppointmentBookingButton(doctorId: '',),
        ],
      ),
    );
  }
}
