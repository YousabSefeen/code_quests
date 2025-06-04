import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import '../../../data/models/client_appointments_model.dart';
import '../icon_with_text.dart';

class BookedAppointmentInfoSection extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const BookedAppointmentInfoSection({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final dateTimeBlackStyle = Theme.of(context).textTheme.dateTimeBlackStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDateInfo(dateTimeBlackStyle),
        _buildTimeInfo(dateTimeBlackStyle),
        _buildStatusInfo(dateTimeBlackStyle),
      ],
    );
  }

  Widget _buildDateInfo(TextStyle textStyle) => IconWithText(
        icon: Icons.calendar_month,
        text: appointment.appointmentDate,
        textStyle: textStyle,
      );

  Widget _buildTimeInfo(TextStyle textStyle) => IconWithText(
        icon: Icons.alarm,
        text: appointment.appointmentTime,
        textStyle: textStyle,
      );

  Widget _buildStatusInfo(TextStyle textStyle) => IconWithText(
        icon: Icons.circle_rounded,
        text: appointment.appointmentStatus,
        textStyle: textStyle,
      );
}
