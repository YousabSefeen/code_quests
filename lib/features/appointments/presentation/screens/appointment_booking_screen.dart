import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/custom_date_time_line.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../../doctor_list/data/models/doctor_list_model.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  doctor.doctorModel.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(height: 5),
              Text(
                doctor.doctorModel.name,
                style: GoogleFonts.playpenSans(
                  fontSize: 22.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                ' ${doctor.doctorModel.specialization}',
                style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    height: 1.9),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  ' ${doctor.doctorModel.bio}',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),


                CustomDateTimeLine(doctor: doctor),

            ])),
          ],
        ),
      ),
    );
  }




}
