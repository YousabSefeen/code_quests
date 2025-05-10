import 'package:flutter/material.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/custom_date_time_line.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:flutter_task/features/doctor_profile/data/models/doctor_model.dart';

import '../../../../core/constants/common_widgets/consultation_fee_and_wait_row.dart';
import '../../../doctor_list/data/models/doctor_list_model.dart';
import '../widgets/doctor_info_header.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final DoctorListModel doctor =
        ModalRoute.of(context)!.settings.arguments as DoctorListModel;

    final DoctorModel doctorInfo = doctor.doctorModel;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
                doctorName: doctorInfo.name,
                doctorImage: doctorInfo.imageUrl,
                specialization: doctorInfo.specialization),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  spacing: 10,
                  children: [
                    const SizedBox(height: 5),
                    DoctorInfoHeader(doctorInfo: doctorInfo),
                    const SizedBox(height: 10),
                    ConsultationFeeAndWaitRow(   fee: doctorInfo.fees.toString()),
                    CustomDateTimeLine(doctor: doctor),
                  ],
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }




}
