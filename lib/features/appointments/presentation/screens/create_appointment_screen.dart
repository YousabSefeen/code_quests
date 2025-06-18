import 'package:flutter/material.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart';
import 'package:flutter_task/features/doctor_profile/data/models/doctor_model.dart';
import 'package:flutter_task/features/shared/models/doctor_schedule_model.dart';

import '../../../../core/constants/common_widgets/consultation_fee_and_wait_row.dart';
import '../widgets/book_appointment_button.dart';
import '../widgets/doctor_info_header.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor =
        ModalRoute.of(context)!.settings.arguments as DoctorModel;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomSliverAppBar(
                doctorName: doctor.name,
                doctorImage: doctor.imageUrl,
                specialization: doctor.specialization,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      const SizedBox(height: 5),
                      DoctorInfoHeader(doctorInfo: doctor),
                      ConsultationFeeAndWaitRow(
                        fee: doctor.fees.toString(),
                      ),
                      const Divider(color: Colors.black12,thickness: 1.7),
                      DoctorAppointmentBookingSection(
                        doctorSchedule: DoctorScheduleModel(
                          doctorId: doctor.doctorId!,
                          doctorAvailability: doctor.doctorAvailability,
                        ),
                      ),
                      BookAppointmentButton(
                        doctorModel: doctor,
                        doctorId: doctor.doctorId!,
                      ),
                    ],
                  ),
                ),
              ])),
            ],
          ),
        ),
      ),
      //   bottomNavigationBar: BookAppointmentButton(doctorId: doctor.doctorId),
    );
  }
}
