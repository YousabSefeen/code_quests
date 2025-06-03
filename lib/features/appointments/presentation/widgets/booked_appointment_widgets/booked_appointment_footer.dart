import 'package:flutter/material.dart';

import '../../../data/models/client_appointments_model.dart';
import 'booked_appointment_actions_section.dart';
import 'booked_appointment_info_section.dart';

class BookedAppointmentFooter extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const BookedAppointmentFooter({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        spacing: 5,
        children: [
          BookedAppointmentInfoSection(
            appointment: appointment,
          ),
          BookedAppointmentActionsSection(
            appointment: appointment,
          ),
        ],
      ),
    );
  }
}
