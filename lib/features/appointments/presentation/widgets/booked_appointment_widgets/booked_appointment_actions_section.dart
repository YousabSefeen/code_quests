

import 'package:flutter/material.dart';
import 'package:flutter_task/features/appointments/presentation/widgets/booked_appointment_widgets/appointment_reschedule_button.dart';

import '../../../data/models/client_appointments_model.dart';
import 'cancel_button.dart';


class BookedAppointmentActionsSection extends StatelessWidget {
  final ClientAppointmentsModel appointment;
  const BookedAppointmentActionsSection({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CancelButton(),
          AppointmentRescheduleButton(appointment: appointment),
        ],
      ),
    );
  }
}
