import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import '../../../data/models/client_appointments_model.dart';
import '../icon_with_text.dart';

class BookedAppointmentInfoSection extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const BookedAppointmentInfoSection({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDateInfo(context),
        _buildTimeInfo(context),
        _buildStatusInfo(context),
      ],
    );
  }

  Widget _buildDateInfo(BuildContext context) => IconWithText(
        icon: Icons.calendar_month,
        text: appointment.appointmentDate,
        textStyle: Theme.of(context).textTheme.smallWhiteRegular,
      );

  Widget _buildTimeInfo(BuildContext context) => IconWithText(
        icon: Icons.alarm,
        text: appointment.appointmentTime,
        textStyle: Theme.of(context).textTheme.smallWhiteRegular,
      );

  Widget _buildStatusInfo(BuildContext context) => IconWithText(
        icon: Icons.circle_rounded,
        text: appointment.appointmentStatus,
        textStyle: Theme.of(context).textTheme.smallWhiteRegular,
      );
}
