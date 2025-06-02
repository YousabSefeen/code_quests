import 'package:flutter/material.dart';

import '../../data/models/client_appointments_model.dart';
import 'booked_appointment_widgets/booked_appointment_footer.dart';
import 'booked_appointment_widgets/booked_appointment_header.dart';
import 'booked_appointment_widgets/cancel_button.dart';
import 'booked_appointment_widgets/reschedule_button.dart';

class AppointmentCard extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black12),
      ),
      child: Column(
        children: [
          BookedAppointmentHeader(doctorModel: appointment.doctorModel),
          _buildDivider(),
          BookedAppointmentFooter(appointment: appointment),

        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Divider(color: Colors.black12, height: 1.7),
    );
  }


}