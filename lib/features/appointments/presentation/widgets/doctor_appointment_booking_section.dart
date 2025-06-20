import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/appointment_time_selector.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/select_date_widget.dart';
import 'package:flutter_task/features/shared/models/availability_model.dart';

import '../../../shared/models/doctor_schedule_model.dart';
import 'book_appointment_button.dart';

class DoctorAppointmentBookingSection extends StatefulWidget {
  final DoctorScheduleModel doctorSchedule;

  const DoctorAppointmentBookingSection({
    super.key,
    required this.doctorSchedule,
  });

  @override
  State<DoctorAppointmentBookingSection> createState() =>
      _DoctorAppointmentBookingSectionState();
}

class _DoctorAppointmentBookingSectionState
    extends State<DoctorAppointmentBookingSection> {
  @override
  void initState() {
    super.initState();


    context.read<AppointmentCubit>().getAvailableDoctorTimeSlots(
          selectedDate: DateTime.now(),
          doctorSchedule:widget.doctorSchedule,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        SelectDateWidget(
            doctorSchedule:widget.doctorSchedule
        ),
        const AppointmentTimeSelector(),
        // BookAppointmentButton(doctorId: widget.doctorSchedule.doctorId),
      ],
    );
  }
}
